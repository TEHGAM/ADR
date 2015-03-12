/*
Author: Quiksilver
Last modified: 23/10/2014 ArmA 1.32 by Quiksilver
Description:

	Restricts certain weapon systems to different roles
_________________________________________________*/

private ["_opticsAllowed","_specialisedOptics","_optics","_basePos","_firstRun","_insideSafezone","_outsideSafezone"];

#define AT_MSG "Only AT Soldiers may use this weapon system. Launcher removed."
#define SNIPER_MSG "Only Snipers may use this weapon system. Sniper rifle removed."
#define AUTOTUR_MSG "You are not allowed to use this weapon system, Backpack removed."
#define UAV_MSG "Only UAV operator may use this Item, UAV terminal removed."
#define OPTICS_MSG "Thermal optics such as TWS and Nightstalker are currently restricted."
#define MG_MSG "Only Autoriflemen may use this weapon system. LMG removed."
#define SOPT_MSG "SOS and LRPS are designated for Snipers and Spotters only. Optic removed."

//===== UAV TERMINAL
_uavOperator = ["B_soldier_UAV_F","B_officer_F"];
_uavRestricted = ["B_UavTerminal","O_UavTerminal","I_UavTerminal"];
//===== AT / MISSILE LAUNCHERS (excl RPG)
_missileSoldiers = ["B_soldier_LAT_F","B_soldier_AA_F","B_soldier_AT_F","B_officer_F","B_recon_LAT_F"];
_missileSpecialised = ["launch_NLAW_F","launch_B_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_short_F","launch_O_Titan_short_F","launch_I_Titan_short_F"];
//===== SNIPER RIFLES
_snipers = ["B_sniper_F","B_officer_F"];
_sniperSpecialised = ["srifle_GM6_F","srifle_GM6_LRPS_F","srifle_GM6_SOS_F","srifle_LRR_F","srifle_LRR_LRPS_F","srifle_LRR_SOS_F","srifle_GM6_camo_F","srifle_GM6_camo_LRPS_F","srifle_GM6_camo_SOS_F","srifle_LRR_camo_F","srifle_LRR_camo_LRPS_F","srifle_LRR_camo_SOS_F"];
//===== THERMAL OPTICS
_opticsAllowed = [""];
_specialisedOptics = ["optic_Nightstalker","optic_tws","optic_tws_mg"];
//===== BACKPACKS
_backpackRestricted = ["O_Mortar_01_support_F","I_Mortar_01_support_F","O_Mortar_01_weapon_F","I_Mortar_01_weapon_F","O_UAV_01_backpack_F","I_UAV_01_backpack_F","O_HMG_01_support_F","I_HMG_01_support_F","O_HMG_01_support_high_F","I_HMG_01_support_high_F","O_HMG_01_weapon_F","I_HMG_01_weapon_F","O_HMG_01_A_weapon_F","I_HMG_01_A_weapon_F","O_GMG_01_weapon_F","I_GMG_01_weapon_F","O_GMG_01_A_weapon_F","I_GMG_01_A_weapon_F","O_HMG_01_high_weapon_F","I_HMG_01_high_weapon_F","O_HMG_01_A_high_weapon_F","I_HMG_01_A_high_weapon_F","O_GMG_01_high_weapon_F","I_GMG_01_high_weapon_F","O_GMG_01_A_high_weapon_F","I_GMG_01_A_high_weapon_F","I_AT_01_weapon_F","O_AT_01_weapon_F","I_AA_01_weapon_F","O_AA_01_weapon_F"];
//===== LMG
_autoRiflemen = ["B_soldier_AR_F","B_officer_F"];
_autoSpecialised = ["LMG_Mk200_F","LMG_Mk200_MRCO_F","LMG_Mk200_pointer_F","LMG_Zafir_F","LMG_Zafir_pointer_F"];
//=====
_sniperTeam = ["B_sniper_F","B_spotter_F"];
_sniperOpt = ["optic_SOS","optic_LRPS"];

_basePos = getMarkerPos "respawn_west";

_szmkr = getMarkerPos "safezone_marker";
#define SZ_RADIUS 300

_EHFIRED = {
	deleteVehicle (_this select 6);
	hintC "You are discharging your weapon at base without approval.  Cease your actions Immediately!";
    hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
        0 = _this spawn {
            _this select 0 displayRemoveEventHandler ["unload", hintC_EH];
            hintSilent "";
        };
    }];
};

_firstRun = TRUE;
if (_firstRun) then {
	_firstRun = FALSE;
	if ((player distance _szmkr) <= SZ_RADIUS) then {
		_insideSafezone = TRUE;
		_outsideSafezone = FALSE;
		EHFIRED = player addEventHandler ["Fired",_EHFIRED];
	} else {
		_outsideSafezone = TRUE;
		_insideSafezone = FALSE;
	};
};

restrict_Thermal = false;
restrict_LMG = false;
restrict_sOptics = false;
if (PARAMS_rThermal != 0) then {restrict_Thermal = true;};
if (PARAMS_rLMG != 0) then {restrict_LMG = true;};
if (PARAMS_rSOptics != 0) then {restrict_sOptics = true;};

while {true} do {

	//------------------------------------- Launchers

	if (({player hasWeapon _x} count _missileSpecialised) > 0) then {
		if (({player isKindOf _x} count _missileSoldiers) < 1) then {
			player removeWeapon (secondaryWeapon player);
			titleText [AT_MSG,"PLAIN",3];
		};
	};
	
	sleep 1;
	//------------------------------------- Sniper Rifles

	if (({player hasWeapon _x} count _sniperSpecialised) > 0) then {
		if (({player isKindOf _x} count _snipers) < 1) then {
			player removeWeapon (primaryWeapon player);
			titleText [SNIPER_MSG,"PLAIN",3];
		};
	};

	sleep 1;
	//------------------------------------- UAV

    _assignedItems = assignedItems player;

	if (({"B_UavTerminal" == _x} count _assignedItems) > 0) then {
		if (({player isKindOf _x} count _uavOperator) < 1) then {
			player unassignItem "B_UavTerminal";
			player removeItem "B_UavTerminal";
			titleText [UAV_MSG,"PLAIN",3];
		};
	};
	
	sleep 1;
	//------------------------------------- Thermal optics

	if (restrict_Thermal) then {
		_optics = primaryWeaponItems player;	
		if (({_x in _optics} count _specialisedOptics) > 0) then {
			if (({player isKindOf _x} count _opticsAllowed) < 1) then {
				{player removePrimaryWeaponItem  _x;} count _specialisedOptics;
				titleText [OPTICS_MSG,"PLAIN",3];
			};
		};
		sleep 1;
	};
	
	//------------------------------------- sniper optics

	if (restrict_sOptics) then {
		_optics = primaryWeaponItems player;	
		if (({_x in _optics} count _sniperOpt) > 0) then {
			if (({player isKindOf _x} count _sniperTeam) < 1) then {
				{player removePrimaryWeaponItem  _x;} count _sniperOpt;
				titleText [SOPT_MSG,"PLAIN",3];
			};
		};
		sleep 1;
	};

	//------------------------------------- LMG
		
	if (restrict_LMG) then {
		if (({player hasWeapon _x} count _autoSpecialised) > 0) then {
			if (({player isKindOf _x} count _autoRiflemen) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [MG_MSG,"PLAIN",3];
			};
		};
		sleep 1;
	};
	
	//------------------------------------- Opfor turret backpacks

	if ((backpack player) in _backpackRestricted) then {
		removeBackpack player;
		titleText [AUTOTUR_MSG, "PLAIN", 3];
	};
	
	//===================================== SAFE ZONE MANAGER
	
	_szmkr = getMarkerPos "safezone_marker";
	if (_insideSafezone) then {
		if ((player distance _szmkr) > SZ_RADIUS) then {
			_insideSafezone = FALSE;
			_outsideSafezone = TRUE;
			player removeEventHandler ["Fired",EHFIRED];
		};
	};
	sleep 2;
	if (_outsideSafezone) then {
		if ((player distance _szmkr) < SZ_RADIUS) then { 
			_outsideSafezone = FALSE;
			_insideSafezone = TRUE;
			EHFIRED = player addEventHandler ["Fired",_EHFIRED];
		};
	};
	
	//----- Sleep 
	
	_basePos = getMarkerPos "respawn_west";
	if ((player distance _basePos) <= 500) then {
		sleep 1;
	} else {
		sleep 20;
	};
};