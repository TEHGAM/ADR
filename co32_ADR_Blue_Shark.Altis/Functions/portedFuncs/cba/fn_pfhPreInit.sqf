// band-aid fix for onPlayerConnected
[derp_OPC_FIX, "onPlayerConnected", {}] call BIS_fnc_addStackedEventHandler;
[derp_OPC_FIX, "onPlayerConnected"] call BIS_fnc_removeStackedEventHandler;

// PFH stuff
call compile preprocessFileLineNumbers 'functions\portedFuncs\cba\init_perFrameHandler.sqf';
