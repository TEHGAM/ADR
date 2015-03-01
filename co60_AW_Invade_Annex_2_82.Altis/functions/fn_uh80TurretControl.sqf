/*
@filename: fn_uh80TurretControl.sqf
Author:

	Quiksilver
	
Last modified:

	22/10/2014 ArmA 1.32
	
Description:

	Turret control actions
_______________________________________________*/

private ["_v","_v2"];

_v = vehicle player;

turretActions = [];

{player removeAction _x;} count turretActions;
player removeAction UH80TurretAction;

if (_v getVariable "turretL_locked") then {
	turretLUnlockAction = player addAction [
		"Unlock Turret - Left",
		QS_fnc_uh80TurretActions,
		[_v,1,0],
		80,
		FALSE,
		FALSE,
		'',
		'[] call QS_fnc_conditionUH80TurretActionUnlockL'
	];
	0 = turretActions pushBack turretLUnlockAction;
};

if (_v getVariable "turretR_locked") then {
	turretRUnlockAction = player addAction [
		"Unlock Turret - Right",
		QS_fnc_uh80TurretActions,
		[_v,2,0],
		79,
		FALSE,
		FALSE,
		'',
		'[] call QS_fnc_conditionUH80TurretActionUnlockR'
	];
	0 = turretActions pushBack turretRUnlockAction;
};

if (!(_v getVariable "turretL_locked")) then {
	turretLLockAction = player addAction [
		"Lock Turret - Left",
		QS_fnc_uh80TurretActions,
		[_v,1,1],
		78,
		FALSE,
		FALSE,
		'',
		'[] call QS_fnc_conditionUH80TurretActionLockL'
	];
	0 = turretActions pushBack turretLLockAction;
};

if (!(_v getVariable "turretR_locked")) then {
	turretRLockAction = player addAction [
		"Lock Turret - Right",
		QS_fnc_uh80TurretActions,
		[_v,2,1],
		77,
		FALSE,
		FALSE,
		'',
		'[] call QS_fnc_conditionUH80TurretActionLockR'
	];
	0 = turretActions pushBack turretRLockAction;
};

turretActionCancel = player addAction [
	"Cancel Turret Action",
	QS_fnc_uh80TurretActionCancel,
	[],
	76
];
0 = turretActions pushBack turretActionCancel;

if (!(inturretloop)) then {
	inturretloop = TRUE;
	[_v] spawn {
		private ["_v","_v2"];
		_v = _this select 0;
		uh80turret_control = TRUE;
		while {uh80turret_control} do {
			_v2 = vehicle player;
			if ((!alive player) || {(player != player)} || {(_v2 != _v)}) then {
				inturretloop = FALSE;
				uh80turret_control = FALSE;
				[_v,1,0] call QS_fnc_uh80TurretReset;
				[_v,2,0] call QS_fnc_uh80TurretReset;
			};
			sleep 3;
		};
		UH80TurretAction = player addAction ["Turret Control",QS_fnc_uh80TurretControl,[],-95,false,false,'','[] call QS_fnc_conditionUH80TurretControl'];
	};
};