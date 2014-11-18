// by Xeno
#define THIS_FILE "x_uifuncs.sqf"
#include "x_setup.sqf"
//#include "functions.sqf"

#define CTRL(A) (_disp displayCtrl A)

// Get group color index
// Usage : '[unit] call FNC_GET_GROUP_COLOR_INDEX;'
// Return : number
INS_REV_FNCT_get_group_color_index = {
	private ["_phoneticCode", "_found", "_index", "_result", "_i", "_j"];
	
	// Set variable
	_unit = _this select 0;
	_phoneticCode = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf"];
	_found = false;
	_index = 0;
	
	// Find group name
	{
		for "_i" from 1 to 4 do {
		 	for "_j" from 1 to 3 do {
		 		_groupName = format["%1 %2-%3", _x, _i, _j];
		 		if (format["b %1",_groupName] == str(group _unit) || format["o %1",_groupName] == str(group _unit)) exitWith {
		 			_found = true;
		 		};
		 		_index = _index + 1;
			};
			if (_found) exitWith {};
		};
		if (_found) exitWith {};
	} forEach _phoneticCode;
	
	// If not found, return 0
	if (!_found) then {
		_result = 0;
	} else {
		_result = _index % 10;
	};
	
	_result
};

// Get group color
// Usage : '[unit] call FNC_GET_GROUP_COLOR;'
// Return : string
INS_REV_FNCT_get_group_color = {
	private ["_unit", "_colors", "_colorIndex", "_result"];
	
	// Set varialble
	_unit = _this select 0;
	_colors = ["ColorGreen","ColorYellow","ColorOrange","ColorPink","ColorBrown","ColorKhaki","ColorBlue","ColorRed","ColorBlack","ColorWhite"];
	_colorIndex = [_unit] call INS_REV_FNCT_get_group_color_index;
	
	// Set color
	_result = _colors select _colorIndex;
	
	// Return value
	_result
};

FUNC(squadmanagementfill) = {
	private ["_disp", "_units", "_i", "_helper", "_ctrl", "_ctrl2", "_sidegrppl", "_grptxtidc", "_grplbidc", "_grpbutidc", "_curgrp", "_leader", "_unitsar", "_name", "_isppp", "_index", "_pic", "_diff"];
	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	
	_units = if (isMultiplayer) then {playableUnits} else {switchableUnits};
		
	for "_i" from 0 to 49 do {
		_ctrl = _disp displayCtrl (4000 + _i);
		_ctrl ctrlShow true;
		_ctrl = _disp displayCtrl (3000 + _i);
		_ctrl ctrlShow true;
		_ctrl ctrlSetText (localize "STRD_Join");
		_ctrl ctrlEnable true;
		_ctrl = _disp displayCtrl (2000 + _i);
		_ctrl ctrlShow true;
		_ctrl = _disp displayCtrl (1000 + _i);
		_ctrl ctrlShow true;
		_ctrl = _disp displayCtrl (6000 + _i);
		_ctrl ctrlShow false;
		_ctrl = _disp displayCtrl (7000 + _i);
		_ctrl ctrlShow false;
	};
	
	
	_grptxtidc = 4000;
	_grplbidc = 2000;
	_grpbutidc = 3000;
	_grplockidc = 6000;
	_grplockbutidc = 7000;
		
	if (_grptxtidc < 4049) then {
		_diff = 4049 - _grptxtidc;
		for "_i" from (49 - _diff) to 49 do {
			_ctrl = _disp displayCtrl (4000 + _i);
			_ctrl ctrlShow false;
			_ctrl = _disp displayCtrl (3000 + _i);
			_ctrl ctrlShow false;
			_ctrl = _disp displayCtrl (2000 + _i);
			_ctrl ctrlShow false;
			_ctrl = _disp displayCtrl (1000 + _i);
			_ctrl ctrlShow false;
		};
	};
	ctrlSetFocus CTRL(9999);
};

FUNC(squadmgmtlockbuttonclicked) = {
	private ["_grp", "_lockedgr", "_disp", "_ctrl", "_ctrl2"];
	_grp = group player;
	_lockedgr = GV(_grp,GVAR(locked));
	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_ctrl = _disp displayCtrl _this;
	_ctrl2 = _disp displayCtrl (6000 + (_this - 7000));
	if (!isNil "_lockedgr" && {_lockedgr}) then {
		_grp setVariable [QGVAR(locked), false];
		_ctrl ctrlSetText localize "STRD_Lock";
		_ctrl2 ctrlShow false;
	} else {
		_grp setVariable [QGVAR(locked), true];
		_ctrl ctrlSetText localize "STRD_Unlock";
		_ctrl2 ctrlShow true;
	};
};

GVAR(sqtmgmtblocked) = false;

FUNC(squadmgmtbuttonclicked) = {
	
	if (GVAR(sqtmgmtblocked)) exitWith {};
	private ["_diff", "_grp", "_sidep", "_newgrp", "_count", "_oldgrp", "_disp", "_lbbox", "_lbidx", "_lbname"];
	if (typeName _this != typeName 1) exitWith {};
	_diff = _this - 5000;
	_oldgrp = group player;
	disableSerialization;
	// remove unit from group
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_lbbox = 2000 + _diff;
	_lbidx = lbCurSel CTRL(_lbbox);
	_lbname = if (_lbidx != -1) then {
		CTRL(_lbbox) lbData _lbidx
	} else {
		""
	};
	_ogrlocked = GV(_oldgrp,GVAR(locked));
	if (isNil "_ogrlocked") then {_ogrlocked = false};
	if (_ogrlocked && {player == leader _oldgrp}) then {
		_oldgrp setVariable [QGVAR(locked), false];
	};
	if (group player == _grp && {_lbname != name player} && {_lbidx != -1} && {player == leader _grp}) exitWith {
		_unittouse = objNull;
		{
			if (name _x == _lbname) exitWith {
				_unittouse = _x;
			};
		} forEach (units _grp);
		if (isNull _unittouse) exitWith {};
		// must be AI version
		if (!isPlayer _unittouse) exitWith {
			if (vehicle _unittouse == _unittouse) then {
				deleteVehicle _unittouse;
			} else {
				moveOut _unittouse;
				_unittouse spawn {
					scriptName "spawn_d_fnc_squadmgmtbuttonclicked_vecwait";
					private "_grp";
					_grp = group _this;
					waitUntil {sleep 0.331;vehicle _this == _this};
					deleteVehicle _this;
				};
			};
			if (dialog) then {
				call FUNC(squadmanagementfill);
			};
		};
		_newgrpp = createGroup side (group player);
		[_unittouse] joinSilent _newgrpp;
		GVAR(sqtmgmtblocked) = true;
		[_grp, _unittouse] spawn {
			scriptName "spawn_d_fnc_squadmgmtbuttonclicked_sqmgmtfill";
			waitUntil {!((_this select 1) in (units (_this select 1)))};
			if (dialog) then {
				call FUNC(squadmanagementfill);
			};
			GVAR(sqtmgmtblocked) = false;
		};
	};
	
	// Leave = new group
	if (group player == _grp) then {
		_sidep = side (group player);
		_newgrp = createGroup _sidep;
		[player] joinSilent _newgrp;
		if (GVAR(with_ai)) then {
			_ai_only = true;
			{
				if (isPlayer _x) exitWith {
					_ai_only = false;
				};
			} forEach (units _grp);
			if (_ai_only) then {
				{
					deleteVehicle _x;
				} forEach (units _grp);
				if (count (units _grp) > 0) then {
					{
						moveOut _x;
						_x spawn {
							scriptName "spawn_d_fnc_squadmgmtbuttonclicked_waitvec2";
							private "_grp";
							_grp = group _this;
							waitUntil {sleep 0.331;vehicle _this == _this};
							deleteVehicle _this;
							deleteGroup _grp;
						};
					} forEach (units _grp)
				};
			};
		};
		if (count (units _grp) == 0) then {
			if (!isNull _grp) then {
				deleteGroup _grp;
			};
		} else {
			[QGVAR(grpswmsg), [leader _grp, name player]] call FUNC(NetCallEventSTO);
		};
		// transfer name of old group to new group ? (setgroup ID) ?
		// edit: not needed, players can't leave groups with just himself in the group
	} else {
		[QGVAR(grpjoin), [_grp, player]] call FUNC(NetCallEventSTO);
		_count = 0;
		{
			if (isPlayer _x) then {
				__INC(_count);
			};
		} forEach (units _grp);
		
		if (_count == 1) then {
			[QGVAR(grpslead), [leader _grp, _grp, player]] call FUNC(NetCallEventSTO);
		};
		
		if (GVAR(with_ai)) then {
			_ai_only = true;
			{
				if (isPlayer _x) exitWith {
					_ai_only = false;
				};
			} forEach (units _oldgrp);
			if (_ai_only) then {
				{
					deleteVehicle _x;
				} forEach (units _oldgrp);
				if (count (units _oldgrp) > 0) then {
					{
						moveOut _x;
						_x spawn {
							scriptName "spawn_d_fnc_squadmgmtbuttonclicked_waitvec3";
							private "_grp";
							_grp = group _this;
							waitUntil {sleep 0.331;vehicle _this == _this};
							deleteVehicle _this;
							deleteGroup _grp;
						};
					} forEach (units _oldgrp)
				};
			};
		};
		if (count (units _oldgrp) == 0&& {!isNull _oldgrp}) then {
			deleteGroup _oldgrp;
		};
		if (!isNull _oldgrp) then {
			[QGVAR(grpswmsg), [leader _oldgrp, name player]] call FUNC(NetCallEventSTO);
		};
		[QGVAR(grpswmsgn), [leader _grp, name player]] call FUNC(NetCallEventSTO);
	};
	GVAR(sqtmgmtblocked) = true;
	
	_oldgrp spawn {
		scriptName "spawn_d_fnc_squadmgmtbuttonclicked_oldgrp";
		waitUntil {!(player in (units _this)) || {isNull _this}};
		if (dialog) then {
			call FUNC(squadmanagementfill);
		};
		GVAR(sqtmgmtblocked) = false;
	};

	
	// Update group color
	[] spawn {
		sleep 0.5;
		player setVariable ["INS_REV_PVAR_playerGroupColor", [player] call INS_REV_FNCT_get_group_color, true];
	};
};


// TODO: Invite for squadmgmt

FUNC(squadmgmtlbchanged) = {
	private ["_idc", "_car", "_idx", "_ctrl", "_diff", "_grp", "_disp", "_button", "_lbsel"];
	if (GVAR(sqtmgmtblocked)) exitWith {};
	PARAMS_2(_idc,_car);
	_idx = _car select 1;
	if (_idx == -1) exitWith {};
	_ctrl = _car select 0;
	_diff = _idc - 2000;

	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_button = 3000 + _diff;
	
	if (group player == _grp && {player == leader _grp}) then {
		_lbsel = _ctrl lbText _idx;
		if (name player != _lbsel) then {
			CTRL(_button) ctrlSetText localize "STRD_Remove";
		} else {
			CTRL(_button) ctrlSetText localize "STRD_Leave";
		};
	};
};

FUNC(squadmgmtlblostfocus) = {
	private ["_butidc", "_carray", "_ctrl", "_sel", "_disp", "_buctrl"];
	PARAMS_2(_butidc,_carray);
	_ctrl = _carray select 0;
	_sel = lbCurSel _ctrl;
	if (_sel != -1) then {
		_ctrl lbSetCurSel -1;
	};
	disableSerialization;
	_disp = __uiGetVar(X_SQUADMANAGEMENT_DIALOG);
	_butidc = _butidc + 1000;
	_buctrl = CTRL(_butidc);
	if (ctrlText _buctrl == localize "STRD_Remove") then {
		_buctrl ctrlSetText localize "STRD_Leave";
	};
};

