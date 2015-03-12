/*
@filename: fn_actionUAVSoftware.sqf
Author:

	Quiksilver
	
Last modified:

	23/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Re-load UAV software
___________________________________________*/

private ["_t"];

_t = cursorTarget;
_type = typeOf _t;

_uav = ["I_UAV_01_F","B_UAV_01_F","O_UAV_01_F","I_UAV_02_F","O_UAV_02_F","I_UAV_02_CAS_F","O_UAV_02_CAS_F","B_UAV_02_F","B_UAV_02_CAS_F","O_UAV_01_F","O_UGV_01_F","O_UGV_01_rcws_F","I_UGV_01_F","B_UGV_01_F","I_UGV_01_rcws_F","B_UGV_01_rcws_F","B_GMG_01_A_F","B_HMG_01_A_F","O_GMG_01_A_F","O_HMG_01_A_F","I_GMG_01_A_F","I_HMG_01_A_F"];

if (_type in _uav) then {
	hintSilent "Loading new software ... Please wait a moment ...";
	player addRating 2000;
	{deleteVehicle _x;} count (crew _t);
	[[player,"AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"],"QS_fnc_switchMoveMP",nil,false] spawn BIS_fnc_MP;
	[_t] spawn {
		_t = _this select 0;
		sleep 2;
		createVehicleCrew _t;
		broadcastCrew = crew _t; publicVariableServer "broadcastCrew";
		crewServer = crew _t; publicVariableServer "crewServer";
		sleep 1;
		[(crew _t)] call QS_fnc_setSkill4;
		hintSilent "New software loaded ... Stay safe, soldier!";
	};
};