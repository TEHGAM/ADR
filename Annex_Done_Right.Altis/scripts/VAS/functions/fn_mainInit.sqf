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
<br/>
<font color='#3E9D3F'>Virtual Ammobox System</font> (VAS) by Tonic is a user-friendly alternative to the default interface for handling of personal gear loadout – ammo, guns and items. Please report any issues at the following address:
<br/>
<font size='10' color='#BECEDA'>
http://forums.bistudio.com/showthread.php?149077-Virtual-Ammobox-System-%28VAS%29
</font>
<br/><br/>
<font size='14' color='#4499CC'>
Special Thanks:
</font>
<br/>
  • Dslyecxi<font size='10' color='#BECEDA'> for his Paper Doll script, giving me insight on how to detect item types.</font>
<br/>
  • Kronzky<font size='10' color='#BECEDA'> for his string function library.</font>
<br/>
  • Robalo<font size='10' color='#BECEDA'> for providing code changes to help support the new compatibleItems class structure.</font>
<br/>
  • Tyrghen<font size='10' color='#BECEDA'> for the tip on CfgFunctions.</font>
<br/>
  • naong<font size='10' color='#BECEDA'> for his code tweaks to the Load/Save display.</font>
<br/>
  • Sa-Matra<font size='10' color='#BECEDA'> for help with UI resources and Russian translation.</font>
<br/>
    • PR9INICHEK<font size='10' color='#BECEDA'> and </font>Tourorist<font size='10' color='#BECEDA'> for tweaks to the Russian localization.</font>
<br/>
  • Coding<font size='10' color='#BECEDA'> for translating VAS into German.</font>
<br/>
    • MemphisBelle<font size='10' color='#BECEDA'> for tweaks to the German translation.</font>
<br/>
  • El nabot<font size='10' color='#BECEDA'> for French translation.</font>
<br/>
  • czesiek77<font size='10' color='#BECEDA'> for Polish translation.</font>
<br/>
  • Ficc<font size='10' color='#BECEDA'> for Portuguese translation.</font>
<br/>
  • ramius86<font size='10' color='#BECEDA'> for Italian translation.</font>
<br/>
  • RabsRincon<font size='10' color='#BECEDA'> for Spanish translation.</font>
<br/>
  • Bakarda<font size='10' color='#BECEDA'> for Czech translation.</font>
<br/><br/>
  • The list goes on...
      "
    ]
  ];
};
