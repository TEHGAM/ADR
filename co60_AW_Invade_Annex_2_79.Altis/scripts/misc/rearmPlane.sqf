private ["_veh"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

if (!(_veh isKindOf "plane")) exitWith { 
	_veh vehicleChat "Эта площадка для самолетов!"; 
};

_veh vehicleChat "Обслуживание займет три минуты.";

_veh setFuel 0;

//---------- RE-ARMING

_veh vehicleChat "Перезарядка ...";

uiSleep 60;

_veh setVehicleAmmo 1;

//---------- REPAIRING

uiSleep 2;

_veh vehicleChat "Ремонт ...";

uiSleep 60;

_veh setDamage 0;

//---------- REFUELING

uiSleep 2;

_veh vehicleChat "Заправка ...";

uiSleep 60;

_veh setFuel 1;

//---------- FINISHED

uiSleep 2;

_veh vehicleChat "Обслуживание завершено. Приятного полета!";