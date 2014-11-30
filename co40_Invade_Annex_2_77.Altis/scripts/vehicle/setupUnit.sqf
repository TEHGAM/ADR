_unit = _this select 0;
_type = typeOf _unit;

_slingable = ["I_Heli_Transport_02_F", "B_Heli_Transport_03_F", "O_Heli_Transport_04_F"];

if(isNull _unit) exitWith {};

if(_type in _slingable) then {
	[_unit] execVM "scripts\vehicle\aw_sling\aw_sling_setupUnit.sqf";
	_unit addAction ["<t color='#00B2EE'>Выгрузить снаряжение</t>","scripts\vehicle\clear\clear.sqf",[],-97,false];
};

if ((_unit isKindOf "B_Heli_Transport_01_camo_F") || (_unit isKindOf "B_Heli_Transport_01_F")) then {
	[_unit] execVM "scripts\vehicle\ghosthawk\heliDoor.sqf";
	_unit addAction ["<t color='#00B2EE'>Cбросить оперативный боезапас</t>", "scripts\vehicle\drop\drop.sqf",[1],0,false,true,""," driver  _target == _this"];
	_unit addAction ["<t color='#00B2EE'>Выгрузить снаряжение</t>","scripts\vehicle\clear\clear.sqf",[],-97,false];
};


