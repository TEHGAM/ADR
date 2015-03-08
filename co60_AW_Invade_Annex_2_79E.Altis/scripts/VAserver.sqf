// Made by Raz, data entry from Josh, Zissou and stuffed sheep Made on AhoyWorld this script features all magazines, most weapons, Nato backpacks, Nato items, Nato clothes. You may use this on your mission start, please keep us credited! Enjoy.
// _null = [this] execVM "scripts\VAserver.sqf";

if (!isServer) exitWith {};

private ["_box"];

_box = _this select 0;

["AmmoboxInit",[_box,false,{true}]] call BIS_fnc_arsenal;

[
	_box,
	[
		"B_Kitbag_Base","B_Kitbag_mcamo","B_GMG_01_weapon_F","B_HMG_01_A_weapon_F","B_GMG_01_A_weapon_F","B_UAV_01_backpack_F","I_UAV_01_backpack_F","O_UAV_01_backpack_F","B_HMG_01_high_weapon_F","B_GMG_01_high_weapon_F","B_HMG_01_A_high_weapon_F","B_GMG_01_A_high_weapon_F","B_HMG_01_support_F","B_HMG_01_support_high_F","B_AT_01_weapon_F","B_AA_01_weapon_F","B_Mortar_01_weapon_F","B_Mortar_01_support_F","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_Blk","B_AssaultPack_cBr","B_AssaultPack_mcamo","B_AssaultPack_ocamo","B_AssaultPack_kerry","B_","Bergen_Blk","B_","Bergen_mcamo","B_","Bergen_rgr","B_","Bergen_sgg","B_","BergenC_Blu","B_","BergenC_grn","B_","BergenC_red","B_Carryall_cBr","B_Carryall_oli","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo","B_Carryall_oucamo","B_FieldPack_cBr","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_oucamo","B_FieldPack_oli","B_FieldPack_Blk","B_Kit","Bag_mcamo","B_Kit","Bag_sgg","B_Kit","Bag_cBr","B_Kit","Bag_rgr","B_OutdoorPack_Blk","B_OutdoorPack_Blu","B_OutdoorPack_tan","B_TacticalPack_Blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr","B_Parachute"
	],
	true
] call BIS_fnc_addVirtualBackpackCargo;
	
[
	_box,
	[
		"1Rnd_HE_Grenade_shell","UGL_FlareWhite_F","UGL_FlareGreen_F","UGL_FlareRed_F","UGL_FlareYellow_F","UGL_FlareCIR_F","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeYellow_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","3Rnd_HE_Grenade_shell","3Rnd_UGL_FlareWhite_F","3Rnd_UGL_FlareGreen_F","3Rnd_UGL_FlareRed_F","3Rnd_UGL_FlareYellow_F","3Rnd_UGL_FlareCIR_F","3Rnd_Smoke_Grenade_shell","3Rnd_SmokeRed_Grenade_shell","3Rnd_SmokeGreen_Grenade_shell","3Rnd_SmokeYellow_Grenade_shell","3Rnd_SmokePurple_Grenade_shell","3Rnd_SmokeBlue_Grenade_shell","3Rnd_SmokeOrange_Grenade_shell","HandGrenade","MiniGrenade","SmokeShell","SmokeShellYellow","SmokeShellGreen","SmokeShellRed","SmokeShellPurple","SmokeShellOrange","SmokeShellBlue","Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue","B_IR_Grenade","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ATMine_Range_Mag","ClaymoreDirectionalMine_Remote_Mag","APERSMine_Range_Mag","APERSBoundingMine_Range_Mag","SLAMDirectionalMine_Wire_Mag","APERSTripMine_Wire_Mag","Laserbatteries"
	],
	true
] call BIS_fnc_addVirtualMagazineCargo;

[
	_box,
	[
		"srifle_GM6_camo_F","srifle_LRR_camo_F","hgun_P07_F","hgun_Pistol_heavy_01_F","SMG_01_F","SMG_02_F","arifle_MX_F","arifle_MXC_F","arifle_MXM_F","arifle_MX_GL_F","arifle_MX_SW_F","arifle_MX_Black_F","arifle_MXC_Black_F","arifle_MXC_Black_F","arifle_MXC_Black_F","arifle_MXC_Black_F","arifle_MXM_Black_F","arifle_MX_GL_Black_F","arifle_MX_SW_Black_F","srifle_LRR_F","launch_NLAW_F","launch_B_Titan_F","launch_B_Titan_short_F","hgun_ACPC2_F","hgun_PDW2000_F","arifle_Mk20_F","arifle_Mk20C_F","arifle_Mk20_GL_F","arifle_Mk20_plain_F","arifle_Mk20C_plain_F","arifle_Mk20_GL_plain_F","LMG_Mk200_F","srifle_EBR_F","srifle_GM6_F","launch_I_Titan_F","launch_I_Titan_short_F","arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F","arifle_SDAR_F","Binocular","Rangefinder","Laserdesignator","MineDetector"
	],
	true
] call BIS_fnc_addVirtualWeaponCargo;
	
	
[
	_box,
	[
		"G_B_Diving","G_Balaclava_blk","G_Balaclava_combat","G_Combat","G_Tactical_Black","G_Tactical_Clear","G_Shades_Black","G_Lowprofile","G_Bandanna_shades","V_TacVestIR_blk","U_I_G_Story_Protagonist_F","U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_tshirt", "U_B_CombatUniform_mcam_vest", "U_B_CombatUniform_mcam_worn", "U_B_CombatUniform_sgg","U_B_CombatUniform_sgg_tshirt", "U_B_CombatUniform_sgg_vest", "U_B_CombatUniform_wdl", "U_B_CombatUniform_wdl_tshirt", "U_B_CombatUniform_wdl_vest", "U_B_SpecopsUniform_sgg","U_B_GhillieSuit","U_B_HeliPilotCoveralls","U_B_PilotCoveralls", "U_B_Wetsuit","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3","U_B_survival_uniform","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_rgr","V_PlateCarrierSpec_rgr","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_PlateCarrier_Kerry","V_Chestrig_khk","V_Chestrig_rgr","V_Chestrig_oli","V_Chestrig_blk","V_RebreatherB","H_HelmetB","H_HelmetB_camo","H_HelmetB_paint","H_HelmetB_grass","H_HelmetB_snakeskin","H_HelmetB_desert","H_HelmetB_black","H_HelmetB_sand","H_HelmetB_light","H_HelmetB_light_desert","H_HelmetB_light_black","H_HelmetB_light_sand","H_HelmetB_light_grass","H_HelmetB_light_snakeskin","H_HelmetSpecB","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetSpecB_blk","H_HelmetB_plain_mcamo","H_HelmetB_plain_blk","H_HelmetCrew_B","H_CrewHelmetHeli_B","H_PilotHelmetHeli_B","H_PilotHelmetFighter_B","H_Bandanna_mcamo","H_BandMask_blk","H_BandMask_demon","H_BandMask_khk","H_BandMask_reaper","H_Booniehat_mcamo","H_MilCap_mcamo","H_Beret_grn_SF","H_Beret_brn_SF","H_Beret_02","H_Cap_brn_SPECOPS","H_Cap_tan_specops_US","H_Cap_khaki_specops_UK", "ItemWatch","ItemCompass","ItemGPS","ItemRadio","ItemMap","NVGoggles","NVGoggles_OPFOR","FirstAidKit","Medikit","ToolKit","muzzle_snds_L", "muzzle_snds_acp", "muzzle_snds_M", "muzzle_snds_H", "muzzle_snds_H_MG", "muzzle_snds_B", "acc_flashlight", "acc_pointer_IR", "optic_Yorris", "optic_MRD", "optic_Aco_smg", "optic_ACO_grn_smg", "optic_Holosight_smg", "optic_Aco", "optic_ACO_grn", "optic_Holosight", "optic_Hamr", "optic_Arco", "optic_MRCO", "optic_DMS", "optic_SOS", "optic_LRPS", "optic_NVS", "optic_Nightstalker", "optic_tws", "optic_tws_mg","H_Shemag_khk","H_Shemag_olive","H_Shemag_olive_hs","H_Shemag_tan"
	],
	true
] call BIS_fnc_addVirtualItemCargo;