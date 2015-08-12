//Allow player to respawn with his loadout? If true unit will respawn with all ammo from initial save! Set to false to disable this and rely on other scripts!
vas_onRespawn = true;
//Preload Weapon Config?
vas_preload = true;
//If limiting weapons its probably best to set this to true so people aren't loading custom loadouts with restricted gear.
vas_disableLoadSave = false;
//Amount of save/load slots
vas_customslots = 19; //14 is actually 15 slots, starts from 0 to whatever you set, so always remember when setting a number to minus by 1, i.e 12 will be 11.
//Disable 'VAS hasn't finished loading' Check !!! ONLY RECOMMENDED FOR THOSE THAT USE ACRE AND OTHER LARGE ADDONS !!!
vas_disableSafetyCheck = false;

vas_weapons = [];
vas_magazines = [];
vas_items = [];
vas_backpacks = [];
vas_glasses = [];
vas_r_weapons = ["LMG_Zafir_F","MMG_02_black_F","MMG_02_camo_F","MMG_02_sand_F","MMG_01_hex_F","MMG_01_tan_F","srifle_GM6_F","srifle_LRR_F","launch_B_Titan_F","launch_I_Titan_F","launch_O_Titan_F","launch_B_Titan_short_F","launch_I_Titan_short_F","launch_O_Titan_short_F","launch_NLAW_F"];
vas_r_backpacks = ["O_Mortar_01_support_F","I_Mortar_01_support_F","O_Mortar_01_weapon_F","I_Mortar_01_weapon_F","O_UAV_01_backpack_F","I_UAV_01_backpack_F","O_HMG_01_support_F","I_HMG_01_support_F","O_HMG_01_support_high_F","I_HMG_01_support_high_F","O_HMG_01_weapon_F","I_HMG_01_weapon_F","B_HMG_01_A_weapon_F","O_HMG_01_A_weapon_F","I_HMG_01_A_weapon_F","O_GMG_01_weapon_F","I_GMG_01_weapon_F","B_GMG_01_A_weapon_F","O_GMG_01_A_weapon_F","I_GMG_01_A_weapon_F","O_HMG_01_high_weapon_F","I_HMG_01_high_weapon_F","B_HMG_01_A_high_weapon_F","O_HMG_01_A_high_weapon_F","I_HMG_01_A_high_weapon_F","O_GMG_01_high_weapon_F","I_GMG_01_high_weapon_F","B_GMG_01_A_high_weapon_F","O_GMG_01_A_high_weapon_F","I_GMG_01_A_high_weapon_F","I_AT_01_weapon_F","O_AT_01_weapon_F","I_AA_01_weapon_F","O_AA_01_weapon_F","B_Respawn_TentDome_F","B_Respawn_TentA_F","B_Respawn_Sleeping_bag_F","B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F","O_Static_Designator_02_weapon_F"];
vas_r_magazines = ["5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag","7Rnd_408_Mag","150Rnd_762x54_Box","150Rnd_762x54_Box_Tracer","130Rnd_338_Mag","150Rnd_93x64_Mag","NLAW_F","Titan_AA","Titan_AT","Titan_AP"];
vas_r_items = ["optic_SOS","optic_Nightstalker","optic_tws","optic_tws_mg","optic_LRPS","Laserdesignator_03","Laserdesignator_02"];
vas_r_glasses = [];

if (typeof player == "B_sniper_F") then {
vas_weapons = ["srifle_GM6_F","srifle_LRR_F","hgun_ACPC2_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F","hgun_Pistol_Signal_F"];
vas_magazines = ["5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag","7Rnd_408_Mag","9Rnd_45ACP_Mag","16Rnd_9x21_Mag","30Rnd_9x21_Mag","11Rnd_45ACP_Mag","6Rnd_45ACP_Cylinder","6Rnd_GreenSignal_F","6Rnd_RedSignal_F","HandGrenade","MiniGrenade","HandGrenade_Stone","SmokeShell","SmokeShellRed","SmokeShellGreen","SmokeShellYellow","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","B_IR_Grenade","APERSMine_Range_Mag","APERSTripMine_Wire_Mag","ClaymoreDirectionalMine_Remote_Mag"];
vas_items = ["U_B_GhillieSuit","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","V_BandollierB_khk","V_BandollierB_cbr","V_BandollierB_rgr","V_BandollierB_blk","V_BandollierB_oli","V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_rgr","V_PlateCarrier1_blk","V_PlateCarrierSpec_rgr","V_Chestrig_khk","V_Chestrig_rgr","V_Chestrig_blk","V_Chestrig_oli","V_TacVest_khk","V_TacVest_brn","V_TacVest_oli","V_TacVest_blk","V_TacVest_camo","V_TacVestIR_blk","V_TacVestCamo_khk","V_PlateCarrier_Kerry","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_I_G_resistanceLeader_F","ItemWatch","optic_SOS","optic_Nightstalker","optic_tws","optic_tws_mg","optic_LRPS","muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG","muzzle_snds_H_SW","optic_MRD","optic_Yorris"];
vas_backpacks = ["B_AssaultPack_mcamo","B_TacticalPack_mcamo","B_Kitbag_mcamo","B_Carryall_oli","B_FieldPack_oli","B_Parachute"];
vas_glasses = [];
vas_r_weapons = [];
vas_r_backpacks = [];
vas_r_magazines = [];
vas_r_items = [];
vas_r_glasses = [];
};
//Gunner
if (typeof player == "B_soldier_AR_F") then {
vas_weapons = ["arifle_MX_SW_F","arifle_MX_SW_Black_F","LMG_Mk200_F","LMG_Zafir_F","MMG_02_black_F","MMG_02_camo_F","MMG_02_sand_F","MMG_01_hex_F","MMG_01_tan_F","launch_RPG32_F","hgun_ACPC2_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F","hgun_Pistol_Signal_F"];
vas_magazines = ["100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","150Rnd_762x54_Box","150Rnd_762x54_Box_Tracer","130Rnd_338_Mag","150Rnd_93x64_Mag","RPG32_F","RPG32_HE_F","9Rnd_45ACP_Mag","16Rnd_9x21_Mag","30Rnd_9x21_Mag","11Rnd_45ACP_Mag","6Rnd_45ACP_Cylinder","6Rnd_GreenSignal_F","6Rnd_RedSignal_F","HandGrenade","MiniGrenade","HandGrenade_Stone","SmokeShell","SmokeShellRed","SmokeShellGreen","SmokeShellYellow","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","B_IR_Grenade","DemoCharge_Remote_Mag"];
vas_items = [];
vas_backpacks = [];
vas_glasses = [];
vas_r_weapons = [];
vas_r_backpacks = ["O_Mortar_01_support_F","I_Mortar_01_support_F","O_Mortar_01_weapon_F","I_Mortar_01_weapon_F","O_UAV_01_backpack_F","I_UAV_01_backpack_F","O_HMG_01_support_F","I_HMG_01_support_F","O_HMG_01_support_high_F","I_HMG_01_support_high_F","O_HMG_01_weapon_F","I_HMG_01_weapon_F","B_HMG_01_A_weapon_F","O_HMG_01_A_weapon_F","I_HMG_01_A_weapon_F","O_GMG_01_weapon_F","I_GMG_01_weapon_F","B_GMG_01_A_weapon_F","O_GMG_01_A_weapon_F","I_GMG_01_A_weapon_F","O_HMG_01_high_weapon_F","I_HMG_01_high_weapon_F","B_HMG_01_A_high_weapon_F","O_HMG_01_A_high_weapon_F","I_HMG_01_A_high_weapon_F","O_GMG_01_high_weapon_F","I_GMG_01_high_weapon_F","B_GMG_01_A_high_weapon_F","O_GMG_01_A_high_weapon_F","I_GMG_01_A_high_weapon_F","I_AT_01_weapon_F","O_AT_01_weapon_F","I_AA_01_weapon_F","O_AA_01_weapon_F","B_Respawn_TentDome_F","B_Respawn_TentA_F","B_Respawn_Sleeping_bag_F","B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F","O_Static_Designator_02_weapon_F","B_Static_Designator_01_weapon_F","B_UAV_01_backpack_F","B_AT_01_weapon_F","B_AA_01_weapon_F"];
vas_r_magazines = [];
vas_r_items = ["optic_SOS","optic_Nightstalker","optic_tws","optic_tws_mg","optic_LRPS","NVGoggles_OPFOR","NVGoggles_INDEP","Laserdesignator_02","Laserdesignator_03","Medikit","ToolKit","B_UavTerminal","O_UavTerminal","I_UavTerminal","U_B_GhillieSuit","U_O_GhillieSuit","U_I_GhillieSuit","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_FullGhillie_ard","U_I_FullGhillie_lsh","U_I_FullGhillie_sard","U_I_FullGhillie_ard"];
vas_r_glasses = [];
};
//Pilot
if (typeof player == "B_soldier_repair_F") then {
vas_weapons = ["hgun_ACPC2_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F","hgun_Pistol_Signal_F"];
vas_magazines = ["9Rnd_45ACP_Mag","16Rnd_9x21_Mag","30Rnd_9x21_Mag","11Rnd_45ACP_Mag","6Rnd_45ACP_Cylinder","6Rnd_GreenSignal_F","6Rnd_RedSignal_F","HandGrenade","MiniGrenade","HandGrenade_Stone","SmokeShell","SmokeShellRed","SmokeShellGreen","SmokeShellYellow","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","B_IR_Grenade"];
vas_items = ["U_B_HeliPilotCoveralls","U_O_HeliPilotCoveralls","U_I_HeliPilotCoveralls","U_B_PilotCoveralls","U_O_PilotCoveralls","U_I_PilotCoveralls","V_TacVest_oli","H_PilotHelmetFighter_B","H_PilotHelmetFighter_O","H_PilotHelmetFighter_I","H_PilotHelmetHeli_B","H_PilotHelmetHeli_O","H_PilotHelmetHeli_I","muzzle_snds_H","muzzle_snds_L","muzzle_snds_M","muzzle_snds_B","muzzle_snds_H_MG","muzzle_snds_H_SW","optic_MRD","optic_Yorris","FirstAidKit","Binocular","NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP","ItemWatch","ItemCompass","ItemGPS","ItemRadio","ItemMap"];
vas_backpacks = ["B_AssaultPack_mcamo","B_Parachute"];
vas_glasses = [];
vas_r_weapons = [];
vas_r_backpacks = [];
vas_r_magazines = [];
vas_r_items = [];
vas_r_glasses = [];
};
/*
	BACK END VARIABLEs, DO NOT TOUCH OR I KILL YOU!
*/
VAS_pre_items_uniforms = [];
VAS_pre_items_vests = [];
VAS_pre_items_headgear = [];
VAS_pre_items_attachments = [];
VAS_pre_items_misc = [];
VAS_pre_weapons_rifles = [];
VAS_pre_weapons_heavy = [];
VAS_pre_weapons_launchers = [];
VAS_pre_weapons_pistols = [];
