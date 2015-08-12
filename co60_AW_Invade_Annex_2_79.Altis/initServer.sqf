/*
@filename: initServer.sqf
Author:
	
	Quiksilver

Last modified:

	1/05/2014
	
Description:

	Server scripts such as missions, modules, third party and clean-up.
	
Credit:

	Invade & Annex 2.00 was created by Rarek [ahoyworld.co.uk] with countless hours of work, 
	and further developed by Quiksilver [allFPS.com.au] with countless hours more. 
	
	Contributors: Razgriz33 [AW], Jester [AW], Kamaradski [AW], David [AW], chucky [allFPS].
	
	Please be respectful and do not remove/alter credits.
______________________________________________________*/

enableSaving [false, false];
["Initialize"] call BIS_fnc_dynamicGroups;

//------------------------------------------------ Set up curator classes

adminCurators = allCurators;

//------------------------------------------------ Handle parameters

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

//-------------------------------------------------- Server scripts

if (PARAMS_AO == 1) then { _null = [] execVM "mission\main\missionControl.sqf"; };						// Main AO
if (PARAMS_SideObjectives == 1) then { _null = [] execVM "mission\side\missionControl.sqf"; };			// Side Objectives
_null = [] execVM "scripts\eos\OpenMe.sqf";																// EOS (urban mission and defend AO)
_null = [] execVM "scripts\misc\airbaseDefense.sqf";													// Airbase air defense
_null = [] execVM "scripts\misc\clearBodies.sqf";														// clear bodies around island
_null = [] execVM "scripts\misc\clearItemsBASE.sqf";													// clear items around base
_null = [] execVM "scripts\misc\islandConfig.sqf";														// prep the island for mission