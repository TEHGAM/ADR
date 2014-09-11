if (!isServer) exitWith{};

[] execVM "module_performance\module_monitor\init.sqf";
[] execVM "module_performance\module_cleanup\init.sqf";


