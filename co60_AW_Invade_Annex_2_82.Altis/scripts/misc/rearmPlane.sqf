private ["_veh"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

if (!(_veh isKindOf "plane")) exitWith { 
	_veh vehicleChat "This pad is for plane service only, soldier!"; 
};

_veh vehicleChat "Servicing airplane, this will take about 5 minutes";

_veh setFuel 0;

//---------- RE-ARMING

sleep 100;

_veh vehicleChat "Re-arming ...";

//---------- REPAIRING

sleep 100;

_veh vehicleChat "Repairing ...";

//---------- REFUELING

sleep 100;

_veh vehicleChat "Refueling ...";

//---------- FINISHED

sleep 10;

_veh setDamage 0;
_veh vehicleChat "Repaired (100%).";

_veh setVehicleAmmo 1;
_veh vehicleChat "Re-armed (100%).";

_veh setFuel 1;
_veh vehicleChat "Refuelled (100%).";

sleep 2;

_veh vehicleChat "Service complete.";