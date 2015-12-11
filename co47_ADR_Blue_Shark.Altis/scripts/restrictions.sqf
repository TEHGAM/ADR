/*
Author: Quiksilver
Last modified: 23/10/2014 ArmA 1.32 by Quiksilver
Description:

	Restricts certain weapon systems to different roles
_________________________________________________*/

private ["_opticsAllowed","_specialisedOptics","_basePos","_firstRun","_insideSafezone","_outsideSafezone"];

#define AT_MSG "Только гранатометчики могут использовать это оружие."
#define SNIPER_MSG "Только снайперы могут использовать это оружие."
#define AUTOTUR_MSG "Данное вооружение запрещено."
#define UAV_MSG "Только операторы БПЛА могут использовать терминал управления."
#define MG_MSG "Только пулеметчики могут использовать пулеметы."
#define MRK_MSG "Только пехотные снайперы могут использовать это оружие."
#define PILOT_MSG "Пилоты могут использовать только пистолеты и пистолет-пулемёты."
#define GRENADIER_MSG "Только гренадеры и командиры отделений могут использовать подствольные гранатометы."
//#define SOPT_MSG "Только снайперы могут использовать оптический прицел LRPS."
#define MARKSMANOPT_MSG "Только снайперы и пехотные снайперы могут использовать оптические прицелы LRPS, SOS, AMS, KAHLIA."

//===== UAV TERMINAL
_uavOperator = ["B_soldier_UAV_F"];
_uavRestricted = ["B_UavTerminal","O_UavTerminal","I_UavTerminal"];
//===== AT / MISSILE LAUNCHERS (excl RPG)
_missileSoldiers = ["B_soldier_AT_F"];
_missileSpecialised = ["launch_RPG32_F","launch_NLAW_F","launch_B_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_short_F","launch_O_Titan_short_F","launch_I_Titan_short_F"];
//===== SNIPER RIFLES
_snipers = ["B_sniper_F"];
_sniperSpecialised = ["srifle_GM6_F","srifle_GM6_camo_F","srifle_LRR_F","srifle_LRR_camo_F"];
//===== BACKPACKS
_backpackRestricted = ["O_Mortar_01_support_F","I_Mortar_01_support_F","O_Mortar_01_weapon_F","I_Mortar_01_weapon_F","O_UAV_01_backpack_F","I_UAV_01_backpack_F","O_HMG_01_support_F","I_HMG_01_support_F","O_HMG_01_support_high_F","I_HMG_01_support_high_F","O_HMG_01_weapon_F","I_HMG_01_weapon_F","O_HMG_01_A_weapon_F","I_HMG_01_A_weapon_F","O_GMG_01_weapon_F","I_GMG_01_weapon_F","O_GMG_01_A_weapon_F","I_GMG_01_A_weapon_F","O_HMG_01_high_weapon_F","I_HMG_01_high_weapon_F","O_HMG_01_A_high_weapon_F","I_HMG_01_A_high_weapon_F","O_GMG_01_high_weapon_F","I_GMG_01_high_weapon_F","O_GMG_01_A_high_weapon_F","I_GMG_01_A_high_weapon_F","I_AT_01_weapon_F","O_AT_01_weapon_F","I_AA_01_weapon_F","O_AA_01_weapon_F","B_Respawn_TentDome_F","B_Respawn_TentA_F","B_Respawn_Sleeping_bag_F","B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F"];
//===== LMG
_autoRiflemen = ["B_Soldier_AR_F"];
_autoSpecialised = ["LMG_Mk200_F","LMG_Zafir_F","MMG_01_hex_F","MMG_01_tan_F","MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F"];
//===== MARKSMAN
_marksman = ["B_soldier_M_F"];
_marksmanGun = ["srifle_DMR_01_F","srifle_EBR_F","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F"];
//==== PILOTS
_pilot = ["B_soldier_repair_F"];
_pilotWeapons = ["hgun_PDW2000_F","SMG_01_F","SMG_02_F"];
//=== GRENADIERS
_grenadier = ["B_Soldier_GL_F","B_Soldier_SL_F"];
_grenadierWeapons = ["arifle_Katiba_GL_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_MX_GL_F","arifle_MX_GL_Black_F","arifle_TRG21_GL_F"];

//===== THERMAL
_ThermalTeam = ["b_g_survivor_F"];
_ThermalOpt = ["optic_Nightstalker","optic_tws","optic_tws_mg"];

//===== MARKSMAN OPTICS
_marksmanOpticsGrp = ["B_sniper_F","B_soldier_M_F"];
_marksmanOpticsItems = ["optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_SOS","optic_LRPS"];


_basePos = getMarkerPos "respawn_west";

_szmkr = getMarkerPos "safezone_marker";
#define SZ_RADIUS 400

_EHFIRED = {
	deleteVehicle (_this select 6);
	hintC "Использование оружия на базе запрещено! В целях безопасности.";
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

while {true} do {
	//------------------------------------- Pilots
	if (({player isKindOf _x} count _pilot) > 0) then {
		if (!(primaryWeapon player in _pilotWeapons) and (primaryWeapon player != "")) then {
			player removeWeapon (primaryWeapon player);
			titleText [PILOT_MSG,"PLAIN",2];
		};
		sleep 0.1;

	} else {

		//------------------------------------- Grenadiers
		if (({player hasWeapon _x} count _grenadierWeapons) > 0) then {
			if (({player isKindOf _x} count _grenadier) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [GRENADIER_MSG,"PLAIN",2];
			};
		};
		sleep 0.1;

		//------------------------------------- Sniper Rifles
		if (({player hasWeapon _x} count _sniperSpecialised) > 0) then {
			if (({player isKindOf _x} count _snipers) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [SNIPER_MSG,"PLAIN",2];
			};
		};
		sleep 0.1;

		//------------------------------------- LMG
		if (({player hasWeapon _x} count _autoSpecialised) > 0) then {
			if (({player isKindOf _x} count _autoRiflemen) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [MG_MSG,"PLAIN",2];
			};
		};
		sleep 0.1;

		//------------------------------------- Marksman
		if (({player hasWeapon _x} count _marksmanGun) > 0) then {
			if (({player isKindOf _x} count _marksman) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [MRK_MSG,"PLAIN",2];
			};
		};
		sleep 0.1;
	};

	//------------------------------------- Launchers
	if (({player hasWeapon _x} count _missileSpecialised) > 0) then {
		if (({player isKindOf _x} count _missileSoldiers) < 1) then {
			player removeWeapon (secondaryWeapon player);
			titleText [AT_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

	//------------------------------------- Thermal optics
	_optics = primaryWeaponItems player;	
	if (({_x in _optics} count _TermalOpt) > 0) then {
		if (({player isKindOf _x} count _ThermalTeam) < 1) then {
			{player removePrimaryWeaponItem  _x;} count _ThermalOpt;
			titleText [AUTOTUR_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

	//------------------------------------- Marksman optics
	_optics = primaryWeaponItems player;	
	if (({_x in _optics} count _marksmanOpticsItems) > 0) then {
		if (({player isKindOf _x} count _marksmanOpticsGrp) < 1) then {
			{player removePrimaryWeaponItem  _x;} count _marksmanOpticsItems;
			titleText [MARKSMANOPT_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

	//------------------------------------- Ennemy turret backpacks
	if ((backpack player) in _backpackRestricted) then {
		removeBackpack player;
		titleText [AUTOTUR_MSG, "PLAIN", 2];
	};
	sleep 0.1;

	//------------------------------------- UAV
	_assignedItems = assignedItems player;
	if (({"B_UavTerminal" == _x} count _assignedItems) > 0) then {
		if (({player isKindOf _x} count _uavOperator) < 1) then {
			player unassignItem "B_UavTerminal";
			player removeItem "B_UavTerminal";
			titleText [UAV_MSG,"PLAIN",2];
		};
	};
	sleep 0.1;

	//===================================== SAFE ZONE MANAGER
	_szmkr = getMarkerPos "safezone_marker";
	if (_insideSafezone) then {
		if ((player distance _szmkr) > SZ_RADIUS) then {
			_insideSafezone = FALSE;
			_outsideSafezone = TRUE;
			player removeEventHandler ["Fired",EHFIRED];
		};
	};

	sleep 1;

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
		sleep 2;
	} else {
		sleep 20;
	};
};