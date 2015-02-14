_helo = _this select 0;

if(getPos _helo select 2 > 7) exitWith{hint "Слишком Высоко, Чтобы Зацепить!";};

_nearUnits = (getPos _helo) nearEntities [["Car","Motorcycle","Tank","Ship"],7];
if(count _nearUnits < 1) exitWith{hint "Нет Техники Для Зацепки";};

//Add size checks here
_heavyCant = ["B_MRAP_01_F", "B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F", "O_MRAP_02_F", "O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F", "B_Boat_Armed_01_minigun_F"];
_mediumCant = ["B_Quadbike_01_F", "B_G_Offroad_01_F", "B_G_Offroad_01_armed_F", "B_Boat_Transport_01_F", "B_SDV_01_F"];
_lightCant = ["Tank"];


_cantLift = [];
if ((_helo isKindOf "B_Heli_Transport_03_F") || (_helo isKindOf "O_Heli_Transport_04_F")) then {
	_cantLift = _mediumCant + _heavyCant
};

if (_helo isKindOf "I_Heli_Transport_02_F") then {
	_cantLift = _mediumCant
};

//Check for vehicles not too heavy to lift
_targets = [];
for [{_y=0},{_y<(count _nearUnits)},{_y=_y+1}] do
{
	_testUnit = _nearUnits select _y;
	_add = true;
	{
		if((_testUnit isKindOf _x) OR (count (crew _testUnit) > 0)) then {_add = false};
	}forEach _cantLift;
	if(_add) then {_targets = _targets + [_testUnit]};
};
if(count _targets < 1) exitWith{hint "Невозможно Зацепить (Слишком Тяжелый|Не Пустой)";};


//Find closest valid unit to sling
_target = _targets select 0;
for [{_x=1},{_x<(count _targets)},{_x=_x+1}] do
{
	_testUnit = _targets select _x;
	if(([getPos _target select 0,getPos _target select 1,0] distance [getPos _helo select 0,getPos _helo select 1,0]) < ([getPos _testUnit select 0,getPos _testUnit select 1,0] distance [getPos _helo select 0,getPos _helo select 1,0])) then {_target = _testUnit};
};

//Find sling position
_minZ = (((boundingBox _helo) select 0) select 2) - 1;
_midY = (((boundingBox _helo) select 1) select 1) / 3;
_attachPoint = [0,_midY,_minZ];

//Attach
_target attachTo [_helo,_attachPoint];
_helo setVariable ["aw_sling_attached",true,true];
_helo setVariable ["aw_sling_object",_target,true];
[_helo] execVM "scripts\vehicle\aw_sling\aw_sling_heightDisplay.sqf";