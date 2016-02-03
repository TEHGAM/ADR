/*
@filename: fn_vSetup02.sqf
Author:

	???

Last modified:

	22/10/2014 ArmA 1.32 by Quiksilver

Description:

	Apply code to vehicle
	vSetup02 deals with code that is already applied where it should be.
_______________________________________________*/

//============================================= CONFIG

private ["_u", "_t"];

_u = _this select 0;
_t = typeOf _u;

if (isNull _u) exitWith {};

//============================================= ARRAYS

_gh_huron = ["B_Heli_Transport_01_camo_F", "B_Heli_Transport_01_F", "B_Heli_Transport_03_F"]; 	// ghosthawk and huron
_huron = ["B_Heli_Transport_03_F"];																// huron
//_taru = ["O_Heli_Transport_04_F"];															// taru
//_taru_covered = ["O_Heli_Transport_04_covered_F"];											// taru covered
_strider = ["I_MRAP_03_F", "I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F"];								// strider
_mh9 = ["B_Heli_Light_01_F", "B_Heli_Light_01_armed_F"];										// MH-9
//_orca = ["O_Heli_Light_02_unarmed_F"];														// Orca
_uav = ["O_UAV_02_CAS_F", "O_UAV_02_F", "O_UGV_01_F", "O_UGV_01_rcws_F"];						// UAVs
_noAmmoCargo = ["B_APC_Tracked_01_CRV_F", "B_Truck_01_ammo_F"];									// Bobcat CRV
_hellcat = ["I_Heli_light_03_unarmed_F"];														// Hellcat
_mohawk = ["I_Heli_Transport_02_F"];															// Mohawk
_buzzard = ["I_Plane_Fighter_03_CAS_F", "I_Plane_Fighter_03_AA_F"];								// Buzzard
_bobcat = ["B_APC_Tracked_01_CRV_F"];															// Bobcat


//============================================= SORT
//===== strider nato skin
if (_t in _strider) then {
	//_u setObjectTextureGlobal [0, '\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'];
	//_u setObjectTextureGlobal [1, '\A3\data_f\vehicles\turret_co.paa'];
	_u setObjectTextureGlobal [0, 'media\textures\mrap_03_ext_coCSAT.paa'];
	_u setObjectTextureGlobal [1, 'media\textures\turret_opfor_co.paa'];
};

//===== mh-9 skin
if(_t in _mh9) then {
//	_u setObjectTextureGlobal [0, 'A3\air_f\Heli_Light_01\Data\skins\heli_light_01_ext_wasp_co.paa'];
	_u setObjectTextureGlobal [0, 'A3\Air_F\Heli_Light_01\Data\heli_light_01_ext_ion_co.paa'];
	_u addWeapon "CMFlareLauncher";
	_u addMagazine "168Rnd_CMFlare_Chaff_Magazine";
};

//==== huron skin
if(_t in _huron) then {
	_u setObjectTextureGlobal [0, 'A3\air_f_heli\Heli_Transport_03\Data\heli_transport_03_ext01_black_co.paa'];
	_u setObjectTextureGlobal [1, 'A3\air_f_heli\Heli_Transport_03\Data\heli_transport_03_ext02_black_co.paa'];
};

//==== hellcat skin
if(_t in _hellcat) then {
	_u setObjectTextureGlobal [0, 'media\textures\Heli_light_03_CSAT.paa'];//'A3\air_f_epb\Heli_Light_03\data\heli_light_03_base_indp_co.paa'];
};

//==== mohawk skin
if(_t in _mohawk) then {
	_u setObjectTextureGlobal [0, 'media\textures\Heli_Transport1_02_CSAT.paa'];
	_u setObjectTextureGlobal [1, 'media\textures\Heli_Transport2_02_CSAT.paa'];
	_u setObjectTextureGlobal [2, 'media\textures\Heli_Transport3_02_CSAT.paa'];
};

//==== buzzard skin
if(_t in _buzzard) then {
	_u setObjectTextureGlobal [0, 'media\textures\Plane_Fighter_03_1CSAT.paa'];
	_u setObjectTextureGlobal [1, 'media\textures\Plane_Fighter_03_2CSAT.paa'];
};

//==== bobcat skin
if(_t in _bobcat) then {
	_u setObjectTextureGlobal [0, 'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_body_opfor_co.paa'];
	_u setObjectTextureGlobal [1, 'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa'];
	_u setObjectTextureGlobal [2, 'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_aa_body_opfor_co.paa'];
	_u setObjectTextureGlobal [3, 'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa'];
};

////==== taru skins
//if(_t in _taru) then {
//	_u setObjectTextureGlobal [0, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_01_black_co.paa'];
//	_u setObjectTextureGlobal [1, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_02_black_co.paa'];
//};

//if(_t in _taru_covered) then {
//	_u setObjectTextureGlobal [0, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_01_black_co.paa'];
//	_u setObjectTextureGlobal [1, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_base_02_black_co.paa'];
//	_u setObjectTextureGlobal [2, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_pod_ext01_black_co.paa'];
//	_u setObjectTextureGlobal [3, 'A3\air_f_heli\Heli_Transport_04\Data\heli_transport_04_pod_ext02_black_co.paa'];
//};

//===== aaf skin
//if(_t in _orca) then {
//	_u setObjectTextureGlobal [0, 'A3\Air_F\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa'];
//};

//===== UAV respawn fixer
if (_t in _uav) then {
	{deleteVehicle _x;} count (crew _u);
	[_u] spawn {
		_u = _this select 0;
		sleep 2;
		createVehicleCrew _u;
	};
};

//===== Turret locking system
if (_t in _gh_huron) then {
	_u setVariable ["turrets_locked", false, true];
};