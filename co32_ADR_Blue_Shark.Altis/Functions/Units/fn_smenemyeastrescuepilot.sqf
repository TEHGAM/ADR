/*
Author: 

	Quiksilver, modified by stanhope
	
Last modified:

	16/09/2017 by stanhope
	
Modified:
	
	group names, for loops, ...

Description:

	Spawn OPFOR enemy around side objectives.
	
___________________________________________*/

//---------- CONFIG
private ["_x","_pos","_flatPos","_randomPos","_enemiesArray","_infteamPatrol","_SMvehPatrol","_SMveh","_SMaaPatrol","_SMaa","_smSniperTeam"];

_INFTEAMS = ["OIA_InfTeam_AA","OIA_InfSquad","OI_reconPatrol","OI_reconTeam","OI_ViperTeam"]; 
_VEHTYPES = ["O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"];
_AATYPES = ["O_APC_Tracked_02_AA_F"];

_enemiesArray = [grpNull];

//---------- INFANTRY RANDOM
	
private _MaininfCount = 0;
	
for "_x" from 0 to (3 + (random 2)) do {

	_infteamPatrol = createGroup east;
	_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
	_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> (selectRandom _INFTEAMS))] call BIS_fnc_spawnGroup;
	_MaininfCount = _MaininfCount + 1;
	_infteamPatrol setGroupIdGlobal [format ['Side-MainInf-%1', _MaininfCount]];
	[_infteamPatrol, getPos sideObj, 100] call BIS_fnc_taskPatrol;
				
	_enemiesArray = _enemiesArray + [_infteamPatrol];

	{_x addCuratorEditableObjects [units _infteamPatrol, false];} foreach adminCurators;

};

//---------- SNIPER
private _sniperCount = 0;

for "_x" from 0 to 1 do {
	_smSniperTeam = createGroup east;
	_randomPos = [getPos sideObj, 500, 100, 20] call BIS_fnc_findOverwatch;
	_smSniperTeam = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
	_sniperCount = _sniperCount + 1;
	_smSniperTeam setGroupIdGlobal [format ['Side-SniperTeam-%1', _sniperCount]];
	_smSniperTeam setBehaviour "COMBAT";
	_smSniperTeam setCombatMode "RED";
		
	_enemiesArray = _enemiesArray + [_smSniperTeam];

	{
		_x addCuratorEditableObjects [units _smSniperTeam, false];
	} foreach adminCurators;

};
	
//---------- VEHICLE RANDOM
private _randomVicCount = 0;

for "_x" from 1 to 2 do {

	_SMvehPatrol = createGroup east;
	_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
	_SMveh = (selectRandom _VEHTYPES) createVehicle _randomPos;
	waitUntil {sleep 0.5; !isNull _SMveh};
	[_SMveh, _SMvehPatrol] call BIS_fnc_spawnCrew;
	_randomVicCount = _randomVicCount + 1;
	_SMvehPatrol setGroupIdGlobal [format ['Side-RandomVehicle-%1', _randomVicCount]];
	[_SMvehPatrol, getPos sideObj, 75] call BIS_fnc_taskPatrol;
	_SMveh lock 3;
	_SMveh allowCrewInImmobile true;

	sleep 0.1;
	{_x addCuratorEditableObjects [[_SMveh] + units _SMvehPatrol, false];} foreach adminCurators;
		
	_enemiesArray = _enemiesArray + [_SMveh]+ units _SMvehPatrol;


};


//---------- VEHICLE AA
private _aaVicCount = 0;

for "_x" from 0 to (1 + (random 2)) do {
	_SMaaPatrol = createGroup east;

	_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
	_SMaa = (selectRandom _AATYPES) createVehicle _randomPos;
	[_SMaa, _SMaaPatrol] call BIS_fnc_spawnCrew;
	_aaVicCount = _aaVicCount + 1;
	_SMaaPatrol setGroupIdGlobal [format ['Side-AAVehicle-%1', _aaVicCount]];
	_SMaa lock 3;
	_SMaa allowCrewInImmobile true;
	[_SMaaPatrol, getPos sideObj, 150] call BIS_fnc_taskPatrol;
		
	_enemiesArray = _enemiesArray + units _SMaaPatrol + [_SMaa];
	sleep 0.1;

	{_x addCuratorEditableObjects [[_SMaa]+units _SMaaPatrol, false];} foreach adminCurators;
};

//---------- COMMON

[(units _infteamPatrol)] call AW_fnc_setSkill2;
[(units _smSniperTeam)] call AW_fnc_setSkill3;
[(units _SMaaPatrol)] call AW_fnc_setSkill4;
[(units _SMvehPatrol)] call AW_fnc_setSkill2;
	
_enemiesArray