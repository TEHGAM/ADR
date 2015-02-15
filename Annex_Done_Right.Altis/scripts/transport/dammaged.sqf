private ["_vehicle", "_dammage", "_target"];

_vehicle = _this select 0;

if (getDammage _vehicle > 0.5) then
{
	_target = _vehicle getVariable "AttachedVehicle";
	_vehicle setVariable ["AttachedVehicle", objNull];
	detach _target;
};
