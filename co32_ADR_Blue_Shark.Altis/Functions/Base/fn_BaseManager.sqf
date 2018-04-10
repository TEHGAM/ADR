/*
Author:  BACONMOP
Description: For new Spawned bases

Last edited: 20/10/2017 by stanhope
Edited: Names of respawn markers + teleporter
*/
private _base = _this select 0;

// Respawn Position & markers -------------------------------
private _baseRespawnMarker = (missionConfigFile >> "Main_Aos" >> "AOs" >> _base >> "respawnPos") call BIS_fnc_getCfgData;
private _respawnMarkerPos = getMarkerPos _baseRespawnMarker;
private _basevisMarker = (missionConfigFile >> "Main_Aos" >> "AOs" >> _base >> "visMrkr") call BIS_fnc_getCfgData;
{_x setMarkerPos (getMarkerPos _baseRespawnMarker);} forEach [_basevisMarker];

private _respawnMarker = [west, _respawnMarkerPos, _basevisMarker] call BIS_fnc_addRespawnPosition;

// Create the crate -----------------------
private _arsenal = "B_CargoNet_01_ammo_F" createVehicle (getMarkerPos _baseRespawnMarker);
clearItemCargoGlobal _arsenal;
clearWeaponCargoGlobal _arsenal;
clearBackpackCargoGlobal _arsenal;
clearMagazineCargoGlobal _arsenal;
_arsenal enableRopeAttach false;
_arsenal setMass 5000;

[_arsenal, "scripts\arsenal\va_west.sqf"] remoteExec ["execVM",-2,false];
arsenalArray = arsenalArray + [_arsenal];
publicVariable "arsenalArray";

//stuf to be set on every box:
    //teleport:
	[_arsenal, ["<t color='#127a00'>Teleport To Main Base</t>","cutText ['','BLACK OUT'];sleep 2;[player,'BASE'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",200,false,true,"","('BASE' in controlledZones)", 4]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#127a00'>Teleport to USS freedom</t>",
			   "cutText ['','BLACK OUT'];sleep 2;_freedompos = getPosWorld Freedom;
			   player setPosWorld (getPosWorld carrierTPPosObj);sleep 1; cutText ['','BLACK IN'];",
			   "",150,false,false,"","typeOf player == 'B_Pilot_F'||typeOf player == 'B_Helipilot_F'||typeOf player == 'B_soldier_UAV_F' || (_this getVariable 'isZeus')", 4]] remoteExec ["addAction", -2, true];

    //view and save gear:
	[_arsenal, ["<t color='#0000ff'>Save gear</t>",{player setVariable ["derp_savedGear", (getUnitLoadout player)]; systemChat "gear saved";}, [], 202, false, true, "","", 4]] remoteExec ["addAction", -2, true];
	[_arsenal, ["<t color='#0000ff'>View Distance Settings</t>", CHVD_fnc_openDialog, [], 201, false, true, "","",4]] remoteExec ["addAction", -2, true];
	
	
// Notification ----------------------------------------

private _targetStartText = format["<t align='center' size='2.2'>Base Taken</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Good Job. We have now setup a base at that location.<br/><br/>We have provided you with some vehicles at that the new FOB.", _basevisMarker];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

// Vehicles ---------------------------------------
private ["_vehType"];
private _baseVehicles = (missionConfigFile >> "Main_Aos" >> "AOs" >> _base >> "vehicles") call BIS_fnc_getCfgData;
{
	_veh = _x select 0;
	_mkr = _x select 1;
	_timer = _x select 2;
	
	switch (_veh) do {
		case "Random_Cas_Jet":{
			_vehType = selectRandom ["B_Plane_CAS_01_dynamicLoadout_F","B_Plane_CAS_01_dynamicLoadout_F","B_Plane_CAS_01_dynamicLoadout_F","B_Plane_Fighter_01_F"];
		};
		case "Random_AA_Jet":{
			_vehType = selectRandom ["I_Plane_Fighter_04_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_AA_F"];
		};
		case "Random_Cas_Heli":{
			_vehType = selectRandom ["B_Heli_Attack_01_F","B_Heli_Attack_01_F","B_Heli_Attack_01_F","O_Heli_Attack_02_dynamicLoadout_black_F","O_Heli_Attack_02_dynamicLoadout_black_F"];
		};
		default {
			_vehType = _veh;
		};
	};
	_vehicle = _vehType createVehicle getMarkerPos _mkr;
	_vehicle setDir (markerDir _mkr);
	{_x addCuratorEditableObjects [[_vehicle], false];} forEach adminCurators;
	[_vehicle,_timer,false,AW_fnc_vSetup02,_base] spawn AW_fnc_vBaseMonitor;
		
	
}forEach _baseVehicles;


_fobStuff = (getMarkerPos _baseRespawnMarker) nearObjects 500;
{	
	if ( isObjectHidden _x ) then{
		_x hideObjectGlobal false;
	};
} forEach _fobStuff;

//FOB specific stuff
switch (_base) do {
	case "Terminal":{
	
        //service triggers
        TerminalServiceGroundTrigger setPos (getPos GuardianGroundServicePad);
        TerminalServiceAirTrigger setPos (getPos GuardianAirServicePad);

        //service pad markers
        _GuardianGroundServiceMarker = createMarker ["GuardianGroundService",(getPos GuardianGroundServicePad)];
        "GuardianGroundService" setMarkerShape "ICON";
        "GuardianGroundService" setMarkerType "b_maint";
        "GuardianGroundService" setMarkerText "Ground service";
        "GuardianGroundService" setMarkerSize [0.5, 0.5];

        _GuardianAirServiceMarker = createMarker ["GuardianAirService",(getPos GuardianAirServicePad)];
        "GuardianAirService" setMarkerShape "ICON";
        "GuardianAirService" setMarkerType "o_maint";
        "GuardianAirService" setMarkerColor "colorBLUFOR";
        "GuardianAirService" setMarkerText "Air service";
        "GuardianAirService" setMarkerSize [0.5, 0.5];

        //arsenal box actions
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Martian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'AAC_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",190,false,true,"","('AAC_Airfield' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Marathon</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Stadium'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",189,false,true,"","('Stadium' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Dirt Track</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Selakano_Town'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",187,false,true,"","('Selakano_Town' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Last Stand</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Molos_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",186,false,true,"","('Molos_Airfield' in controlledZones)",4]] remoteExec ["addAction", -2, true];
    };
	
	case "AAC_Airfield":{
	
        AACServiceTrigger setPos (getPos MartianGroundServicePad);

        _MartianGroundServiceMarker = createMarker ["MartianGroundService",(getPos MartianGroundServicePad)];
        "MartianGroundService" setMarkerShape "ICON";
        "MartianGroundService" setMarkerType "b_maint";
        "MartianGroundService" setMarkerText "Ground service";
        "MartianGroundService" setMarkerSize [0.5, 0.5];

        [_arsenal, ["<t color='#127a00'>Teleport To FOB Marathon</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Stadium'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",190,false,true,"","('Stadium' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Dirt Track</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Selakano_Town'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",189,false,true,"","('Selakano_Town' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Last Stand</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Molos_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",187,false,true,"","('Molos_Airfield' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Guardian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Terminal'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",186,false,true,"","('Terminal' in controlledZones)",4]] remoteExec ["addAction", -2, true];
    };
	
	case "Stadium":{
	
        StadiumServiceTrigger setPos (getPos MarathonGroundServicePad);

        _MarathonGroundServiceMarker = createMarker ["MarathonGroundService",(getPos MarathonGroundServicePad)];
        "MarathonGroundService" setMarkerShape "ICON";
        "MarathonGroundService" setMarkerType "b_maint";
        "MarathonGroundService" setMarkerText "Ground service";
        "MarathonGroundService" setMarkerSize [0.5, 0.5];

        [_arsenal, ["<t color='#127a00'>Teleport To FOB Martian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'AAC_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",190,false,true,"","('AAC_Airfield' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Dirt Track</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Selakano_Town'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",189,false,true,"","('Selakano_Town' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Last Stand</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Molos_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",187,false,true,"","('Molos_Airfield' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Guardian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Terminal'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",186,false,true,"","('Terminal' in controlledZones)",4]] remoteExec ["addAction", -2, true];
    };
	
	case "Molos_Airfield":{
	
        MolosServiceGroundTrigger setPos (getPos LastStandGroundServicePad);
        MolosServiceAirTrigger setPos (getPos LastStandAirServicePad);

        _LastStandGroundServiceMarker = createMarker ["LastStandGroundService",(getPos LastStandGroundServicePad)];
        "LastStandGroundService" setMarkerShape "ICON";
        "LastStandGroundService" setMarkerType "b_maint";
        "LastStandGroundService" setMarkerText "Ground service";
        "LastStandGroundService" setMarkerSize [0.5, 0.5];

        _LastStandAirServiceMarker = createMarker ["LastStandAirService",(getPos LastStandAirServicePad)];
        "LastStandAirService" setMarkerShape "ICON";
        "LastStandAirService" setMarkerType "o_maint";
        "LastStandAirService" setMarkerColor "colorBLUFOR";
        "LastStandAirService" setMarkerText "Air service";
        "LastStandAirService" setMarkerSize [0.5, 0.5];

        [_arsenal, ["<t color='#127a00'>Teleport To FOB Martian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'AAC_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",190,false,true,"","('AAC_Airfield' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Marathon</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Stadium'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",189,false,true,"","('Stadium' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Dirt Track</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Selakano_Town'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",187,false,true,"","('Selakano_Town' in controlledZones)",4]] remoteExec ["addAction", -2, true];
        [_arsenal, ["<t color='#127a00'>Teleport To FOB Guardian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Terminal'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",186,false,true,"","('Terminal' in controlledZones)",4]] remoteExec ["addAction", -2, true];
    };

	case "Corton":{
         //service triggers
        cortonGroundServiceTrigger setPos (getPos cortonGroundServicePad);
        cortonAirServiceTrigger setPos (getPos cortonAirServicePad);

        //service pad markers
        _cortonGroundServiceMarker = createMarker ["GuardianGroundService",(getPos cortonGroundServicePad)];
        "GuardianGroundService" setMarkerShape "ICON";
        "GuardianGroundService" setMarkerType "b_maint";
        "GuardianGroundService" setMarkerText "Ground service";
        "GuardianGroundService" setMarkerSize [0.5, 0.5];

        _cortonAirServiceMarker = createMarker ["GuardianAirService",(getPos cortonAirServicePad)];
        "GuardianAirService" setMarkerShape "ICON";
        "GuardianAirService" setMarkerType "o_maint";
        "GuardianAirService" setMarkerColor "colorBLUFOR";
        "GuardianAirService" setMarkerText "Air service";
        "GuardianAirService" setMarkerSize [0.5, 0.5];
     };

	default { 
	private _text = format ["ERROR with fn_BaseManager.sqf, %1 was not recognized as an FOB", _base];
	diag_log _text;
	};

};

[_arsenal] spawn {
	sleep 3; 
	_crate = (_this select 0);
	_crate setVectorUp surfaceNormal position _crate;
};

/*
Removed until Defend AOs is finished.
// Base Lost --------------------------------------

waitUntil {sleep 5;!(_base in controlledZones)};

_targetStartText = format
	[
		"<t align='center' size='2.2'>Base Lost</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>The enemy have taken the base.<br/><br/>We cannot use that location anymore until we take it back."
	];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

deleteVehicle _arsenal;
_respawnMarker call BIS_fnc_removeRespawnPosition;
*/