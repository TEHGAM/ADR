/*
  filename:
  init.sqf

  Author:
  Quiksilver

  Last modified:
  03.01.2015

  Description:
  Things that may run on both server and client.
  Deprecated initialization file, still using until the below is correctly partitioned between server and client.
*/

call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";

[] execVM "scripts\DOM_squad\init.sqf";
if (isDedicated) exitWith { "addToScore" addPublicVariableEventHandler { ((_this select 1) select 0) addScore ((_this select 1) select 1); }; }; // Относится к скрипту =BTC=_revive
//[["scripts\transport\init.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP; //Транспортировка подвесом.
//[["scripts\player\init.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;
