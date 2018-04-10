/*
 * Author: BACONMOP
 * [Get locations for defend AO]
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
 
_near_locations = (missionconfigfile >> "Main_Aos" >> "AOs" >> _AO_Entry >> "nearLocations") call BIS_fnc_getCfgData;
_nextAO = _near_locations call BIS_fnc_selectRandom;

if !(_nextAO in controlledZones) then {
	while {_controlled} do {
		_near_locations = _near_locations - [_nextAO];
		_nextAO = _near_locations call BIS_fnc_selectRandom;
		if (_nextAO in controlledZones) then {
			_controlled = false;
		} else {
		_zonesLeft = count _near_locations;
			if (_zonesLeft <= 0) then {
				_AO_Entry = controlledZones call BIS_fnc_selectRandom;
				_near_locations = (missionconfigfile >> "Main_Aos" >> "AOs" >> _AO_Entry >> "nearLocations") call BIS_fnc_getCfgData;
				_nextAO = _near_locations call BIS_fnc_selectRandom;
			};
		};
	};
};

_nextAO