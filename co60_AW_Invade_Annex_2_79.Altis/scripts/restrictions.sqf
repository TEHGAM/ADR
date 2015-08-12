private ["_opticsAllowed","_specialisedOptics","_optics","_basePos","_firstRun","_insideSafezone","_outsideSafezone"];

#define AT_MSG "Только Стрелок[ПТ] может использовать это оружие."
#define SNIPER_MSG "Только снайперы могут использовать это оружие."
#define AUTOTUR_MSG "Данное вооружение запрещено."
#define UAV_MSG "Только операторы БПЛА могут использовать терминал управления."
#define OPTICS_MSG "Тепловизионный прицел могут использовать только командиры."
#define MG_MSG "Только пулеметчики могут использовать тяжелые пулеметы."
#define SOPT_MSG "Прицелы SOS и LRPS предназначены только для снайперов."
#define MRK_MSG "Только меткие стрелки и разведчики-снайпера могут использовать данное оружие."
#define GHILLIE_MSG "Только снайперы могут носить масхалаты."

//===== Терминал БПЛА
_uavOperator = ["B_soldier_UAV_F"];
//===== AT / MISSILE LAUNCHERS (excl RPG)
_missileSoldiers = ["B_soldier_AT_F","B_soldier_AA_F"];
_missileSpecialised = ["launch_NLAW_F","launch_B_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_short_F","launch_O_Titan_short_F","launch_I_Titan_short_F"];
//===== SNIPER RIFLES
_snipers = ["B_sniper_F","B_officer_F"];
_sniperSpecialised = ["srifle_GM6_F","srifle_GM6_LRPS_F","srifle_GM6_SOS_F","srifle_LRR_F","srifle_LRR_LRPS_F","srifle_LRR_SOS_F","srifle_GM6_camo_F","srifle_GM6_camo_LRPS_F","srifle_GM6_camo_SOS_F","srifle_LRR_camo_F","srifle_LRR_camo_LRPS_F","srifle_LRR_camo_SOS_F"];
//===== THERMAL OPTICS
_opticsAllowed = ["B_Soldier_SL_F","B_recon_TL_F"];
_specialisedOptics = ["optic_Nightstalker","optic_tws","optic_tws_mg"];
//===== BACKPACKS
_backpackRestricted = ["O_Mortar_01_support_F","I_Mortar_01_support_F","O_Mortar_01_weapon_F","I_Mortar_01_weapon_F","O_UAV_01_backpack_F","I_UAV_01_backpack_F","O_HMG_01_support_F","I_HMG_01_support_F","O_HMG_01_support_high_F","I_HMG_01_support_high_F","O_HMG_01_weapon_F","I_HMG_01_weapon_F","O_HMG_01_A_weapon_F","I_HMG_01_A_weapon_F","O_GMG_01_weapon_F","I_GMG_01_weapon_F","O_GMG_01_A_weapon_F","I_GMG_01_A_weapon_F","O_HMG_01_high_weapon_F","I_HMG_01_high_weapon_F","O_HMG_01_A_high_weapon_F","I_HMG_01_A_high_weapon_F","O_GMG_01_high_weapon_F","I_GMG_01_high_weapon_F","O_GMG_01_A_high_weapon_F","I_GMG_01_A_high_weapon_F","I_AT_01_weapon_F","O_AT_01_weapon_F","I_AA_01_weapon_F","O_AA_01_weapon_F","B_Respawn_TentDome_F","B_Respawn_TentA_F","B_Respawn_Sleeping_bag_F","B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F"];
//===== LMG
_autoRiflemen = ["B_soldier_AR_F","B_officer_F"];
_autoSpecialised = ["MMG_02_black_F","MMG_02_camo_F","MMG_02_sand_F","MMG_02_black_RCO_BI_F","MMG_02_sand_RCO_LP_F","MMG_01_base_F","MMG_01_hex_F","MMG_01_hex_ARCO_LP_F","MMG_01_tan_F","LMG_Zafir_F","LMG_Zafir_pointer_F","LMG_Zafir_ARCO_F"];
//===== SNIPER OPTICS
_sniperTeam = ["B_sniper_F","B_recon_M_F"];
_sniperOpt = ["optic_SOS","optic_LRPS"];
//===== SNIPER GHILLIE
_sniperGhillie = ["U_B_GhillieSuit","U_O_GhillieSuit","U_I_GhillieSuit","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard"];
//===== MARKSMAN
_marksman = ["B_Sharpshooter_F","B_recon_M_F"];
_marksmanGun = ["srifle_DMR_01_ARCO_F","srifle_DMR_01_DMS_snds_F","srifle_DMR_01_DMS_F","srifle_DMR_01_SOS_F","srifle_DMR_01_MRCO_F","srifle_DMR_01_ACO_F","srifle_EBR_DMS_pointer_snds_F","srifle_EBR_Hamr_pointer_F","srifle_EBR_DMS_F","srifle_EBR_ARCO_pointer_snds_F","srifle_EBR_SOS_F","srifle_EBR_ARCO_pointer_F","srifle_EBR_MRCO_pointer_F","srifle_EBR_ACO_F","srifle_EBR_F","srifle_DMR_02_ACO_F","srifle_DMR_02_ARCO_F","srifle_DMR_02_camo_AMS_LP_F","srifle_DMR_02_DMS_F","srifle_DMR_02_MRCO_F","srifle_DMR_02_sniper_AMS_LP_S_F","srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F","srifle_DMR_02_SOS_F","srifle_DMR_03_ACO_F","srifle_DMR_03_AMS_F","srifle_DMR_03_ARCO_F","srifle_DMR_03_DMS_F","srifle_DMR_03_DMS_snds_F","srifle_DMR_03_MRCO_F","srifle_DMR_03_SOS_F","srifle_DMR_03_tan_AMS_LP_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_multicam_F","srifle_DMR_03_tan_F",
"srifle_DMR_03_woodland_F","srifle_DMR_04_ACO_F","srifle_DMR_04_ARCO_F","srifle_DMR_04_DMS_F","srifle_DMR_05_ACO_F","srifle_DMR_05_ARCO_F","srifle_DMR_05_DMS_F","srifle_DMR_05_DMS_snds_F","srifle_DMR_05_KHS_LP_F","srifle_DMR_05_MRCO_F","srifle_DMR_05_SOS_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F","srifle_DMR_06_camo_khs_F","srifle_DMR_06_olive_F"];

_basePos = getMarkerPos "respawn_west";

_szmkr = getMarkerPos "safezone_marker";
#define SZ_RADIUS 300

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

restrict_Thermal = true;
restrict_LMG = true;
restrict_sOptics = false;
restrict_Marksman = false;

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

	//------------------------------------- sniper ghillies
	
		if ((item player) in _sniperGhillie) then {
		{player removeItem  _x;} count _sniperGhillie;
		titleText [GHILLIE_MSG, "PLAIN", 3];
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
	
	//------------------------------------- Marksman
		
	if (restrict_Marksman) then {
		if (({player hasWeapon _x} count _marksmanGun) > 0) then {
			if (({player isKindOf _x} count _marksman) < 1) then {
				player removeWeapon (primaryWeapon player);
				titleText [MRK_MSG,"PLAIN",3];
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