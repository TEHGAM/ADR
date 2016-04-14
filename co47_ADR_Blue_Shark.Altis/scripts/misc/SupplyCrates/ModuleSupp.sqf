private ["_modules", "_objects", "_modtype", "_veh", "_smokeType", "_lightType", "_light", "_chute", "_smoke", "_veh_pos", "_smoke2", "_velocity"];

//---- Checking created modules and remove them

_modules = ["B_Slingload_01_Fuel_F", "B_Slingload_01_Medevac_F", "B_Slingload_01_Repair_F", "B_Slingload_01_Ammo_F", "Land_Pod_Heli_Transport_04_fuel_F", "Land_Pod_Heli_Transport_04_medevac_F", "Land_Pod_Heli_Transport_04_repair_F", "Land_Pod_Heli_Transport_04_ammo_F", "Land_Pod_Heli_Transport_04_bench_F", "Land_Pod_Heli_Transport_04_covered_F"];
_objects = nearestObjects [(getMarkerPos "Ammo_Supply_drop"), _modules, 50];
{
    deleteVehicle _x;
} forEach _objects;
sleep 0.1;

//---- Variables
_modtype = _this select 3;
_smokeType = "SmokeShellPurple";
_lightType = "Chemlight_blue";
_veh_pos = [0,0,0];

//---- Create module
	switch (_modtype) do
		{
			case 1: {_veh = "B_Slingload_01_Fuel_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
			case 2: {_veh = "B_Slingload_01_Medevac_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
			case 3: {_veh = "B_Slingload_01_Repair_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
			case 4: {_veh = "B_Slingload_01_Ammo_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
			case 5: {_veh = "Land_Pod_Heli_Transport_04_fuel_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
			case 6: {_veh = "Land_Pod_Heli_Transport_04_medevac_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
			case 7: {_veh = "Land_Pod_Heli_Transport_04_repair_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
			case 8: {_veh = "Land_Pod_Heli_Transport_04_ammo_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
			case 9: {_veh = "Land_Pod_Heli_Transport_04_bench_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
			case 10: {_veh = "Land_Pod_Heli_Transport_04_covered_F" createVehicle (getMarkerPos "Ammo_Supply_drop")};
		};
sleep 0.5;

//---- Parachute
waitUntil {sleep 3; !isNull (ropeAttachedTo _veh)};
sleep 0.5;
waitUntil {sleep 0.5; isNull (ropeAttachedTo _veh)};
if (getPos _veh select 2 < 50) then {hint "Модуль сброшен без парашюта    (малая высота)"} else 
	{
		sleep 3;
		waitUntil {getPos _veh select 2 <= 200};
		_velocity = velocity _veh;
		sleep 0.1;
		_light = createVehicle [_lightType, position _veh, [], 0, 'NONE'];
		_light attachTo [_veh, [0, 2, 0.15]]; 
		sleep 0.1;
		_smoke = createVehicle [_smokeType, position _veh, [], 0, 'NONE'];
		_smoke attachTo [_veh, _veh_pos];
		sleep 0.1;
		_chute = createVehicle ["B_Parachute_02_F", position _veh, [], 0, "CAN_COLLIDE"];
		_veh attachTo [_chute, _veh_pos];
		sleep 0.1;
		_chute setVelocity _velocity;
		waitUntil {sleep 0.5; getPos _veh select 2 < 10 || isNull _chute};
		sleep 0.1;
		detach _veh;
		sleep 10;
		_smoke2 = _smokeType createVehicle [getPos _veh select 0, getPos _veh select 1,5];
	};