/*
@filename: init.sqf
Author:
	
	Quiksilver

Last modified:

	12/05/2014
	
Description:

	Things that may run on both server and client.
	Deprecated initialization file, still using until the below is correctly partitioned between server and client.
______________________________________________________*/


call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";		// revive
[["scripts\transport\init.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP; //Транспортировка подвесом.
[["scripts\player\init.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;