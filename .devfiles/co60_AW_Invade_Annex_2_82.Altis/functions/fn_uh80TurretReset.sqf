/*
@filename: fn_uh80TurretActionCancel.sqf
Author:

	Quiksilver
	
Last modified:

	22/10/2014 ArmA 1.32
	
Description:

	Turret actions
	
	_v setVariable ["turretL_locked",FALSE,TRUE];
	_v setVariable ["turretR_locked",FALSE,TRUE];
_______________________________________________*/

private ["_v","_turret","_lock"];

uh80turret_control = FALSE;

_v = _this select 0;
_turret = _this select 1;
_lock = _this select 2;

{player removeAction _x;} count turretActions;

if (_lock == 0) exitWith {
	if (_turret == 1) then {
		[[_v,1,"LMG_Minigun_Transport",1],"QS_fnc_uh80Turret",true,false] spawn BIS_fnc_MP;
		_v setVariable ["turretL_locked",FALSE,TRUE];
	};
	if (_turret == 2) then {
		[[_v,2,"LMG_Minigun_Transport2",1],"QS_fnc_uh80Turret",true,false] spawn BIS_fnc_MP;
		_v setVariable ["turretR_locked",FALSE,TRUE];
	};	
};

if (_lock == 1) exitWith {
	if (_turret == 1) then {
		[[_v,1,"LMG_Minigun_Transport",0],"QS_fnc_uh80Turret",true,false] spawn BIS_fnc_MP;
		_v setVariable ["turretL_locked",TRUE,TRUE];
	};
	if (_turret == 2) then {
		[[_v,2,"LMG_Minigun_Transport2",0],"QS_fnc_uh80Turret",true,false] spawn BIS_fnc_MP;
		_v setVariable ["turretR_locked",TRUE,TRUE];
	};
};