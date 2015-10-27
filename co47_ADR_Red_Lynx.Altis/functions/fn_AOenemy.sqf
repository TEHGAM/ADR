/*
@file: QS_fnc_AOenemy.sqf
Author:

	Quiksilver (credits: Ahoyworld.co.uk. Rarek et al for AW_fnc_spawnUnits.)
	
Description:

	_randomPos = [_spawnPos, 50, 500, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

	Spawn enemies in the AO.
	Some selections customizable in parameters (description.ext).

	To do: sometimes vehicles dont find safe position
__________________________________________________________________*/

//---------- CONFIG

#define INF_TYPE "BUS_InfSentry", "BUS_InfSquad", "BUS_InfSquad_Weapons", "BUS_InfTeam", "BUS_InfTeam_AA", "BUS_InfTeam_AT", "BUS_ReconPatrol", "BUS_ReconSentry", "BUS_ReconTeam"
#define INF_URBANTYPE "BUS_InfSentry", "BUS_InfSquad", "BUS_InfTeam"
#define MRAP_TYPE "B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F"
#define VEH_TYPE "B_MBT_01_cannon_F", "B_MBT_01_TUSK_F", "B_APC_Wheeled_01_cannon_F", "B_APC_Tracked_01_AA_F", "B_APC_Tracked_01_rcws_F"
#define AIR_TYPE "B_Heli_Attack_01_F", "B_Heli_Light_01_armed_F"
#define STATIC_TYPE "B_HMG_01_F", "B_HMG_01_high_F", "B_Mortar_01_F"

private ["_enemiesArray", "_randomPos", "_patrolGroup", "_AOvehGroup", "_AOveh", "_AOmrapGroup", "_AOmrap", "_pos", "_spawnPos", "_overwatchGroup", "_x", "_staticGroup", "_static", "_aaGroup", "_aa", "_airGroup", "_air", "_sniperGroup", "_staticDir"];
_pos = getMarkerPos (_this select 0);
_enemiesArray = [grpNull];
_x = 0;
//---------- AA VEHICLE
	
for "_x" from 1 to PARAMS_AAPatrol do {
	_aaGroup = createGroup WEST;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 2)], []], ["water", "out"]] call BIS_fnc_randomPos;
	_aa = "B_APC_Tracked_01_AA_F" createVehicle _randomPos;
	waitUntil{!isNull _aa};
		"B_engineer_F" createUnit [_randomPos,_aaGroup];
		"B_engineer_F" createUnit [_randomPos,_aaGroup];
		"B_engineer_F" createUnit [_randomPos,_aaGroup];
		((units _aaGroup) select 0) assignAsDriver _aa;
		((units _aaGroup) select 0) moveInDriver _aa;
		((units _aaGroup) select 1) assignAsGunner _aa;
		((units _aaGroup) select 1) moveInGunner _aa;
		((units _aaGroup) select 2) assignAsCommander _aa;
		((units _aaGroup) select 2) moveInCommander _aa;
	[_aaGroup, getMarkerPos currentAO, 500] call BIS_fnc_taskPatrol;
	_aa lock 3;
	if (random 1 >= 0.3) then {
		_aa allowCrewInImmobile true;
	};

	_enemiesArray = _enemiesArray + [_aaGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_aa];

};

//---------- INFANTRY PATROLS RANDOM

for "_x" from 1 to PARAMS_GroupPatrol do {
	_patrolGroup = createGroup WEST;
	_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.2)], []], ["water", "out"]] call BIS_fnc_randomPos;
	_patrolGroup = [_randomPos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> [INF_TYPE] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
	[_patrolGroup, getMarkerPos currentAO, 400] call BIS_fnc_taskPatrol;

	_enemiesArray = _enemiesArray + [_patrolGroup];

};

//---------- STATIC WEAPONS

for "_x" from 1 to PARAMS_StaticMG do {
	_staticGroup = createGroup WEST;
	_randomPos = [getMarkerPos currentAO, 200, 10, 10] call BIS_fnc_findOverwatch;
	_static = [STATIC_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
	waitUntil{!isNull _static};	
	_static setDir random 360;
		"B_support_MG_F" createUnit [_randomPos,_staticGroup];
		((units _staticGroup) select 0) assignAsGunner _static;
		((units _staticGroup) select 0) moveInGunner _static;
	_staticGroup setBehaviour "COMBAT";
	_staticGroup setCombatMode "RED";
	_static setVectorUp [0,0,1];
	_static lock 3;

	_enemiesArray = _enemiesArray + [_staticGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_static];

};

//---------- INFANTRY OVERWATCH

for "_x" from 1 to PARAMS_Overwatch do {
	_overwatchGroup = createGroup WEST;
	_randomPos = [getMarkerPos currentAO, 600, 50, 10] call BIS_fnc_findOverwatch;
	_overwatchGroup = [_randomPos, WEST, (configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> [INF_URBANTYPE] call BIS_fnc_selectRandom)] call BIS_fnc_spawnGroup;
	[_overwatchGroup, _randomPos, 100] call BIS_fnc_taskPatrol;

	_enemiesArray = _enemiesArray + [_overwatchGroup];

};

//--------- MRAP

for "_x" from 0 to 1 do {
	_AOmrapGroup = createGroup WEST;
	_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize], []], ["water", "out"]] call BIS_fnc_randomPos;
	_AOmrap = [MRAP_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
	waitUntil {!isNull _AOmrap};
		"B_engineer_F" createUnit [_randomPos,_AOmrapGroup];
		"B_engineer_F" createUnit [_randomPos,_AOmrapGroup];
		"B_engineer_F" createUnit [_randomPos,_AOmrapGroup];
		((units _AOmrapGroup) select 0) assignAsDriver _AOmrap;
		((units _AOmrapGroup) select 0) moveInDriver _AOmrap;
		((units _AOmrapGroup) select 1) assignAsGunner _AOmrap;
		((units _AOmrapGroup) select 1) moveInGunner _AOmrap;
		((units _AOmrapGroup) select 2) assignAsCargo _AOmrap;
		((units _AOmrapGroup) select 2) moveInCargo _AOmrap;
	[_AOmrapGroup, getMarkerPos currentAO, 600] call BIS_fnc_taskPatrol;
	_AOmrap lock 3;
	if (random 1 >= 0.5) then {
		_AOmrap allowCrewInImmobile true;
	};

	_enemiesArray = _enemiesArray + [_AOmrapGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_AOmrap];
};

//---------- GROUND VEHICLE RANDOM

for "_x" from 0 to (3 + (random 2)) do {
	_AOvehGroup = createGroup WEST;
	_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize], []], ["water", "out"]] call BIS_fnc_randomPos;
	_AOveh = [VEH_TYPE] call BIS_fnc_selectRandom createVehicle _randomPos;
	waitUntil{!isNull _AOveh};
		"B_engineer_F" createUnit [_randomPos,_AOvehGroup];
		"B_engineer_F" createUnit [_randomPos,_AOvehGroup];
		"B_engineer_F" createUnit [_randomPos,_AOvehGroup];
		((units _AOvehGroup) select 0) assignAsDriver _AOveh;
		((units _AOvehGroup) select 0) moveInDriver _AOveh;
		((units _AOvehGroup) select 1) assignAsGunner _AOveh;
		((units _AOvehGroup) select 1) moveInGunner _AOveh;
		((units _AOvehGroup) select 2) assignAsCommander _AOveh;
		((units _AOvehGroup) select 2) moveInCommander _AOveh;
	[_AOvehGroup, getMarkerPos currentAO, 400] call BIS_fnc_taskPatrol;
	_AOveh lock 3;
	if (random 1 >= 0.4) then {
		_AOveh allowCrewInImmobile true;
	};

	_enemiesArray = _enemiesArray + [_AOvehGroup,_AOveh];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_AOveh];

};

//---------- HELICOPTER	

if((random 10 <= PARAMS_AirPatrol)) then {
	_airGroup = createGroup WEST;
	_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize], _dt], ["water", "out"]] call BIS_fnc_randomPos;
	_air = [AIR_TYPE] call BIS_fnc_selectRandom createVehicle [_randomPos select 0, _randomPos select 1, 1000];
	waitUntil{!isNull _air};
	_air engineOn true;
	_air setPos [_randomPos select 0, _randomPos select 1, 300];

	_air spawn
	
	{
		private["_x"];
		for [{_x=0}, {_x<=200}, {_x=_x+1}] do
		{
			_this setVelocity [0, 0, 0];
			sleep 0.1;
		};
	};

		"B_Helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 0) assignAsDriver _air;
		((units _airGroup) select 0) moveInDriver _air;
		"B_Helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 1) assignAsGunner _air;
		((units _airGroup) select 1) moveInGunner _air;

	[_airGroup, getMarkerPos currentAO, 800] call BIS_fnc_taskPatrol;
	[(units _airGroup)] call QS_fnc_setSkill4;
	_air flyInHeight 300;
	_airGroup setCombatMode "RED";
	_air lock 3;

	_enemiesArray = _enemiesArray + [_airGroup];
	sleep 0.1;
	_enemiesArray = _enemiesArray + [_air];
};

//---------- SNIPERS

for "_x" from 1 to PARAMS_SniperTeamsPatrol do {
	_sniperGroup = createGroup WEST;
	_randomPos = [getMarkerPos currentAO, 1200, 100, 10] call BIS_fnc_findOverwatch;
	_sniperGroup = [_randomPos, WEST,(configfile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_SniperTeam")] call BIS_fnc_spawnGroup;
	_sniperGroup setBehaviour "COMBAT";
	_sniperGroup setCombatMode "RED";

	_enemiesArray = _enemiesArray + [_sniperGroup];

};

//---------- COMMON

[(units _patrolGroup)] call QS_fnc_setSkill1;
[(units _overwatchGroup)] call QS_fnc_setSkill2;
[(units _AOvehGroup)] call QS_fnc_setSkill2;
[(units _sniperGroup)] call QS_fnc_setSkill4;
[(units _staticGroup)] call QS_fnc_setSkill3;
[(units _aaGroup)] call QS_fnc_setSkill4;

//---------- GARRISON FORTIFICATIONS	

{
	_newGrp = [_x] call QS_fnc_garrisonFortWEST;
	if (!isNull _newGrp) then {
		_enemiesArray = _enemiesArray + [_newGrp];
	};
} forEach (getMarkerPos currentAO nearObjects ["House", 800]);

_enemiesArray;