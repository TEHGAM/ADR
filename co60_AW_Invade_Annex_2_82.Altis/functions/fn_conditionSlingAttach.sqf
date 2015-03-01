/*
@filename: fn_conditionSlingAttach.sqf
Author: 

	Quiksilver
	
Last modified:

	9/08/2014 ArmA 1.24 by Quiksilver
	
Description:

	Condition for add-Action
	
__________________________________________________________________*/

private ["_v","_cond"];

_v = vehicle player;
_cond = false;

if (_v getVariable 'sling_veh') then {
	if (format ["%1",_v getVariable 'sling_attached'] != "true") then {
		if (count (getPos _v nearEntities [["LandVehicle","Ship"],15]) > 0) then {
			_cond = true;
		};
	};
};

_cond;