/*
	@version: 2.0
	@file_name: fn_mainInit.sqf
	@file_author: TAW_Tonic
	@file_edit: 9/24/2013
	@file_description: Only called once during the initialization of VAS and uses compileFinal on all VAS functions.
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
};