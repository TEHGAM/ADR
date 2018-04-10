/*
Author:

	BACONMOP

Description:

	Things that may run on both server.
	Deprecated initialization file.
*/

enableSaving false;
execVM "scripts\misc\localChecks.sqf";

//player TK counter
amountOfTKs = 0;
TKLimit = 3;

player setVariable ['timeTKd', time, false];
playerTKed = {
    if ( (player getVariable 'timeTKd' == time) || (player isKindOf "B_Helipilot_F") || (player getVariable "isZeus") ) exitWith {};
	
    amountOfTKs = amountOfTKs + 1;
    player setVariable ['timeTKd', time, false];
	
    if (amountOfTKs == (TKLimit -1)) exitWith {
        player enableSimulation false;
		titleText ["<t align='center'><t size='1.6' font='PuristaBold'>Simulation has been disabled as a result of excessive teamkilling. </t><br /> <t size='1.2' font='PuristaBold'>This is a final warning.  Respawn to re-enable simulation and make this message disappear.</t><br /><br /><t size='0.9' font='PuristaBold'>If you continue to teamkill AhoyWorld cannot be held responsible for the consequences.</t></t>", "BLACK", 2, true, true];
		[]spawn{ 
			waitUntil{!alive player};
			titleFadeOut 0;
			sleep 6000;
			amountOfTKs = amountOfTKs - 1;
		};
	};
    if (amountOfTKs >= TKLimit) exitWith {
		_arrayMessage = format ["User input of %1 got disabled.  UID: %2", name player, getPlayerUID player];
		TKArray pushBack _arrayMessage;
		publicVariable "TKArray";
		[player, "Automated server message: All my user input has been disabled."] remoteExecCall ["sideChat", 0, false];
		titleText ["<t align='center'><t size='1.8' font='PuristaBold'>You have exceeded the server limit for teamkills. <br /> All user input has been disabled.</t><br /> <t size='1.2' font='PuristaBold'>Your unique ID has been logged along with with your name.</t><br/><br /><t size='1.0' font='PuristaBold'>This message will not go away and your input will not be re-enabled. You will have to shut down ArmA. <br/>The easiest way is to press alt + f4.</t><br/><br/><t size='0.8' font='PuristaBold'>We, AhoyWorld, reserve the right to ban you for these teamkills.  this may happen without any further notice</t></t>", "BLACK", 2, true, true];
		disableUserInput true;
	};
	
	[]spawn {
        sleep 6000;
        amountOfTKs = amountOfTKs - 1;
	};
};
//------------------- client executions
//[] execVm "scripts\vehicle\crew\crew.sqf"; 			// vehicle HUD
[] execVM "scripts\misc\QS_icons.sqf";				// Icons
[] execVM "scripts\misc\diary.sqf";					// diary
[] execVM "scripts\pilotCheck.sqf"; 				// pilots only
[] execVM "scripts\misc\earplugs.sqf";				//Earplugs from the start

//------------------- Disable Arty Computer for all but FSG
enableEngineArtillery false;
if (player isKindOf "B_support_Mort_f") then {
	enableEngineArtillery true;
};

//------------------pilot spawn
if (typeOf player == "B_Helipilot_F") then{  
	private ["_spawnpos"];
	_spawnpos = getPosATL PilotSpawnPos;
	[player, _spawnpos, "Pilot spawn"] call BIS_fnc_addRespawnPosition; 	
};
	
//------------------ BIS groups
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

// Derp_revive setup
if ("derp_revive" in (getMissionConfigValue "respawnTemplates")) then {
    if (getMissionConfigValue "derp_revive_everyoneCanRevive" == 0) then {
        if (player getUnitTrait "medic") then {
            call derp_revive_fnc_drawDowned;
        };
    } else {
        call derp_revive_fnc_drawDowned;
    };
    call derp_revive_fnc_handleDamage;
    call derp_revive_fnc_diaryEntries;
    if (getMissionConfigValue "respawnOnStart" == -1) then {[player] call derp_revive_fnc_reviveActions};
};

//------------------- PLAYER protection
player addRating 10000000;

//--------------------- Squad Url Hint
private ["_infoArray","_infoSquad","_squad","_infoName","_name","_email","_count"];
_infoArray = squadParams player;
_count = count _infoArray;
if (_count > 0) then {
	_infoSquad = _infoArray select 0;
	_squad = _infoSquad select 1;
	_infoName = _infoArray select 1;
	_name = _infoName select 1;
	_email = _infoSquad select 2;

	// replace line below with your Squad xml's email
	if (_email == "staff@ahoyworld.net") then {
		_GlobalHint = format["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server, To get involved in the Ahoy World community, register an account at www.AhoyWorld.net and get stuck in!</t><br/>",
		_squad,_name];
		[_GlobalHint] remoteExec ["AW_fnc_globalHint",0,false];
	};
};

//custom scrollwheel options:
[] spawn {
	{	
		toggelGhosthawkDoorAction = _x addAction ["toggle ghosthawk-door action", {
			if (ghosthawkDoorActionEnabled) then {
				ghosthawkDoorActionEnabled = false;
				_player = _this select 1;
				["Ghosthawk door action disabled"] remoteExecCall ["hint", _player];
			} else {
				ghosthawkDoorActionEnabled = true;
				_player = _this select 1;
				["Ghosthawk door action enabled"] remoteExecCall ["hint", _player];
			};
		},[],-2,false,true,"","typeOf _this == 'B_pilot_F' || typeOf _this == 'B_helipilot_F'"];
		
		toggelSlingWeaponAction = _x addAction ["toggle sling weapon action", {
			if (slinWeaponActionEnabled) then {
				slinWeaponActionEnabled = false;
				_player = _this select 1;
				["Sling weapon action disabled"] remoteExecCall ["hint", _player];
			} else {
				slinWeaponActionEnabled = true;
				_player = _this select 1;
				["Sling weapon action enabled"] remoteExecCall ["hint", _player];
			};
		},[],-2,false,true,"","true"];
	} forEach arsenalArray;
};

//------------------ Player SafeZone
sleep 2; //to make sure the base array is defined

player addEventHandler ["FiredMan", {
    params ["_unit", "_weapon", "", "", "", "", "_projectile",""];
	
    private _deleteprojectile = false;
    {   _distance = _unit distance2D (getMarkerPos _x);
        if (_distance < 300) then {_deleteprojectile = true;};
    } forEach BaseArray;       
    if (!_deleteprojectile) exitWith {};
	
    if ( (_weapon == "CMFlareLauncher") || ((typeOf _unit == "B_soldier_UAV_F") && (vehicle _unit != _unit)) ) exitWith {};
	if (player getVariable "isZeus") exitWith {
        hint "You are standing in base and shooting.  Be vary carefull when doing this and don't absue it!";
    };
	
    deleteVehicle _projectile;
	_unitName = name _unit;
    hintC format ["%1, don't goof at base.  Hold your horses soldier, don't throw, fire or place anything inside the base.", _unitName];
}];

/*Arsenal*/
arsenalDefined = false;
gearRestriction = true;
execVM "Scripts\arsenal\arsenal.sqf";
{ 
	_x execVM "scripts\arsenal\va_west.sqf"; 
	_x addAction ["<t color='#006bb3'>Save gear</t>",{player setVariable ["derp_savedGear", (getUnitLoadout player)]; systemChat "gear saved";}];
} forEach arsenalArray;

// ---------------- eventhandlers to check for gear restrictions
waitUntil {arsenalDefined};
/*For after when people pick something up from the ground*/
player addEventHandler ["InventoryClosed", {[]execVM "scripts\arsenal\cleanInventory.sqf";}]; 
player addEventHandler ["Take", {[]execVM "scripts\arsenal\cleanInventory.sqf";}]; 
/*eventhandler that triggers after closing the arsenal*/
inGameUISetEventHandler ["Action", "
	if ( toLower (_this select 4) find 'arsenal' > -1 ) then{
		_player = _this select 0;
		[_player]spawn {
			waitUntil { sleep 0.1; isNull ( uiNamespace getVariable 'RSCDisplayArsenal' ) };
			[[], 'scripts\arsenal\cleanInventory.sqf'] remoteExec ['execVM', _this select 0, false];
		};
	};
	false
"]; 

//custom scrollwheel options
ghosthawkDoorActionEnabled = true;
slinWeaponActionEnabled = true;