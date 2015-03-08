﻿// by Xeno
#define THIS_FILE "x_netinit.sqf"
#include "x_setup.sqf"

GVAR(with_ai) = false;
GVAR(HeliHEmpty) = "Land_HelipadEmpty_F";
GVAR(event_holderSTO) = GVAR(HeliHEmpty) createVehicleLocal [0, 0, 0];
if (!isDedicated) then {
	GVAR(event_holderToClients) = GVAR(HeliHEmpty) createVehicleLocal [0, 0, 0];
};

FUNC(NetAddEventSTO) = {
	__TRACE_1("NetAddEventSTO","_this")
	private ["_ea"];
	_ea = GVAR(event_holderSTO) getVariable (_this select 0);
	if (isNil "_ea") then {_ea = []};
	_ea set [count _ea, _this select 1];
	GVAR(event_holderSTO) setVariable [_this select 0, _ea];
};

FUNC(NetRunEventSTO) = {
	__TRACE_1("NetRunEventSTO","_this")
	private ["_ea", "_p", "_pa", "_obj", "_tt", "_islocal", "_isgrp"];
	_tt = _this select 1;
	_obj = if (typeName _tt == "ARRAY") then {_tt select 0} else {_tt};
	if (isNil "_obj" || {isNull _obj}) exitWith {};
	_islocal = if (typeName _obj != "GROUP") then {
		_isgrp = false;
		local _obj
	} else {
		_isgrp = true;
		local (leader _obj)
	};
	__TRACE_1("NetRunEventSTO","_islocal")
	if (_islocal) then {
		_ea = GVAR(event_holderSTO) getVariable (_this select 0);
		if (!isNil "_ea") then {
			__TRACE_1("NetRunEventSTO found event","_ea")
			_pa = _this select 1;
			if (!isNil "_pa") then {
				{_pa call _x} forEach _ea;
			} else {
				{call _x} forEach _ea;
			};
		};
	} else {
		__TRACE_1("NetRunEventSTO _obj not local","_obj")
		GVAR(nsto) = _this;
		if (isServer) then {
			_owner = if (!_isgrp) then {
				owner _obj
			} else {
				owner (leader _obj)
			};
			__TRACE_1("NetRunEventSTO owner _obj","_obj")
			_owner publicVariableClient QGVAR(nsto);
		} else { // not needed... redundant, who cares
			__TRACE_1("NetRunEventSTO not server send","_obj")
			publicVariableServer QGVAR(nsto);
		};
	};
};

// checks if object is local first otherwise tries to send to the owner client making use of publicVariableServer and publicVariableClient (on the server)
// ["eventname", [object, var or vararray]] call FUNC(NetCallEventSTO)
// ["eventname", object] call FUNC(NetCallEventSTO)
FUNC(NetCallEventSTO) = {
	__TRACE_1("NetCallEventSTO","_this")
	private ["_tt", "_obj", "_isLocal"];
	_tt = _this select 1;
	_obj = if (typeName _tt == "ARRAY") then {_tt select 0} else {_tt};
	if (isNil "_obj" || {isNull _obj}) exitWith {};
	_islocal = if (typeName _obj != "GROUP") then {
		local _obj
	} else {
		local (leader _obj)
	};
	__TRACE_1("NetCallEventSTO","_islocal")
	if (!_isLocal) then {
		GVAR(nsto) = _this;
		publicVariableServer QGVAR(nsto);
	} else {
		_this call FUNC(NetRunEventSTO);
	};
};

QGVAR(nsto) addPublicVariableEventHandler {
	(_this select 1) call FUNC(NetRunEventSTO);
};

[QGVAR(grpjoin), {[_this select 1] joinSilent (_this select 0);}] call FUNC(NetAddEventSTO);
[QGVAR(grpslead), {(_this select 1) selectLeader (_this select 2)}] call FUNC(NetAddEventSTO);

/*
if (!isDedicated) then {
	[QGVAR(grpswmsg), {player globalChat ((_this select 1) + " " + "вышел из вашей группы")}] call FUNC(NetAddEventSTO);
	[QGVAR(grpswmsgn), {player globalChat ((_this select 1) + " " + "присоединился к вашей группе")}] call FUNC(NetAddEventSTO);
};
*/
