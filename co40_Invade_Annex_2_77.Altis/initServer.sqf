/*
 Filename: initServer.sqf

  Author:
  Quiksilver

  Last modified:
  1/05/2014

  Description:
  Server scripts such as missions, modules, third party and clean-up.

  Credits:
  Invade & Annex 2.00 was created by Rarek [ahoyworld.co.uk] with countless hours of work,
  and further developed by Quiksilver [allFPS.com.au] with countless hours more.

  Contributors:
  Razgriz33 [AW], Jester [AW], Kamaradski [AW], David [AW], chucky [allFPS].
  
  ts.ahoyworld.co.uk:9987
  ts3.allfps.com.au:9992
  
  Please be respectful and do not remove/alter credits.
*/


enableSaving [false, false];

//  Handle parameters

for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
  call compile format
  [
    "PARAMS_%1 = %2",
    (configName ((missionConfigFile >> "Params") select _i)),
    (paramsArray select _i)
  ];
};

//  Server scripts

if (PARAMS_AO == 1) then { _null = [] execVM "mission\main\missionControl.sqf"; };              // Main AO
if (PARAMS_SideObjectives == 1) then { _null = [] execVM "mission\side\missionControl.sqf"; };  // Side Objectives
_null = [] execVM "scripts\eos\OpenMe.sqf";                                                     // EOS (urban mission and defend AO)
_null = [] execVM "scripts\misc\airbaseDefense.sqf";                                            // Airbase air defense
_null = [] execVM "scripts\misc\clearBodies.sqf";                                               // clear bodies around island
_null = [] execVM "scripts\misc\clearItemsAO.sqf";                                              // clear items around AO
_null = [] execVM "scripts\misc\clearItemsBASE.sqf";                                            // clear items around base
_null = [] execVM "scripts\misc\islandConfig.sqf";                                              // prep the island for mission
_null = [] execVM "scripts\misc\UAVfix.sqf";                                                    // attempt UAV fix

_null = [] execVM "module_performance\init.sqf";

if (PARAMS_EasterEggs == 1) then { _null = [] execVM "scripts\easterEggs.sqf"; };               // Spawn easter eggs around the island

  [
    0, // seconds to delete dead bodies (0 means don't delete)
    0, // seconds to delete dead vehicles
    2*60, // seconds to delete dropped weapons
    30*60, // seconds to deleted planted explosives
    2*60 // seconds to delete dropped smokes/chemlights
  ] execVM "scripts\cleanup\repetitive_cleanup.sqf";
