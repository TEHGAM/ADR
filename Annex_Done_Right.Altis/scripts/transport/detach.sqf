private ["_player", "_target", "_vehicle", "_velocity"];

_vehicle = _this select 0;
_player = driver _vehicle;
_target = _vehicle getVariable "AttachedVehicle";
_velocity = velocity _vehicle;

if (isNull(_target)) exitWith { }; 
ropeCut [rope1,10];
ropeCut [rope2,10];
ropeCut [rope3,10];
ropeCut [rope4,10];

_target setmass tmass;

_target setVelocity _velocity;
_vehicle setVariable ["AttachedVehicle", objNull];
_vehicle vehicleChat format ["%1 отцеплена.", typeof(_target)];

if ((getPos _target select 2)>100) then
{
	waitUntil{(getPos _target select 2)<=100};
	[_target, 0, 0] call BIS_fnc_setPitchBank;
	_chute = createVehicle ["B_Parachute_02_F", [position _target select 0,position _target select 1,position _target select 2], [], 0, 'FORM'];
	_chute attachTo [_target, [0, 0, 0]];
	detach _chute;
	_target attachTo [_chute, [0, 0, 0]];
	waitUntil {position _target select 2 < 0.1 || isNull _chute};
	detach _target;
};
ropeDestroy rope1;
ropeDestroy rope2;
ropeDestroy rope3;
ropeDestroy rope4;


