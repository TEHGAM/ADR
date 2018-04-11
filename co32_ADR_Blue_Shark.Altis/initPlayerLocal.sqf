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
		titleText ["<t align='center'><t size='1.6' font='PuristaBold'>Моделирование было отключено в результате чрезмерного тимкилла </t><br /> <t size='1.2' font='PuristaBold'>Это последнее предупреждение. Возродитесь, чтобы моделирование включилось и это сообщение исчезнет.</t><br /><br /><t size='0.9' font='PuristaBold'>Если вы продолжите убивать союзников, администрация TEHGAM примет меры по отношению к вам!</t></t>", "BLACK", 2, true, true];
		[]spawn{ 
			waitUntil{!alive player};
			titleFadeOut 0;
			sleep 6000;
			amountOfTKs = amountOfTKs - 1;
		};
	};
    if (amountOfTKs >= TKLimit) exitWith {
		_arrayMessage = format ["Управление отключено для игрока %1.  UID: %2", name player, getPlayerUID player];
		TKArray pushBack _arrayMessage;
		publicVariable "TKArray";
		[player, "Автоматическое сообщение сервера: управление отключено."] remoteExecCall ["sideChat", 0, false];
		titleText ["<t align='center'><t size='1.8' font='PuristaBold'>Вы превисили лимит убийств союзников. <br /> Управление отключено.</t><br /> <t size='1.2' font='PuristaBold'>Ваш ник и GUID были добавлены в логи сервера.</t><br/><br /><t size='1.0' font='PuristaBold'>Это сообщение не исчезнет и управление не появится до тех пор, пока вы не выключите ARMA3. <br/>Самый простой способ выйти - нажать ALT+F4. </t><br/><br/><t size='0.8' font='PuristaBold'>Мы, администрация TEHGAM, вправе забанить вас за TeamKill, это может произойти без дополнительного уведомелния. </t></t>", "BLACK", 2, true, true];
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
	if (_email == "admin@tehgam.com") then {
		_GlobalHint = format["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>присоединился к серверу. Чтобы принимать активное участие в жизни TEHGAM, зарегистрируйтесь на форуме www.tehgam.com.</t><br/>",
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
        hint "Вы используете оружие на базе. Будьте очень осторожны и не злоупотребляйте!";
    };
	
    deleteVehicle _projectile;
	_unitName = name _unit;
    hintC format ["%1, не стреляйте на базе!  Придержите лошадей, перестаньте стрелять, чтобы не повредить что-либо на базе.", _unitName];
}];

/*Arsenal*/
arsenalDefined = false;
gearRestriction = true;
execVM "Scripts\arsenal\arsenal.sqf";
{ 
	_x execVM "scripts\arsenal\va_west.sqf"; 
	_x addAction ["<t color='#006bb3'>Сохранить вооружение.</t>",{player setVariable ["derp_savedGear", (getUnitLoadout player)]; systemChat "Вооружение сохранено";}];
} forEach arsenalArray;

// ---------------- eventhandlers to check for gear restrictions
waitUntil {arsenalDefined};
/*For after when people pick something up from the ground*/
player addEventHandler ["Инвентарь закрыт", {[]execVM "scripts\arsenal\cleanInventory.sqf";}]; 
player addEventHandler ["Взять", {[]execVM "scripts\arsenal\cleanInventory.sqf";}]; 
/*eventhandler that triggers after closing the arsenal*/
inGameUISetEventHandler ["Действие", "
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