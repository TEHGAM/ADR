call compile preprocessFile "scripts\vehicle\sling\sling_config.sqf";

_helo = _this select 0;
_heloType = typeOf _helo;

if(getPos _helo select 2 > maxLiftingHeight) exitWith{hint "Too High To Sling";};

_nearUnits = (getPos _helo) nearEntities [["Car","Motorcycle","Tank","Ship"],maxLiftingDistance];
if(count _nearUnits < 1) exitWith{hint "No Sling Targets";};

_liftable = [];
_notLiftable =[];
if((_heloType == "B_Heli_Light_01_F") OR (_heloType == "B_Heli_Light_02_armed_F")) then {
	_liftable = light;
	_notLiftable = medium + heavy + superheavy;
};
if((_heloType == "B_Heli_Transport_01_camo_F") || (_heloType == "B_Heli_Transport_01_F")) then {
	_liftable = light + medium;
	_notLiftable = heavy + superheavy;
};
if((_heloType == "I_Heli_Transport_02_F")) then {
	_liftable = light + medium + heavy + superheavy;
	_notLiftable = [];
};

//Find closest valid unit to sling
_heloPos = getPos _helo;
_heloVel = velocity _helo;
_heloPos = [(_heloPos select 0) + (_heloVel select 0), (_heloPos select 1) + (_heloVel select 1), (_heloPos select 2) + (_heloVel select 2)];
// chucky - one second projected position gives significant improvement in realism and lag tolerance ... without this, chopper feels like its picking up the vehicle behind the intended vehicle

_closestUnit = nil;
_closestDistance = 999;
{
	_unit = _x;
	_unitPos = getPos _unit;
	_unitDistance = _unitPos distance _heloPos;
	
	if(_unitDistance < _closestDistance) then {
		_closestUnit = _unit;
		_closestDistance = _unitDistance;
	};
} forEach _nearUnits;

_closestUnitType = typeOf _closestUnit;

if(({_closestUnitType == _x} count _notLiftable) > 0) exitWith{hint "Too heavy.";};

if(({_closestUnitType == _x} count _liftable) < 1) exitWith{hint "No lift hooks.";};

//if(count (crew _closestUnit) > 0) exitWith{hint "Crew in vehicle.";};

//Find sling position
_minZ = (((boundingBox _helo) select 0) select 2) - 1;
_midY = (((boundingBox _helo) select 1) select 1) / 3;
_attachPoint = [0,_midY,_minZ];

//Attach
[_closestUnit] call fnWeightParameters ;
_closestUnit attachTo [_helo,_attachPoint];
_helo setVariable ["sling_attached",true,true];
_helo setVariable ["sling_object",_closestUnit,true];
