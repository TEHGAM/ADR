/*
@filename: initServer.sqf
Author:
	
	Quiksilver

Last modified:

	23/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Server scripts such as missions, modules, third party and clean-up.
	
______________________________________________________*/

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
if (PARAMS_SideObjectives == 1) then { _null = [] execVM "mission\side\missionControl.sqf";};			// Side objectives		
_null = [] execVM "scripts\eos\OpenMe.sqf";																// EOS (urban mission and defend AO)
_null = [] execVM "scripts\misc\airbaseDefense.sqf";													// Airbase air defense
_null = [] execVM "scripts\misc\cleanup.sqf";															// cleanup
_null = [] execVM "scripts\misc\islandConfig.sqf";														// prep the island for mission
if (PARAMS_EasterEggs == 1) then {_null = [] execVM "scripts\easterEggs.sqf";};							// Spawn easter eggs around the island
adminCurators = allCurators;
enableEnvironment FALSE;
BACO_ammoSuppAvail = true; publicVariable "BACO_ammoSuppAvail";