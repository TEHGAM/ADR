/*
  Version: 2.0
  Author: TAW_Tonic
  Updated: 9/24/2013
  Description: Only called once during the initialization of VAS and uses compileFinal on all VAS functions.
*/
[] spawn
{
  if(isNil "VAS_init_complete") then
  {
    private["_handle"];
    VAS_init_timeOnStart = time;
    VAS_init_complete = false;
    _handle = [] execVM "scripts\VAS\config.sqf";
    waitUntil {scriptDone _handle;};
    if(isNil "VAS_fnc_buildConfig") exitWith {diag_log "::VAS:: function VAS_fnc_buildConfig is nil"};
    ["CfgWeapons"] call VAS_fnc_buildConfig;
    ["CfgMagazines"] call VAS_fnc_buildConfig;
    ["CfgVehicles"] call VAS_fnc_buildConfig;
    ["CfgGlasses"] call VAS_fnc_buildConfig;
    VAS_init_complete = true;
  }
  else
  {
    VAS_init_timeOnStart = time;
    [] call compile PreprocessFileLineNumbers "scripts\VAS\config.sqf";
    ["CfgWeapons"] call VAS_fnc_buildConfig;
    ["CfgMagazines"] call VAS_fnc_buildConfig;
    ["CfgVehicles"] call VAS_fnc_buildConfig;
    ["CfgGlasses"] call VAS_fnc_buildConfig;

    sleep 2.5;
    if(!isNil "vas_r_weapons") then { VAS_init_complete = true; };
  };

  waitUntil {!isNull player && player == player};
  if(player diarySubjectExists "VAS")exitwith{};
  player createDiarySubject ["VAS","VAS"];
  player createDiaryRecord
  ["VAS",
    [
      "Version 2.6",
          "
Virtual Ammobox System (VAS) by Tonic is a user-friendly alternative to the default interface for handling of personal gear loadout — ammo, guns and items. Please report any VAS issues on the BI forums.
<br/><br/>
BIF thread:
http://forums.bistudio.com/showthread.php?149077-Virtual-Ammobox-System-%28VAS%29
<br/><br/>
<p>
<h1>
Special THanks:
<br/>
Dslyecxi for his Paper Doll script, giving me insight on how to detect item types.
<br/>
Kronzky for his string function library.
<br/>
Robalo for providing code changes to help support the new compatibleItems class structure.
<br/>
Tyrghen for the tip on CfgFunctions.
<br/>
naong for his code tweaks to the Load/Save display.
<br/>
Sa-Matra — For help with UI resources and Russian translation.
<br/>
      PR9INICHEK and Tourorist for updates and additions to the Russian localization.
<br/>
Coding for translating VAS into German.
<br/>
      MemphisBelle for tweaks to the German translation.
<br/>
El nabot for French translation.
<br/>
czesiek77 for Polish translation.
<br/>
Ficc for Portuguese translation.
<br/>
ramius86 for Italian translation.
<br/>
RabsRincon for Spanish translation.
<br/>
Bakarda for Czech translation.
<br/>
The list goes on...
<br/>
</p>
</h1>
      "
    ]
  ];
};
