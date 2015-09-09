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

private ["_u","_t"];

_u = _this select 0;
_t = typeOf _u;

if (isNull _u) exitWith {};

//============================================= ARRAYS

_gh_huron = ["B_Heli_Transport_01_camo_F", "B_Heli_Transport_01_F", "B_Heli_Transport_03_F"]; 			// ghosthawk and huron
_m900 = ["C_Heli_Light_01_civil_F"];											// M900
_strider = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];					// strider
_wasp = ["B_Heli_Light_01_F","B_Heli_Light_01_armed_F"];						// MH-9
_orca = ["O_Heli_Light_02_unarmed_F"];											// Orca
_uav = ["B_UAV_02_CAS_F", "B_UAV_02_F", "B_UGV_01_F", "B_UGV_01_rcws_F"];			// UAVs
_noAmmoCargo = ["B_APC_Tracked_01_CRV_F", "B_Truck_01_ammo_F"];					// Bobcat CRV

//============================================= SORT
//===== strider nato skin

if (_t in _strider) then {
	_u setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'];
	_u setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa']; 
};

//===== bee skin

if(_t in _wasp) then {
	_u setObjectTextureGlobal [0,'A3\air_f\Heli_Light_01\Data\skins\heli_light_01_ext_wasp_co.paa']; 
	_u addWeapon "CMFlareLauncher"; 
	_u addMagazine "168Rnd_CMFlare_Chaff_Magazine";
};

//===== m900

if(_t in _m900) then {
	_u setObjectTextureGlobal [0,'A3\Air_F\Heli_Light_01\Data\Skins\heli_light_01_ext_vrana_co.paa'];
	_u addWeapon "CMFlareLauncher"; 
	_u addMagazine "168Rnd_CMFlare_Chaff_Magazine";
};

//===== aaf skin

if(_t in _orca) then {
	_u setObjectTextureGlobal [0,'A3\Air_F\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa'];
};

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