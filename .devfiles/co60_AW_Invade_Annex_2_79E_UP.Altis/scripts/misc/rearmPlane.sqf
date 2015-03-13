private ["_veh"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

if (!(_veh isKindOf "plane")) exitWith { 
	_veh vehicleChat "Эта площадка для авиации"; 
};

_veh vehicleChat "Обслуживание авиации, займет 3 минуты";

_veh setFuel 0;

//---------- RE-ARMING

sleep 60;

_veh vehicleChat "Перезарядка ...";

//---------- REPAIRING

sleep 60;

_veh vehicleChat "Ремонт ...";

//---------- REFUELING

sleep 60;

_veh vehicleChat "Заправка ...";

//---------- FINISHED

sleep 10;

_veh setDamage 0;
_veh vehicleChat "Заряжен (100%).";

_veh setVehicleAmmo 1;
_veh vehicleChat "Отремонтирован (100%).";

_veh setFuel 1;
_veh vehicleChat "Заправлен (100%).";

sleep 2;

_veh vehicleChat "Обслуживание завершено.";