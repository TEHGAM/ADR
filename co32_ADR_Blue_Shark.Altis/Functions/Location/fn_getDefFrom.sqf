/*
 * Author: BACONMOP
 * [Get locations for Attack from]
 *
 * Arguments:
 * 0: current AO
 *
 * Return Value:
 * STRING
 *
 * Example [_currentAO] call AW_fnc_getDefAO;
 *
 * Public: NO
 */

_AO_Entry = _this select 0;
_controlled = true;
 
_attackLocations = (missionconfigfile >> "Main_Aos" >> "AOs" >> _AO_Entry >> "nearLocations") call BIS_fnc_getCfgData;
_nextAttackFrom = _attackLocations call BIS_fnc_selectRandom;

if !(_nextAttackFrom == CurrentAO) then {
	while {_controlled} do {
		_attackLocations = _attackLocations - [_nextAttackFrom];
		_nextAttackFrom = _attackLocations call BIS_fnc_selectRandom;
		if !(_nextAttackFrom  == CurrentAO) then {
			_controlled = false;
		};
	};
};

_nextAttackFrom