private ["_player", "_target", "_vehicle", "_offset"];

_vehicle = _this select 0;
_player = driver _vehicle;

_target = _player getVariable "CurrentTarget";
_offset = _vehicle getVariable "AttachOffset";

if (isNull_target) exitWith {};
target1 = _target;
[["scripts\transport\mass.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;

_target engineOn false;
rope1 = ropeCreate[_vehicle, [0, 1.5, -2.35], _target, [0.5, 0, -0.2], 10];
rope2 = ropeCreate[_vehicle, [0, 1.5, -2.35], _target, [-0.5, 0, -0.2], 10];
rope3 = ropeCreate[_vehicle, [0, 1.5, -2.35], _target, [0, 2, -0.2], 10];
rope4 = ropeCreate[_vehicle, [0, 1.5, -2.35], _target, [0, -2, -0.2], 10];
_player setVariable ["CurrentTarget", objNull];
_vehicle setVariable ["AttachedVehicle", _target];
 _vehicle vehicleChat format ["%1 зацеплена", typeof _target]; 
 