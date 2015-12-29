private ["_getToMarker","_cargoGrp","_vehicle","_pos","_grp","_wp1","_wp2","_direction","_mkr","_veh","_counter","_wp2_pos","_vehType","_distance","_getToMarker"];
_mkr = (_this select 0);
_veh = (_this select 1);
_counter = (_this select 2);
_direction = (_this select 3);
_vehType = (_this select 4);

_vehicle = _veh select 0;
_grp = _veh select 2;
_cargoGrp = _veh select 3;

_water = 0;
_distance = [400, 600];

if (_vehType == 8) then {_water = 2; _distance = 250};

_pos = [getMarkerPos _mkr, _distance, _direction, _water, [0, 0], [200, "Land_Radar_F"]] call SHK_pos;

{_x allowFleeing 0} forEach units _grp;
{_x allowFleeing 0} forEach units _cargoGrp;

_wp1 = _grp addWaypoint [_pos, 0];
_wp1 setWaypointType "UNLOAD";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointBehaviour "AWARE"; 
_wp1 setWaypointFormation "NO CHANGE";

waituntil {sleep 0.2; (_vehicle distance _pos < 50) and (speed _vehicle < 2)};
{unassignVehicle _x, _x action ["getOut", _vehicle], sleep 0.3} forEach units _cargoGrp;

_getToMarker = _cargoGrp addWaypoint [getMarkerPos _mkr, 50];
_getToMarker setWaypointType "SAD";
_getToMarker setWaypointSpeed "FULL";
_getToMarker setWaypointBehaviour "AWARE"; 
_getToMarker setWaypointFormation "NO CHANGE";

waitUntil {sleep 0.2; {_x in _vehicle} count units _cargoGrp == 0};

sleep 5;

_wp2 = _grp addWaypoint [getMarkerPos _mkr, 50];
_wp2 setWaypointType "SAD";
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointBehaviour "AWARE"; 
_wp2 setWaypointFormation "NO CHANGE";