/*
	File: fn_trackViewDistance.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Constantly monitors the players state.
	
	i.e Player gets in landvehicle then adjust viewDistance.
*/
private["_old","_recorded"];
_recorded = vehicle player;

while {true} do {
	[] call TAWVD_fnc_updateViewDistance;
	if ((_recorded != (vehicle player)) || (!alive player)) then {
		[] call TAWVD_fnc_updateViewDistance;
		_recorded = vehicle player;
	};
	sleep 3;
};