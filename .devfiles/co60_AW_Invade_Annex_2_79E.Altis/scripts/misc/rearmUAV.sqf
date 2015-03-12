private ["_veh"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

if (!(_veh isKindOf "B_UAV_02_CAS_F")) exitWith { 
	_veh vehicleChat "Солдат! Эта площадка предназначена только для обслуживания БПЛА!"; 
};

_veh vehicleChat "БПЛА обслуживается, Пожалуйста ждите ...";

_veh setFuel 0;

//---------- RE-ARMING

sleep 10;

_veh vehicleChat "Перезаряжаем...";

//---------- REPAIRING

sleep 10;

_veh vehicleChat "Ремонтируем...";

//---------- REFUELING

sleep 10;

_veh vehicleChat "Заправляем...";

//---------- FINISHED

sleep 10;

_veh setDamage 0;
_veh vehicleChat "Отремонтирован (100%).";

_veh setVehicleAmmo 1;
_veh vehicleChat "Перезаряжен (100%).";

_veh setFuel 1;
_veh vehicleChat "Заправлен (100%).";

sleep 2;

_veh vehicleChat "Обслуживание завершено.";