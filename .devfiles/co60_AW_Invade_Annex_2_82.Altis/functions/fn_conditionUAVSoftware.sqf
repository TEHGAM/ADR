/*
@filename: fn_conditionUAVSoftware.sqf
Author:
	
	Quiksilver
	
Last modified:

	23/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	condition for loading UAV crew
______________________________________________*/

private ["_c","_t","_type"];

_c = FALSE;
_t = cursorTarget;

if ((player distance _t) < 3) then {
	_type = typeOf _t;
	_uav = ["I_UAV_01_F","B_UAV_01_F","O_UAV_01_F","I_UAV_02_F","O_UAV_02_F","I_UAV_02_CAS_F","O_UAV_02_CAS_F","B_UAV_02_F","B_UAV_02_CAS_F","O_UAV_01_F","O_UGV_01_F","O_UGV_01_rcws_F","I_UGV_01_F","B_UGV_01_F","I_UGV_01_rcws_F","B_UGV_01_rcws_F","B_GMG_01_A_F","B_HMG_01_A_F","O_GMG_01_A_F","O_HMG_01_A_F","I_GMG_01_A_F","I_HMG_01_A_F"];
	if (_type in _uav) then {
		_c = TRUE;
	};
};
_c;
