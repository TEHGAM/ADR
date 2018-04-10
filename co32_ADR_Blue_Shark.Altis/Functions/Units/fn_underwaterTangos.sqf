/*
 * Author: BACONMOP
 * Spawns patrols for underwater missions
 *
 *
 */
_center = _this select 0;
_infteamPatrol = createGroup east;
_swimmerArray = [];
for "_x" from 0 to (3 + (random 4)) do {
	_randomPos = [[[_center, 300],[]],[]] call BIS_fnc_randomPos;
	if !(_randomPos isEqualTo [0,0,0]) then {
		_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_diverTeam")] call BIS_fnc_spawnGroup;
	} else {
		_accepted = false;
		while {!_accepted} do {
			_randomPos = [[[_center, 300],[]],[]] call BIS_fnc_randomPos;
			if !(_randomPos isEqualTo [0,0,0]) then {
				_infteamPatrol = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_diverTeam")] call BIS_fnc_spawnGroup;
				_accepted = true;
			};
		};
	};

	for "_x" from 0 to (4 + (random 4)) do {
		_pos = [0,0,0];

		_randomPos = [[[_center, 300],[]],[]] call BIS_fnc_randomPos;
		if !(_randomPos isEqualTo [0,0,0]) then {
			hpad = "Land_HelipadEmpty_F" createVehicle _randomPos;
		} else {
			_accepted = false;
			while {!_accepted} do {
				_randomPos = [[[_center, 300],[]],[]] call BIS_fnc_randomPos;
				if !(_randomPos isEqualTo [0,0,0]) then {
					hpad = "Land_HelipadEmpty_F" createVehicle _randomPos;
					_accepted = true;
				};
			};
		};
		_hpadPos = getPos hpad;
		_maxDepth = _hpadPos select 2;
		_xCord = _hpadPos select 0;
		_yCord = _hpadPos select 1;
		_depth = 0 + (random _maxDepth);
		_uWp = _infteamPatrol addWaypoint [[_xCord,_yCord,_depth],0];
		_uWp setWaypointType "MOVE";
		_uWp setWaypointCompletionRadius 5;

		deleteVehicle hpad;
	};
	_wp = _infteamPatrol addwaypoint [_randomPos,0];
	_wp setWaypointType "CYCLE";
	{_swimmerArray pushBack _x} forEach Units _infteamPatrol;
};

for "_x" from 0 to (random 3) do {
	_randomPos = [[[_center, 300],[]],[]] call BIS_fnc_randomPos;
	if !(_randomPos isEqualTo [0,0,0]) then {
		_boat = "O_Boat_Armed_01_hmg_F" createVehicle (_randomPos);
		_boat setDir (random 360);
		[_boat,_infteamPatrol] call BIS_fnc_spawnCrew;
	} else {
		_accepted = false;
		while {!_accepted} do {
			_randomPos = [[[_center, 300],[]],[]] call BIS_fnc_randomPos;
			if !(_randomPos isEqualTo [0,0,0]) then {
				_boat = "O_Boat_Armed_01_hmg_F" createVehicle (_randomPos);
				_boat setDir (random 360);
				[_boat,_infteamPatrol] call BIS_fnc_spawnCrew;
				_accepted = true;
			};
		};
	};
	{_swimmerArray pushBack _x} forEach Units _infteamPatrol;
};

_swimmerArray
