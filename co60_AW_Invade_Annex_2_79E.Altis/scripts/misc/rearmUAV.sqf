private ["_veh"];
_veh = _this select 0;

if (_veh isKindOf "ParachuteBase" || !alive _veh) exitWith {};

if (!(_veh isKindOf "B_UAV_02_CAS_F")) exitWith { 
	_veh vehicleChat "������! ��� �������� ������������� ������ ��� ������������ ����!"; 
};

_veh vehicleChat "���� �������������, ���������� ����� ...";

_veh setFuel 0;

//---------- RE-ARMING

sleep 10;

_veh vehicleChat "������������...";

//---------- REPAIRING

sleep 10;

_veh vehicleChat "�����������...";

//---------- REFUELING

sleep 10;

_veh vehicleChat "����������...";

//---------- FINISHED

sleep 10;

_veh setDamage 0;
_veh vehicleChat "�������������� (100%).";

_veh setVehicleAmmo 1;
_veh vehicleChat "����������� (100%).";

_veh setFuel 1;
_veh vehicleChat "��������� (100%).";

sleep 2;

_veh vehicleChat "������������ ���������.";