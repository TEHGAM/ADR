/*
	File: fn_tawvdInit.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master init for TAW View Distance (Addon version). If the script verson is present it will exit.
*/
if(!isMultiplayer) exitWith {};
tawvd_foot = 1600;
tawvd_car = 3200;
tawvd_air = 3200;
tawvd_addon_disable = true;

[] spawn {
	waitUntil {player == player};
	[] spawn TAWVD_fnc_trackViewDistance;
};