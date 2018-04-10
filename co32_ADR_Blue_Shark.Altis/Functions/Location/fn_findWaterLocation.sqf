/*
 * Author: BACONMOP
 * Finds and returns position in the water
 *
 * 
 */

_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_position = [[[] call BIS_fnc_worldArea],[]] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [2,0,0.3,1,2,true];
	while {(count _flatPos) < 2} do {
		_position = [[[] call BIS_fnc_worldArea],[]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [2,0,0.3,1,2,true];
	};
	if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700 && (_flatPos distance (getMarkerPos currentAO)) > 500) then {
		_accepted = true;
	};
};

_flatPos