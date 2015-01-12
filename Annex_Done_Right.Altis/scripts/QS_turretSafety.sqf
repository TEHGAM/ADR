/*
File: QS_turretSafety.sqf
Author:

	Quiksilver
	
Last modified:
	
	31/12/2014 ArmA 1.36 by Quiksilver
	
Description:

	Pilot control over mounted aircraft weapon turrets
	
Instructions:

	Place the below line in 'initPlayerLocal.sqf' in your main mission directory:
	
		[] execVM 'QS_turretSafety.sqf';

Conditions of use:

	Please leave this section intact, do not remove/modify author section.
	You may modify the 'Last modified' section.
	All the copyright stuff, etc.
____________________________________________________________________________*/

private ["_pilotTypes","_pilotsOnly","_iAmPilot","_exit"];

//========================================================================== CONFIG

_pilotTypes = ["B_Pilot_F","B_Helipilot_F","B_helicrew_F","O_Pilot_F","O_helipilot_F","O_helicrew_F","I_pilot_F","I_helipilot_F","I_helicrew_F","C_man_pilot_F"];
_pilotsOnly = FALSE;			// If TRUE then only the above pilot roles will be able to use this ability. If FALSE then anybody who loads this script can use it.
_exit = FALSE;

//================================== FILTER IF NECESSARY

if (_pilotsOnly) then {
	_iAmPilot = ({typeOf player == _x} count _pilotTypes) > 0;
	if (_iAmPilot) then {false} else {_exit = TRUE;};
};
if (_exit) exitWith {};

//========================================================================== FUNCTIONS

QS_fnc_turret = compileFinal "
	private [""_v"",""_t"",""_w"",""_type""];

	_v = _this select 0;
	_t = _this select 1;
	_w = _this select 2;
	_type = _this select 3;

	if (_type isEqualTo 0) then {
		_v removeWeaponTurret [_w,[_t]];
	};

	if (_type isEqualTo 1) then {
		_v addWeaponTurret [_w,[_t]];
	};
";

QS_fnc_turretActionCancel = compileFinal "
	_v = vehicle player;
	QS_turretControl = FALSE;
	QS_inturretloop = FALSE;
	[_v,1,0] call QS_fnc_turretReset;
	[_v,2,0] call QS_fnc_turretReset;
";

QS_fnc_turretActions = compileFinal "
	private [""_array"",""_v"",""_turret"",""_lock""];
	_array = _this select 3;
	_v = _array select 0;
	_turret = _array select 1;
	_lock = _array select 2;
	{player removeAction _x;} count QS_turretActions;
	player removeAction QS_turretAction;
	if (_lock isEqualTo 0) exitWith {
		if (_turret isEqualTo 1) then {
			[[_v,1,""LMG_Minigun_Transport"",1],""QS_fnc_turret"",TRUE,FALSE] spawn BIS_fnc_MP;
			_v setVariable [""QS_turretL_locked"",FALSE,TRUE];
		};
		if (_turret isEqualTo 2) then {
			[[_v,2,""LMG_Minigun_Transport2"",1],""QS_fnc_turret"",TRUE,FALSE] spawn BIS_fnc_MP;
			_v setVariable [""QS_turretR_locked"",FALSE,TRUE];
		};	
		QS_turretControl = FALSE;
		QS_inturretloop = FALSE;
	};
	if (_lock isEqualTo 1) exitWith {
		if (_turret isEqualTo 1) then {
			[[_v,1,""LMG_Minigun_Transport"",0],""QS_fnc_turret"",TRUE,FALSE] spawn BIS_fnc_MP;
			_v setVariable [""QS_turretL_locked"",TRUE,TRUE];
		};
		if (_turret isEqualTo 2) then {
			[[_v,2,""LMG_Minigun_Transport2"",0],""QS_fnc_turret"",TRUE,FALSE] spawn BIS_fnc_MP;
			_v setVariable [""QS_turretR_locked"",TRUE,TRUE];
		};
		QS_turretControl = FALSE;
		QS_inturretloop = FALSE;
	};
";

QS_fnc_turretControl = compileFinal "
	private [""_v"",""_v2""];
	_v = vehicle player;
	QS_turretActions = [];
	{player removeAction _x;} count QS_turretActions;
	player removeAction QS_turretAction;
	if (isNil {_v getVariable ""QS_turretSafety""}) then {
		_v setVariable [""QS_turretSafety"",TRUE,TRUE];
		_v setVariable [""QS_turretL_locked"",FALSE,TRUE];
		_v setVariable [""QS_turretR_locked"",FALSE,TRUE];
	};
	if (_v getVariable ""QS_turretL_locked"") then {
		QS_turretLUnlockAction = player addAction [
			""Разблокировать левую турель"",
			QS_fnc_turretActions,
			[_v,1,0],
			80,
			FALSE,
			FALSE,
			'',
			'[] call QS_fnc_conditionTurretActionUnlockL'
		];
		0 = QS_turretActions pushBack QS_turretLUnlockAction;
	};
	if (_v getVariable ""QS_turretR_locked"") then {
		QS_turretRUnlockAction = player addAction [
			""Разблокировать правую турель"",
			QS_fnc_turretActions,
			[_v,2,0],
			79,
			FALSE,
			FALSE,
			'',
			'[] call QS_fnc_conditionTurretActionUnlockR'
		];
		0 = QS_turretActions pushBack QS_turretRUnlockAction;
	};
	if (!(_v getVariable ""QS_turretL_locked"")) then {
		QS_turretLLockAction = player addAction [
			""Заблокировать левую турель"",
			QS_fnc_turretActions,
			[_v,1,1],
			78,
			FALSE,
			FALSE,
			'',
			'[] call QS_fnc_conditionTurretActionLockL'
		];
		0 = QS_turretActions pushBack QS_turretLLockAction;
	};
	if (!(_v getVariable ""QS_turretR_locked"")) then {
		QS_turretRLockAction = player addAction [
			""Заблокировать правую турель"",
			QS_fnc_turretActions,
			[_v,2,1],
			77,
			FALSE,
			FALSE,
			'',
			'[] call QS_fnc_conditionTurretActionLockR'
		];
		0 = QS_turretActions pushBack QS_turretRLockAction;
	};
	QS_turretActionCancel = player addAction [
		""Отключить дейсвия турели"",
		QS_fnc_turretActionCancel,
		[],
		76
	];
	0 = QS_turretActions pushBack QS_turretActionCancel;
	if (!(QS_inturretloop)) then {
		QS_inturretloop = TRUE;
		[_v] spawn {
			private [""_v"",""_v2""];
			_v = _this select 0;
			QS_turretControl = TRUE;
			while {QS_turretControl} do {
				_v2 = vehicle player;
				if ((!alive player) || {(!(player isEqualTo player))} || {(!(_v2 isEqualTo _v))}) then {
					QS_inturretloop = FALSE;
					QS_turretControl = FALSE;
					[_v,1,0] call QS_fnc_turretReset;
					[_v,2,0] call QS_fnc_turretReset;
				};
				sleep 0.5;
			};
			QS_turretAction = player addAction [""Меню турелей"",QS_fnc_turretControl,[],-95,FALSE,FALSE,'','[] call QS_fnc_conditionTurretControl'];
		};
	};
";

QS_fnc_turretReset = compileFinal "
	private [""_v"",""_turret"",""_lock""];
	_v = _this select 0;
	_turret = _this select 1;
	_lock = _this select 2;
	QS_turretControl = FALSE;
	{player removeAction _x;} count QS_turretActions;
	if (_lock isEqualTo 0) exitWith {
		if (_turret isEqualTo 1) then {
			[[_v,1,""LMG_Minigun_Transport"",1],""QS_fnc_turret"",true,false] spawn BIS_fnc_MP;
			_v setVariable [""QS_turretL_locked"",FALSE,TRUE];
		};
		if (_turret isEqualTo 2) then {
			[[_v,2,""LMG_Minigun_Transport2"",1],""QS_fnc_turret"",true,false] spawn BIS_fnc_MP;
			_v setVariable [""QS_turretR_locked"",FALSE,TRUE];
		};	
	};
	if (_lock isEqualTo 1) exitWith {
		if (_turret isEqualTo 1) then {
			[[_v,1,""LMG_Minigun_Transport"",0],""QS_fnc_turret"",true,false] spawn BIS_fnc_MP;
			_v setVariable [""QS_turretL_locked"",TRUE,TRUE];
		};
		if (_turret isEqualTo 2) then {
			[[_v,2,""LMG_Minigun_Transport2"",0],""QS_fnc_turret"",true,false] spawn BIS_fnc_MP;
			_v setVariable [""QS_turretR_locked"",TRUE,TRUE];
		};
	};
";

QS_fnc_conditionTurretActionLockL = compileFinal "
	private [""_c"",""_v"",""_type""];
	_c = FALSE;
	_v = vehicle player;
	_type = typeOf _v;
	_heliTypes = [""B_Heli_Transport_01_camo_F"",""B_Heli_Transport_01_F"",""B_Heli_Transport_03_F""];
	if (_type in _heliTypes) then {
		if (!(_v getVariable ""QS_turretL_locked"")) then {
			_c = TRUE;
		};
	};
	_c;	
";

QS_fnc_conditionTurretActionLockR = compileFinal "
	private [""_c"",""_v"",""_type""];
	_c = FALSE;
	_v = vehicle player;
	_type = typeOf _v;
	_heliTypes = [""B_Heli_Transport_01_camo_F"",""B_Heli_Transport_01_F"",""B_Heli_Transport_03_F""];
	if (_type in _heliTypes) then {
		if (!(_v getVariable ""QS_turretR_locked"")) then {
			_c = TRUE;
		};
	};
	_c;
";

QS_fnc_conditionTurretActions = compileFinal "
	private [""_c"",""_v"",""_type""];
	_c = TRUE;
	_v = vehicle player;
	_type = typeOf _v;
	_heliTypes = [""B_Heli_Transport_01_camo_F"",""B_Heli_Transport_01_F"",""B_Heli_Transport_03_F""];
	if (_type in _heliTypes) then {
		if (player isEqualTo (driver _v)) then {
			_c = TRUE;
		};
	};
	_c;
";

QS_fnc_conditionTurretActionUnlockL = compileFinal "
	private [""_c"",""_v"",""_type""];
	_c = FALSE;
	_v = vehicle player;
	_type = typeOf _v;
	_heliTypes = [""B_Heli_Transport_01_camo_F"",""B_Heli_Transport_01_F"",""B_Heli_Transport_03_F""];
	if (_type in _heliTypes) then {
		if (_v getVariable ""QS_turretL_locked"") then {
			_c = TRUE;
		};
	};
	_c;
";

QS_fnc_conditionTurretActionUnlockR = compileFinal "
	private [""_c"",""_v"",""_type""];
	_c = FALSE;
	_v = vehicle player;
	_type = typeOf _v;
	_heliTypes = [""B_Heli_Transport_01_camo_F"",""B_Heli_Transport_01_F"",""B_Heli_Transport_03_F""];
	if (_type in _heliTypes) then {
		if (_v getVariable ""QS_turretR_locked"") then {
			_c = TRUE;
		};
	};
	_c;
";

QS_fnc_conditionTurretControl = compileFinal "
	private [""_c"",""_v"",""_type""];
	_c = FALSE;
	_v = vehicle player;
	_type = typeOf _v;
	_heliTypes = [""B_Heli_Transport_01_camo_F"",""B_Heli_Transport_01_F"",""B_Heli_Transport_03_F""];
	if (_type in _heliTypes) then {
		if (player isEqualTo (driver _v)) then {
			_c = TRUE;
		};
	};
	_c;
";

//======================= INIT
// Feel free to adjust the initialization to fit your scenario, according to your confidence with getting it right.
// Another way is to use the 'onPlayerRespawn.sqf' event script, however this way is simpler for pre-packaged 'plug 'n play' for newbies

QS_ehRespawnTurretSafety = player addEventHandler [
	"Respawn",
	{
		QS_inturretloop = FALSE;
		QS_turretAction = player addAction ["Turret Safety",QS_fnc_turretControl,[],-95,FALSE,FALSE,'','[] call QS_fnc_conditionTurretControl'];
	}
];

QS_inturretloop = FALSE;
QS_turretAction = player addAction ["Turret Safety",QS_fnc_turretControl,[],-95,FALSE,FALSE,'','[] call QS_fnc_conditionTurretControl'];
