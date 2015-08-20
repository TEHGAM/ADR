private ["_veh"];
_veh = _this select 0;

if (!(_veh isKindOf "LandVehicle")) exitWith { _veh vehicleChat "Этот сервис только для наземной техники"; };

_veh vehicleChat "Сервис. Ожидайте...";

_veh setFuel 0;

//---------- RE-ARMING
_veh vehicleChat "Перезарядка ...";

uiSleep 10;

_veh setVehicleAmmo 1;
_veh vehicleChat "Перезарядка завершена.";

//---------- REPAIRING

uiSleep 2;

_veh vehicleChat "Ремонт ...";

uiSleep 10;

_veh setDamage 0;
_veh vehicleChat "Отремонтирован.";

//---------- REFUELING

uiSleep 2;

_veh vehicleChat "Заправка ...";

uiSleep 10;

_veh setFuel 1;
_veh vehicleChat "Заправлен.";

//---------- FINISHED

uiSleep 2;

_veh vehicleChat "Обслуживание завершено. Приятного путешествия!";