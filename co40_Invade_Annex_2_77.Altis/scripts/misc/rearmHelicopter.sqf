private ["_veh"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

if (!(_veh isKindOf "air")) exitWith { 
	_veh vehicleChat "Эта площадка предназначена только для обслуживания авиации!"; 
};

_veh vehicleChat "Обслуживание авиации. Ждите...";

_veh setFuel 0;

//---------- RE-ARMING

sleep 10;

_veh vehicleChat "Перезарядка...";

//---------- REPAIRING

sleep 10;

_veh vehicleChat "Ремонт...";

//---------- REFUELING

sleep 10;

_veh vehicleChat "Дозаправка...";

//---------- FINISHED

sleep 10;

_veh setDamage 0;
_veh vehicleChat "Отремонтирован (100%).";

_veh setVehicleAmmo 1;
_veh vehicleChat "Перезаряжен (100%).";

_veh setFuel 1;
_veh vehicleChat "Дозаправлен (100%).";

sleep 2;

_veh vehicleChat "Обслуживание завершено.";
