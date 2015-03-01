/*
@filename: fn_conditionMobileArmory.sqf
Author: 

	Quiksilver
	
Last modified:

	23/07/2014
	
Description:

	Conditional use of Virtual Arsenal, when near a designated Mobile-Arsenal vehicle
	
_____________________________________________________________________________*/

private ["_c","_v","_t"];
_t = cursorTarget;
_c = FALSE;
if ((vehicle player) isKindOf "Man") then {
	if ((player distance _t) < 10) then {
		if (_t getVariable "mobile_armory") then {
			if (damage _t < 0.9) then {
				_c = TRUE;
			};
		};
	};
};
_c;