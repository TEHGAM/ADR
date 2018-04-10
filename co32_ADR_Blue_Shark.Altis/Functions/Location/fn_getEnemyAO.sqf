/*
Author: BACONMOP
For enemy controlled AO's
tweaked copy from getAO
*/
_controlled = true;
 
_near_locations = (missionconfigfile >> "Main_Aos" >> "AOs") call BIS_fnc_getCfgData;
_nextAO = _near_locations call BIS_fnc_selectRandom;

if (_nextAO in controlledZones) then {
	while {_controlled} do {
		_near_locations = _near_locations - [_nextAO];
		_nextAO = _near_locations call BIS_fnc_selectRandom;
		if !(_nextAO in controlledZones) then {
			_controlled = false;
		};
	};
};

_nextAO