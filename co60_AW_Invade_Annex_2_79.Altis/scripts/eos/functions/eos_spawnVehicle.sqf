_position = (_this select 0);
_side = (_this select 1);
_faction = (_this select 2);
_type = (_this select 3);
_special = if (count _this > 4) then {_this select 4} else {"CAN_COLLIDE"};

_vehicleType=[_faction,_type] call eos_fnc_getunitpool;
_grp = createGroup _side;

_vehicle = createVehicle [(_vehicleType select 0), _position, [], 0, _special];
createVehicleCrew _vehicle;
_vehCrew = crew _vehicle;
_vehCrew join _grp;

_return = [_vehicle,_vehCrew,_grp];

_return