private ["_pad","_getToMarker","_cargoGrp","_vehicle","_pos","_grp","_wp1","_wp2","_direction","_mkr","_veh","_counter","_wp2_pos","_getToMarker"];
_mkr = (_this select 0);
_veh = (_this select 1);
_counter = (_this select 2);
_direction = (_this select 3);

_vehicle = _veh select 0;
_grp = _veh select 2;
_cargoGrp = _veh select 3;

_pos = [getMarkerPos _mkr, 150, _direction, 0, [0,0]] call SHK_pos;

{_x allowFleeing 0} forEach units _grp;
{_x allowFleeing 0} forEach units _cargoGrp;
{_x addBackpack "B_Parachute"} forEach units _cargoGrp;

_vehicle flyinheight 200;
_wp1 = _grp addWaypoint [_pos, 0];
_wp1 setWayPointSpeed "FULL";
_wp1 setWayPointType "MOVE";
_wp1 setWayPointCombatMode "BLUE";

waituntil {sleep 0.2; [_vehicle, _pos] call BIS_fnc_distance2D < 1000};
_vehicle flyinheight 200;
_wp2_pos = [getMarkerPos _mkr, 3000, ((_direction + 180) % 360)] call BIS_fnc_relPos;
_wp2 = _grp addWaypoint [_wp2_pos, 0];
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointType "MOVE";
_wp2 setWayPointCombatMode "BLUE";
_wp2 setWaypointStatements ["true", "{deleteVehicle _x} forEach crew (vehicle this) + [vehicle this];"];

waituntil {sleep 0.2; [_vehicle, _pos] call BIS_fnc_distance2D < 350};
{unassignVehicle _x, _x action ["getOut", _vehicle], sleep 0.2} forEach units _cargoGrp;
_getToMarker = _cargoGrp addWaypoint [getMarkerPos _mkr, 50];
_getToMarker setWaypointType "SAD";
_getToMarker setWaypointSpeed "FULL";
_getToMarker setWaypointBehaviour "AWARE";
_getToMarker setWayPointCombatMode "RED";
_getToMarker setWaypointFormation "NO CHANGE";