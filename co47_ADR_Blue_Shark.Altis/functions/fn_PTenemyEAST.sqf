/*
Author: 

	Quiksilver
	
Last modified:

	25/04/2014

Description:

	Spawn BLUFOR enemy around side objectives.
	Enemy should have backbone AA/AT + random composition.
	
___________________________________________*/

//---------- CONFIG

#define INF_TEAMS "OIA_InfTeam","OIA_InfTeam_AT","OIA_InfTeam_AA","OI_reconPatrol","OIA_GuardTeam"
#define VEH_TYPES "O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F"
private ["_x", "_pos", "_flatPos", "_randomPos", "_enemiesArray", "_infteamPatrol", "_SMvehPatrol", "_SMveh1", "SMveh2", "_data", "_SMaaPatrol", "_SMaa", "_smSniperTeam"];
_enemiesArray = [grpNull];
_x = 0;

//---------- GROUPS

_infteamPatrol = createGroup east;
_smSniperTeam = createGroup east;
_SMvehPatrol = createGroup east;
_SMaaPatrol = createGroup east;

//---------- INFANTRY RANDOM

for "_x" from 0 to (3 + (random 4)) do {
	_randomPos = [[[getPos priorityObj1, 300], []], ["water", "out"]] call BIS_fnc_randomPos;
	_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> [INF_TEAMS] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
	[_infteamPatrol, getPos priorityObj1, 100] call BIS_fnc_taskPatrol;

	_enemiesArray = _enemiesArray + [_infteamPatrol];
};

//---------- SNIPER

for "_x" from 0 to 1 do {
	_randomPos = [getPos priorityObj1, 500, 100, 20] call BIS_fnc_findOverwatch;
	_smSniperTeam = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
	_smSniperTeam setBehaviour "COMBAT";
	_smSniperTeam setCombatMode "RED";

	_enemiesArray = _enemiesArray + [_smSniperTeam];
};

//---------- VEHICLE RANDOM

_randomPos = [[[getPos priorityObj1, 300], []], ["water", "out"]] call BIS_fnc_randomPos;
_data = [_randomPos, (random 360), ( [VEH_TYPES] call BIS_fnc_selectRandom), EAST] call bis_fnc_spawnvehicle;
_SMveh1 = _data select 0;
_SMvehPatrol = _data select 2;

_SMveh1 lock 3;
[_SMvehPatrol, getPos priorityObj1, 75] call BIS_fnc_taskPatrol;
sleep 0.1;

_enemiesArray = _enemiesArray + [_SMveh1];

//---------- VEHICLE RANDOM	

_randomPos = [[[getPos priorityObj1, 300], []], ["water", "out"]] call BIS_fnc_randomPos;
_data = [_randomPos, (random 360), ( [VEH_TYPES] call BIS_fnc_selectRandom), EAST] call bis_fnc_spawnvehicle;
_SMveh2 = _data select 0;
_SMvehPatrol = _data select 2;

_SMveh2 lock 3;
[_SMvehPatrol, getPos priorityObj1, 150] call BIS_fnc_taskPatrol;
sleep 0.1;

_enemiesArray = _enemiesArray + [_SMveh2];
sleep 0.1;
_enemiesArray = _enemiesArray + [_SMvehPatrol];

//---------- VEHICLE AA

_randomPos = [[[getPos priorityObj1, 300], []], ["water", "out"]] call BIS_fnc_randomPos;
_data = [_randomPos, (random 360), ( [VEH_TYPES] call BIS_fnc_selectRandom), EAST] call bis_fnc_spawnvehicle;
_SMaa = _data select 0;
_SMaaPatrol = _data select 2;

_SMaa lock 3;
[_SMaaPatrol, getPos priorityObj1, 150] call BIS_fnc_taskPatrol;

_enemiesArray = _enemiesArray + [_SMaaPatrol];
sleep 0.1;
_enemiesArray = _enemiesArray + [_SMaa];

//---------- COMMON

[(units _infteamPatrol)] call QS_fnc_setSkill2;
[(units _smSniperTeam)] call QS_fnc_setSkill3;
[(units _SMaaPatrol)] call QS_fnc_setSkill4;
[(units _SMvehPatrol)] call QS_fnc_setSkill2;

//---------- GARRISON FORTIFICATIONS

{
	_newGrp = [_x] call QS_fnc_garrisonFortEAST;
	if (!isNull _newGrp) then { 
		_enemiesArray = _enemiesArray + [_newGrp];
	};
} forEach (getPos priorityObj1 nearObjects ["House", 150]);

_enemiesArray