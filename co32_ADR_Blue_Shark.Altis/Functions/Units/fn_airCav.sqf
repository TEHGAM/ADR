/*
Author: BACONMOP
Description: Create Air Cav reinforce
factions: paraMil, bandits, FIAIndep, AAF, CSAT, CSATTropic, FIAOpfor, NATO, NATOTropic, FIABlufor, CTRG
[currentAO, "base", "paraMil"] call AW_fnc_airCav;
last edited: 19/08/2017 by stanhope
edited: group naming
*/


params ["_dropZone","_startPos","_faction"];


airCavReturnGrp = [];
_return = [];
_flatPos = [0,0,0];
_accepted = false;
while {!_accepted} do {
	_position = [[[getMarkerPos _dropZone,800]],["water","out"]] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
	while {(count _flatPos) < 2} do {
		_position = [[[getMarkerPos _dropZone,1500]],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
	};
	if ((_flatPos distance (getMarkerPos "respawn_west")) > 2000) then {
		_accepted = true;
	};
};
switch(_faction) do{
	case "paraMil":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup Resistance;
		_GRP1 = createGroup Resistance;	
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"paraMil"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "bandits":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup Resistance;
		_GRP1 = createGroup Resistance;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"bandits"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "FIAIndep":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup Resistance;
		_GRP1 = createGroup Resistance;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"FIAIndep"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "AAF":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup Resistance;
		_GRP1 = createGroup Resistance;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"AAF"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "CSAT":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup East;
		_GRP1 = createGroup East;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"CSAT"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "CSATTropic":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup East;
		_GRP1 = createGroup East;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"CSATTropic"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "FIAOpfor":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup East;
		_GRP1 = createGroup East;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"FIAOpfor"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "NATO":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup West;
		_GRP1 = createGroup West;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"NATO"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "NATOTropic":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup West;
		_GRP1 = createGroup West;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"NATOTropic"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "FIABlufor":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup West;
		_GRP1 = createGroup West;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"FIABlufor"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
	case "CTRG":{
		_heliArray = (missionconfigfile >> "unitList" >> _faction >> "Helicopters") call BIS_fnc_getCfgData;
		_heli = _heliArray call BIS_fnc_selectRandom;
		_heliGrp = createGroup West;
		_GRP1 = createGroup West;
		_GRP1 setGroupIdGlobal [format ['AO-ReinfGroup']];
		_heliGrp setGroupIdGlobal [format ['AO-ReinfHeli']];
		_ambientHeli = createVehicle [_heli, getMarkerPos _startPos, [], 0, "FLY" ];
		[_ambientHeli,_heliGrp,"CTRG"] call AW_fnc_createCrew;
		_squadSize = _ambientHeli emptyPositions "cargo";
		private ["_unit"];
		for "_i" from 1 to _squadSize do {
			_unitArray = (missionconfigfile >> "unitList" >> _faction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_unit createUnit [ getMarkerPos _startPos, _GRP1];
		};
		sleep 3;
		{_x allowFleeing 0;} forEach units _heliGrp;
		{_x moveInCargo _ambientHeli} forEach units _GRP1;
		_wpPos =  _flatPos;
		_heliWp = _heliGrp addWaypoint [_wpPos,0];
		_heliWp setWaypointType "TR UNLOAD";
		_heliWp setWaypointCompletionRadius 5;
		_wpPos3 =  getMarkerPos _startPos;
		_heliWp3 = _heliGrp addWaypoint [_wpPos3,1];
		_heliWp3 setWaypointType "Move";
		_heliWp3 setWaypointCompletionRadius 5;
		[_GRP1,getMarkerPos _dropZone, 400 ] call BIS_fnc_taskPatrol;
		{airCavReturnGrp pushBack _x} forEach units _GRP1;
		{airCavReturnGrp pushBack _x} forEach units _heliGrp;
		airCavReturnGrp pushBack _ambientHeli;
	};
};

_return = airCavReturnGrp;
{_x addCuratorEditableObjects [(_return), true]; } foreach allCurators;
[_return] call derp_fnc_AISkill;
_return
