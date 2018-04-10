/*
Author: 

	Quiksilver
	
Last modified: 5/09/2017 by stanhope

modified: group names, zeus stuff, general tweaks, ...

Description:

	Spawn OPFOR enemy around side objectives.
	Enemy should have backbone AA/AT + random composition.
	
	
___________________________________________*/

//---------- CONFIG
private ["_x","_pos","_flatPos","_randomPos","_enemiesArray","_infteamPatrol","_SMvehPatrol","_SMveh","_SMaaPatrol","_SMaa","_smSniperTeam","_INFTEAMS","_VEHTYPES"];

_INFTEAMS = ["OIA_InfTeam","OIA_InfTeam_AT","OIA_InfTeam_AA","OI_reconPatrol","OIA_GuardTeam"];
_VEHTYPES = ["O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F"];

_enemiesArray = [grpNull];


//---------- INFANTRY RANDOM

private _MaininfCount = 0;
	
for "_x" from 0 to (3 + (random 4)) do {

	_infteamPatrol = createGroup east;
	_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
	_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> selectRandom _INFTEAMS)] call BIS_fnc_spawnGroup;
	_MaininfCount = _MaininfCount + 1;
	_infteamPatrol setGroupIdGlobal [format ['Side-MainInf-%1', _MaininfCount]];
	[_infteamPatrol, getPos sideObj, 100] call BIS_fnc_taskPatrol;

	_enemiesArray = _enemiesArray + [_infteamPatrol];
	{_x addCuratorEditableObjects [units _infteamPatrol, false];} foreach allCurators;
	sleep 0.1;
};

//---------- SNIPER
private _sniperCount = 0;

for "_x" from 0 to 1 do {

	_smSniperTeam = createGroup east;
	_randomPos = [getPos sideObj, 500, 100, 20] call BIS_fnc_findOverwatch;
	_smSniperTeam = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
	_smSniperTeam setBehaviour "COMBAT";
	_smSniperTeam setCombatMode "RED";
	_sniperCount = _sniperCount + 1;
	_smSniperTeam setGroupIdGlobal [format ['Side-SniperTeam-%1', _sniperCount]];
	
	_enemiesArray = _enemiesArray + [_smSniperTeam];

	{_x addCuratorEditableObjects [(units _smSniperTeam), false];} foreach allCurators;
	sleep 0.1;
};

//---------- VEHICLE RANDOM	
	private _randomVicCount = 0;
	
	for "_x" from 0 to 1 do {
	
	_SMvehPatrol = createGroup east;
	private _randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
	private _SMveh = (selectRandom _VEHTYPES) createVehicle _randomPos;
	createvehiclecrew _SMveh;
	(crew _SMveh) join _SMvehPatrol;
	_randomVicCount = _randomVicCount + 1;
	_SMvehPatrol setGroupIdGlobal [format ['Side-RandomVehicle-%1', _randomVicCount]];
	
	_SMveh lock 3;
	_SMveh allowCrewInImmobile true;
	[_SMvehPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;
	
	_enemiesArray = _enemiesArray + [_SMveh] + (units _SMvehPatrol);
	{_x addCuratorEditableObjects [(units _SMvehPatrol) + [_SMveh] , false];} foreach allCurators;
	sleep 0.1;
	};



//---------- VEHICLE AA
	private _aaVicCount = 0;
	
	
_SMaaPatrol = createGroup east;

private _randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;

private _SMaa = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
waitUntil {sleep 0.5; !isNull _SMaa};
createvehiclecrew _SMaa;
(crew _SMaa) join _SMaaPatrol;
_aaVicCount = _aaVicCount + 1;
_SMaaPatrol setGroupIdGlobal [format ['Side-AAVehicle-%1', _aaVicCount]];

_SMaa lock 3;
_SMaa allowCrewInImmobile true;

[_SMaaPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;
	
{_x addCuratorEditableObjects [units _SMaaPatrol + [_SMaa], false];} foreach allCurators;
_enemiesArray = _enemiesArray + units _SMaaPatrol + [_SMaa];
sleep 0.1;

//---------- COMMON

[(units _infteamPatrol)] call AW_fnc_setSkill2;
[(units _smSniperTeam)] call AW_fnc_setSkill3;
[(units _SMaaPatrol)] call AW_fnc_setSkill4;
[(units _SMvehPatrol)] call AW_fnc_setSkill2;
	
//---------- GARRISON FORTIFICATIONS
/*	
	{
		_newGrp = [_x] call AW_fnc_buildingDefenders;
		if (!isNull _newGrp) then { 
		_enemiesArray = _enemiesArray + [_newGrp]; };
	} forEach (getPos sideObj nearObjects ["Building", 150]);
*/
_enemiesArray