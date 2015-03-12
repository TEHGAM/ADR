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

_v = vehicle player;
uh80turret_control = FALSE;
inturretloop = FALSE;
[_v,1,0] call QS_fnc_uh80TurretReset;
[_v,2,0] call QS_fnc_uh80TurretReset;