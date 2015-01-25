private ["_Vehicle", "_Value", "_Offset"];

_Vehicle = _this select 0;
_Value = _this select 1;
_Offset = _this select 2;

_Vehicle setVariable ["Classification", _Value];

if (_Value < 1) exitWith {}; 

if (_vehicle getVariable "AttachedVehicle" == objNull) then
{
	_Vehicle setVariable ["AttachedVehicle", objNull];
};
	_Vehicle setVariable ["AttachOffset", _Offset];

_Vehicle removeAction k;
_Vehicle removeAction k1;

k = _Vehicle addAction["<t size='1.5' shadow='2'color='#C9C900'>Прицепить технику</t>", "scripts\transport\attach.sqf", [_Vehicle], 10, false, true, "", "isPlayer driver _target && isNull(_target getVariable ""AttachedVehicle"") && !isNull(driver _target getVariable ""CurrentTarget"")"];
k1 = _Vehicle addAction["<t size='1.5' shadow='2'color='#C9C900'>Отцепить технику</t>", "scripts\transport\detach.sqf", [_Vehicle], 10, false, true, "", "!isNull(_target getVariable ""AttachedVehicle"")"];

_Vehicle addEventHandler ["GetOut", { if (_this select 1 == "driver") then { [(_this select 0)] execVM "scripts\transport\detach.sqf"; }}];
_Vehicle addEventHandler ["GetIn", { if (_this select 1 == "driver") then { [(_this select 0)] execVM "scripts\transport\detach.sqf"; }}];
