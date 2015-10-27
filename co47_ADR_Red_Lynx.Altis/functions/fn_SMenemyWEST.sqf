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

#define INF_TEAMS "BUS_InfTeam", "BUS_InfTeam_AT", "BUS_InfTeam_AA", "BUS_ReconPatrol"
#define VEH_TYPES "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F", "B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_AA_F", "B_APC_Tracked_01_rcws_F", "B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F"
private ["_x", "_pos", "_flatPos", "_randomPos", "_enemiesArray", "_infteamPatrol", "_SMvehPatrol", "_SMveh", "_SMaaPatrol", "_SMaa", "_smSniperTeam"];
_enemiesArray = [grpNull];
_x = 0;

//---------- GROUPS

_infteamPatrol = createGroup WEST;
_smSniperTeam = createGroup WEST;
_SMvehPatrol = createGroup WEST;
_SMaaPatrol = createGroup WEST;

//---------- INFANTRY RANDOM

for "_x" from 0 to (3 + (random 4)) do {
	_randomPos = [[[getPos sideObj, 300], []], ["water", "out"]] call BIS_fnc_randomPos;
	_infteamPatrol = [_randomPos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> [INF_TEAMS] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
	[_infteamPatrol, getPos sideObj, 100] call BIS_fnc_taskPatrol;

	_enemiesArray = _enemiesArray + [_infteamPatrol];
};

//---------- SNIPER

for "_x" from 0 to 1 do {
	_randomPos = [getPos sideObj, 500, 100, 20] call BIS_fnc_findOverwatch;
	_smSniperTeam = [_randomPos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_SniperTeam")] call BIS_fnc_spawnGroup;
	_smSniperTeam setBehaviour "COMBAT";
	_smSniperTeam setCombatMode "RED";

	_enemiesArray = _enemiesArray + [_smSniperTeam];
};

//---------- VEHICLE RANDOM

_randomPos = [[[getPos sideObj, 300], []], ["water", "out"]] call BIS_fnc_randomPos;
_SMveh1 = [VEH_TYPES] call BIS_fnc_selectRandom createVehicle _randomPos;
waitUntil {sleep 0.5; !isNull _SMveh1};
[_SMveh1, _SMvehPatrol] call BIS_fnc_spawnCrew;
[_SMvehPatrol, getPos sideObj, 75] call BIS_fnc_taskPatrol;
_SMveh1 lock 3;
_SMveh1 allowCrewInImmobile true;
sleep 0.1;

_enemiesArray = _enemiesArray + [_SMveh1];

//---------- VEHICLE RANDOM	

_randomPos = [[[getPos sideObj, 300], []], ["water", "out"]] call BIS_fnc_randomPos;
_SMveh2 = [VEH_TYPES] call BIS_fnc_selectRandom createVehicle _randomPos;
waitUntil {sleep 0.5; !isNull _SMveh2};
[_SMveh2, _SMvehPatrol] call BIS_fnc_spawnCrew;
[_SMvehPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;
_SMveh2 lock 3;
_SMveh2 allowCrewInImmobile true;
sleep 0.1;

_enemiesArray = _enemiesArray + [_SMveh2];
sleep 0.1;
_enemiesArray = _enemiesArray + [_SMvehPatrol];

//---------- VEHICLE AA

_randomPos = [[[getPos sideObj, 300], []], ["water", "out"]] call BIS_fnc_randomPos;
_SMaa = "B_APC_Tracked_01_AA_F" createVehicle _randomPos;
waitUntil {sleep 0.5; !isNull _SMaa};
[_SMaa, _SMaaPatrol] call BIS_fnc_spawnCrew;
_SMaa lock 3;
_SMaa allowCrewInImmobile true;
[_SMaaPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;

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
	_newGrp = [_x] call QS_fnc_garrisonFortWEST;
	if (!isNull _newGrp) then { 
		_enemiesArray = _enemiesArray + [_newGrp];
	};
} forEach (getPos sideObj nearObjects ["House", 150]);

_enemiesArray