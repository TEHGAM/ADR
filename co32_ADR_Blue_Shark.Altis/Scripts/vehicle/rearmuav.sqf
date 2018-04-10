private ["_veh","_uav"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

_uav = ["B_UAV_02_CAS_F", "B_UAV_02_F", "B_T_UAV_03_F","B_UAV_05_F"];

if (!((typeOf _veh) in _uav)) exitWith { 
	_veh vehicleChat "This pad is for UAV service only, soldier!"; 
};

/*if (!(_veh isKindOf "B_UAV_02_CAS_F")) exitWith { 
	_veh vehicleChat "This pad is for UAV service only, soldier!"; 
};*/

_veh vehicleChat "Servicing UAV, please wait ...";

_veh setFuel 0;
sleep 10;
//---------- RE-ARMING
_veh vehicleChat "Re-arming ...";
sleep 100;
//---------- REPAIRING
_veh vehicleChat "Repairing ...";
sleep 100;
//---------- REFUELING
_veh vehicleChat "Refueling ...";
sleep 50;
//---------- FINISHED

_veh setDamage 0;
_veh vehicleChat "Repaired (100%).";

_veh setVehicleAmmo 1;
_veh vehicleChat "Re-armed (100%).";

_veh setFuel 1;
_veh vehicleChat "Refuelled (100%).";

sleep 2;

_veh vehicleChat "Service complete.";