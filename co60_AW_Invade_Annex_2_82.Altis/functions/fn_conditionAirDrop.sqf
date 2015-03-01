/*
@filename: fn_conditionAirDrop.sqf
Author: 

	Quiksilver
	
Last modified:

	28/07/2014 ArmA 1.24 by Quiksilver
	
Description:

	Conditional use of heli supply drop
_____________________________________________________________________________*/

private ["_veh","_cond"];

#define MIN_HEIGHT 40
_veh = vehicle player;
_cond = false;

if ((_veh isKindOf "B_Heli_Transport_01_F") || {(_veh isKindOf "B_Heli_Transport_01_camo_F")}) then {
	if (_veh getVariable "airdrop_veh") then {
		if ((position _veh) select 2 >= MIN_HEIGHT) then {
			if (AW_ammoDropAvail) then {
				_cond = true;
			};
		};
	};
};

_cond;