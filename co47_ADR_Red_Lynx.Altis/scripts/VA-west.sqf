_myBox = _this select 0;
["AmmoboxInit", [_myBox, true]] call BIS_fnc_arsenal;
[_myBox, [true], true] call BIS_fnc_removeVirtualBackpackCargo;
[_myBox, [true], true] call BIS_fnc_removeVirtualItemCargo;
[_myBox, [true], true] call BIS_fnc_removeVirtualWeaponCargo;
[_myBox, [true], true] call BIS_fnc_removeVirtualMagazineCargo;

//---- РЮКЗАКИ
[_myBox,[
"B_AssaultPack_blk",				//Assault Pack (Black)
"B_AssaultPack_cbr",				//Assault Pack (Coyote)
"B_AssaultPack_khk",				//Assault Pack (Khaki)
"B_AssaultPack_ocamo",				//Assault Pack (Hex)
"B_AssaultPack_rgr",				//Assault Pack (Green)
"B_AssaultPack_sgg",				//Assault Pack (Sage)
"B_Bergen_blk",						//Bergen (Black)
"B_Bergen_rgr",						//Bergen (Green)
"B_Bergen_sgg",						//Bergen (Sage)
"B_BergenC_blu",					//Bergen (Blue)
"B_BergenC_grn",					//Bergen (Green)
"B_BergenC_red",					//Bergen (Red)
"B_Carryall_cbr",					//Carryall Backpack (Coyote)
"B_Carryall_khk",					//Carryall Backpack (Khaki)
"B_Carryall_ocamo",					//Carryall Backpack (Hex)
"B_Carryall_oli",					//Carryall Backpack (Olive)
"B_Carryall_oucamo",				//Carryall Backpack (Urban)
"B_FieldPack_blk",					//Field Pack (Black)
"B_FieldPack_cbr",					//Field Pack (Coyote)
"B_FieldPack_khk",					//Field Pack (Khaki)
"B_FieldPack_ocamo",				//Field Pack (Hex)
"B_FieldPack_oli",					//Field Pack (Olive)
"B_FieldPack_oucamo",				//Field Pack (Urban)
"B_Kitbag_cbr",						//Kitbag (Coyote)
"B_Kitbag_rgr",						//Kitbag (Green)
"B_Kitbag_sgg",						//Kitbag (Sage)
"B_O_Parachute_02_F",				//Steerable Parachute
"B_TacticalPack_blk",				//Tactical Backpack (Black)
"B_TacticalPack_ocamo",				//Tactical Backpack (Hex)
"B_TacticalPack_oli",				//Tactical Backpack (Olive)
"B_TacticalPack_rgr",				//Tactical Backpack (Green)

//---- РЮКЗАКИ С ОРУЖИЕМ
"O_AA_01_weapon_F",					//Static Titan Launcher (AA)
"O_AT_01_weapon_F",					//Static Titan Launcher (AT)
"O_GMG_01_high_weapon_F",			//Dismantled Mk32 GMG (Raised)
"O_GMG_01_weapon_F",				//Dismantled Mk32 GMG
"O_HMG_01_high_weapon_F",			//Dismantled Mk30 HMG (Raised)
"O_HMG_01_support_F",				//Folded Tripod
"O_HMG_01_support_high_F",			//Folded Tripod Raised
"O_HMG_01_weapon_F",				//Dismantled Mk30 HMG
"O_Mortar_01_support_F",			//Folded Mk6 Mortar Bipod
"O_Mortar_01_weapon_F",				//Folded Mk6 Mortar Tube
"O_UAV_01_backpack_F"
], true] call BIS_fnc_addVirtualBackpackCargo;

[_myBox,[
//---- ОДЕЖДА
"U_O_CombatUniform_ocamo",			//Fatigues (Hex) [CSAT]
"U_O_CombatUniform_oucamo",			//Fatigues (Urban) [CSAT]
"U_O_FullGhillie_ard",				//Full Ghillie (Arid) [CSAT]
"U_O_FullGhillie_lsh",				//Full Ghillie (Lush) [CSAT]
"U_O_FullGhillie_sard",				//Full Ghillie (Semi-Arid) [CSAT]
"U_O_GhillieSuit",					//Ghillie Suit [CSAT]
"U_O_OfficerUniform_ocamo",			//Officer Fatigues (Hex)
"U_O_PilotCoveralls",				//Pilot Coveralls [CSAT]
"U_O_Wetsuit",						//Wetsuit [CSAT]

//---- РАЗГРУЗКА
"V_BandollierB_blk",				//Slash Bandolier (Black)
"V_BandollierB_cbr",				//Slash Bandolier (Coyote)
"V_BandollierB_khk",				//Slash Bandolier (Khaki)
"V_BandollierB_oli",				//Slash Bandolier (Olive)
"V_BandollierB_rgr",				//Slash Bandolier (Green)
"V_Chestrig_blk",					//Fighter Chestrig (Black)
"V_Chestrig_khk",					//Chest Rig (Khaki)
"V_Chestrig_oli",					//Fighter Chestrig (Olive)
"V_Chestrig_rgr",					//Chest Rig (Green)
"V_HarnessO_brn",					//LBV Harness
"V_HarnessO_gry",					//LBV Harness (Gray)
"V_HarnessOGL_brn",					//LBV Grenadier Harness
"V_HarnessOGL_gry",					//LBV Grenadier Harness (Gray)
"V_HarnessOSpec_brn",				//ELBV Harness
"V_HarnessOSpec_gry",				//ELBV Harness (Gray)
"V_Rangemaster_belt",				//Rangemaster Belt
"V_RebreatherIR",					//Rebreather [CSAT]
"V_TacVest_blk",					//Tactical Vest (Black)
"V_TacVest_brn",					//Tactical Vest (Brown)
"V_TacVest_camo",					//Tactical Vest (Camo)
"V_TacVest_khk",					//Tactical Vest (Khaki)
"V_TacVest_oli",					//Tactical Vest (Olive)
"V_TacVestCamo_khk",				//Camouflaged Vest
"V_TacVestIR_blk",					//Raven Vest

//---- ГОЛОВНЫЕ УБОРЫ
"H_Bandanna_blu",					//Bandanna (Blue)
"H_Bandanna_camo",					//Bandanna (Woodland)
"H_Bandanna_cbr",					//Bandanna (Coyote)
"H_Bandanna_gry",					//Bandanna (Black)
"H_Bandanna_khk",					//Bandanna (Khaki)
"H_Bandanna_khk_hs",				//Bandanna (Headset)
"H_Bandanna_sand",					//Bandanna (Sand)
"H_Bandanna_sgg",					//Bandanna (Sage)
"H_Bandanna_surfer",				//Bandanna (Surfer)
"H_Bandanna_surfer_blk",			//Bandanna (Surfer, Black)
"H_Bandanna_surfer_grn",			//Bandanna (Surfer, Green)
"H_Beret_blk",						//Beret (Black)
"H_Beret_blk_POLICE",				//Beret (Police)
"H_Beret_brn_SF",					//Beret (SAS)
"H_Beret_grn",						//Beret (Green)
"H_Beret_grn_SF",					//Beret (SF)
"H_Beret_ocamo",					//Beret [CSAT]
"H_Beret_red",						//Beret (Red)
"H_Booniehat_dirty",				//Booniehat (Dirty)
"H_Booniehat_grn",					//Booniehat (Green)
"H_Booniehat_khk",					//Booniehat (Khaki)
"H_Booniehat_khk_hs",				//Booniehat (Headset)
"H_Booniehat_oli",					//Booniehat (Olive)
"H_Booniehat_tan",					//Booniehat (Sand)
"H_Cap_blk",						//Cap (Black)
"H_Cap_blk_CMMG",					//Cap (CMMG)
"H_Cap_blk_ION",					//Cap (ION)
"H_Cap_blu",						//Cap (Blue)
"H_Cap_brn_SPECOPS",				//Cap [OPFOR]
"H_Cap_grn",						//Cap (Green)
"H_Cap_grn_BI",						//Cap (BI)
"H_Cap_headphones",					//Rangemaster Cap
"H_Cap_marshal",					//Marshal Cap
"H_Cap_oli",						//Cap (Olive)
"H_Cap_oli_hs",						//Cap (Olive, Headset)
"H_Cap_police",						//Cap (Police)
"H_Cap_press",						//Cap (Press)
"H_Cap_red",						//Cap (Red)
"H_Cap_surfer",						//Cap (Surfer)
"H_Cap_tan",						//Cap (Tan)
"H_CrewHelmetHeli_O",				//Heli Crew Helmet [CSAT]
"H_Hat_blue",						//Hat (Blue)
"H_Hat_brown",						//Hat (Brown)
"H_Hat_camo",						//Hat (Camo)
"H_Hat_checker",					//Hat (Checker)
"H_Hat_grey",						//Hat (Gray)
"H_Hat_tan",						//Hat (Tan)
"H_HelmetCrew_O",					//Crew Helmet [CSAT]
"H_HelmetLeaderO_ocamo",			//Defender Helmet (Hex)
"H_HelmetLeaderO_oucamo",			//Defender Helmet (Urban)
"H_HelmetO_ocamo",					//Protector Helmet (Hex)
"H_HelmetO_oucamo",					//Protector Helmet (Urban)
"H_HelmetSpecO_blk",				//Assassin Helmet (Black)
"H_HelmetSpecO_ocamo",				//Assassin Helmet (Hex)
"H_MilCap_blue",					//Military Cap (Blue)
"H_MilCap_gry",						//Military Cap (Gray)
"H_MilCap_ocamo",					//Military Cap (Hex)
"H_MilCap_oucamo",					//Military Cap (Urban)
"H_MilCap_rucamo",					//Military Cap (Russia)
"H_PilotHelmetFighter_O",			//Pilot Helmet [CSAT]
"H_PilotHelmetHeli_O",				//Heli Pilot Helmet [CSAT]
"H_Shemag_khk",						//Shemag mask (Khaki)
"H_Shemag_olive",					//Shemag (Olive)
"H_Shemag_olive_hs",				//Shemag (Olive, Headset)
"H_Shemag_tan",						//Shemag mask (Tan)
"H_ShemagOpen_khk",					//Shemag (White)
"H_ShemagOpen_tan",					//Shemag (Tan)
"H_StrawHat",						//Straw Hat
"H_StrawHat_dark",					//Straw hat (Dark)
"H_Watchcap_blk",					//Beanie
"H_Watchcap_camo",					//Beanie (Green)
"H_Watchcap_cbr",					//Beanie (Coyote)
"H_Watchcap_khk",					//Beanie (Khaki)
"H_Watchcap_sgg",					//Beanie (Sage)

//---- ОЧКИ
"G_Aviator",
"G_Balaclava_blk",
"G_balaclava_combat",
"G_Balaclava_lowprofile",
"G_Balaclava_oli",
"G_Bandanna_aviator",
"G_Bandanna_beast",
"G_Bandanna_blk",
"G_Bandanna_khk",
"G_Bandanna_oli",
"G_Bandanna_shades",
"G_Bandanna_sport",
"G_Bandanna_tan",
"G_Combat",
"G_Diving",
"G_Lowprofile",
"G_Shades_Black",
"G_Shades_Blue",
"G_Shades_Green",
"G_Shades_Red",
"G_Spectacles",
"G_Spectacles_Tinted",
"G_Sport_Blackred",
"G_Sport_Blackyellow",
"G_Sport_Checkered",
"G_Sport_Greenblack",
"G_Sport_Red",
"G_Squares",
"G_Squares_Tinted",
"G_Tactical_Black",
"G_Tactical_Clear",

//---- ГЛУШИТЕЛИ
"muzzle_snds_338_black",			//Sound Suppressor (.338, Black)
"muzzle_snds_338_green",			//Sound Suppressor (.338, Green)
"muzzle_snds_338_sand",				//Sound Suppressor (.338, Sand)
"muzzle_snds_93mmg",				//Sound Suppressor (9.3mm, Black)
"muzzle_snds_93mmg_tan",			//Sound Suppressor (9.3mm, Tan)
"muzzle_snds_acp",					//Sound Suppressor (.45 ACP)
"muzzle_snds_B",					//Sound Suppressor (7.62 mm)
"muzzle_snds_H",					//Sound Suppressor (6.5 mm)
"muzzle_snds_H_MG",					//Sound Suppressor LMG (6.5 mm)
"muzzle_snds_H_SW",					//Sound Suppressor LMG (6.5 mm)
"muzzle_snds_L",					//Sound Suppressor (9 mm)
"muzzle_snds_M",					//Sound Suppressor (5.56 mm)

//---- СОШКИ
"bipod_01_F_blk",					//Bipod (Black) [NATO]
"bipod_01_F_mtp",					//Bipod (MTP) [NATO]
"bipod_01_F_snd",					//Bipod (Sand) [NATO]
"bipod_02_F_blk",					//Bipod (Black) [CSAT]
"bipod_02_F_hex",					//Bipod (Hex) [CSAT]
"bipod_02_F_tan",					//Bipod (Tan) [CSAT]
"bipod_03_F_blk",					//Bipod (Black) [AAF]
"bipod_03_F_oli",					//Bipod (Olive) [AAF]

//---- ОПТИКА
"optic_Aco",						//ACO (Red)
"optic_ACO_grn",					//ACO (Green)
"optic_ACO_grn_smg",				//ACO SMG (Green)
"optic_Aco_smg",					//ACO SMG (Red)
"optic_AMS",						//AMS (Black)
"optic_AMS_khk",					//AMS (Khaki)
"optic_AMS_snd",					//AMS (Sand)
"optic_Arco",						//ARCO
"optic_DMS",						//DMS
"optic_Hamr",						//RCO
"optic_Holosight",					//MK17 Holosight
"optic_Holosight_smg",				//Mk17 Holosight SMG
"optic_KHS_blk",					//Kahlia (Black)
"optic_KHS_hex",					//Kahlia (Hex)
"optic_KHS_old",					//Kahlia (Old)
"optic_KHS_tan",					//Kahlia (Tan)
"optic_LRPS",						//LRPS
"optic_MRCO",						//MRCO
"optic_MRD",						//MRD
"optic_NVS",						//NVS
"optic_SOS",						//MOS
"optic_Yorris",						//Yorris J2

//---- ОБВЕС
"acc_flashlight",					//Flashlight
"acc_pointer_IR",					//IR Laser Pointer

//---- ВЕЩИ
"O_UavTerminal",					//UAV Terminal
"FirstAidKit",						//First Aid Kit
"ItemCompass",						//Compass
"ItemGPS",							//GPS
"ItemMap",							//Map
"ItemRadio",						//Radio
"ItemWatch",						//Watch
"Medikit",							//Medikit
"NVGoggles",						//NV Goggles (Brown)
"NVGoggles_INDEP",					//NV Goggles (Green)
"NVGoggles_OPFOR",					//NV Goggles (Black)
"MineDetector",						//Mine Detector
"ToolKit"							//Toolkit
],true] call BIS_fnc_addVirtualItemCargo;

//---- ПАТРОНЫ
[_myBox,[
//---- МАГАЗИНЫ
"30Rnd_556x45_Stanag",
"30Rnd_556x45_Stanag_Tracer_Red",
"30Rnd_556x45_Stanag_Tracer_Green",
"30Rnd_556x45_Stanag_Tracer_Yellow",
"20Rnd_556x45_UW_mag",
"30Rnd_65x39_caseless_mag",
"30Rnd_65x39_caseless_green",
"30Rnd_65x39_caseless_mag_Tracer",
"30Rnd_65x39_caseless_green_mag_Tracer",
"100Rnd_65x39_caseless_mag",
"100Rnd_65x39_caseless_mag_Tracer",
"200Rnd_65x39_cased_Box",
"200Rnd_65x39_cased_Box_Tracer",
"20Rnd_762x51_Mag",
"7Rnd_408_Mag",
"5Rnd_127x108_Mag",
"30Rnd_9x21_Mag",
"16Rnd_9x21_Mag",
"150Rnd_762x54_Box",
"150Rnd_762x54_Box_Tracer",
//marksman
"10Rnd_338_Mag",
"130Rnd_338_Mag",
"10Rnd_127x54_Mag",
"150Rnd_93x64_Mag",
"10Rnd_93x64_DMR_05_Mag",

//---- ПОДСТВОЛЫ
"UGL_FlareWhite_F",
"UGL_FlareGreen_F",
"UGL_FlareRed_F",
"UGL_FlareYellow_F",
"UGL_FlareCIR_F",

"1Rnd_HE_Grenade_shell",
"1Rnd_Smoke_Grenade_shell",
"1Rnd_SmokeRed_Grenade_shell",
"1Rnd_SmokeGreen_Grenade_shell",
"1Rnd_SmokeYellow_Grenade_shell",
"1Rnd_SmokePurple_Grenade_shell",
"1Rnd_SmokeBlue_Grenade_shell",
"1Rnd_SmokeOrange_Grenade_shell",
"3Rnd_HE_Grenade_shell",
"3Rnd_UGL_FlareWhite_F",
"3Rnd_UGL_FlareGreen_F",
"3Rnd_UGL_FlareRed_F",
"3Rnd_UGL_FlareYellow_F",
"3Rnd_UGL_FlareCIR_F",
"3Rnd_Smoke_Grenade_shell",
"3Rnd_SmokeRed_Grenade_shell",
"3Rnd_SmokeGreen_Grenade_shell",
"3Rnd_SmokeYellow_Grenade_shell",
"3Rnd_SmokePurple_Grenade_shell",
"3Rnd_SmokeBlue_Grenade_shell",
"3Rnd_SmokeOrange_Grenade_shell",

//---- ГРАНАТЫ
"B_IR_Grenade",
"HandGrenade",
"MiniGrenade",

//---- ДЫМЫ
"SmokeShell",
"SmokeShellYellow",
"SmokeShellGreen",
"SmokeShellRed",
"SmokeShellPurple",
"SmokeShellOrange",
"SmokeShellBlue",

//---- ХИМСВЕТ
"Chemlight_green",
"Chemlight_red",
"Chemlight_yellow",
"Chemlight_blue",

//---- ВЗРЫВЧАТКА,МИНЫ
"DemoCharge_Remote_Mag",
"SatchelCharge_Remote_Mag",
"ATMine_Range_Mag",
"ClaymoreDirectionalMine_Remote_Mag",
"APERSMine_Range_Mag",
"APERSBoundingMine_Range_Mag",
"SLAMDirectionalMine_Wire_Mag",
"APERSTripMine_Wire_Mag",

//---- РАКЕТЫ
"RPG32_F",
"RPG32_HE_F",
"NLAW_F",
"Laserbatteries"
],true] call BIS_fnc_addVirtualMagazineCargo;

//---- ОРУЖИЕ
[_myBox,[
"srifle_GM6_camo_F",
"srifle_LRR_camo_F",
"hgun_Pistol_Signal_F",
"hgun_P07_F",
"hgun_Rook40_F",
"hgun_Pistol_heavy_01_F",
"hgun_Pistol_heavy_02_F",
"SMG_01_F",
"SMG_02_F",
"arifle_MX_F",
"arifle_MXC_F",
"arifle_MXM_F",
"arifle_MX_GL_F",
"arifle_MX_SW_F",
"arifle_MX_Black_F",
"arifle_MXC_Black_F",
"arifle_MX_GL_Black_F",
"arifle_MX_SW_Black_F",
"srifle_LRR_F",
"launch_NLAW_F",
"launch_B_Titan_F",
"launch_B_Titan_short_F",
"launch_RPG32_F",
"hgun_ACPC2_F",
"hgun_PDW2000_F",
"arifle_Mk20_F",
"arifle_Mk20C_F",
"arifle_Mk20_GL_F",
"arifle_Mk20_plain_F",
"arifle_Mk20C_plain_F",
"arifle_Mk20_GL_plain_F",
"LMG_Mk200_F",
"srifle_EBR_F",
"srifle_GM6_F",
"arifle_TRG20_F",
"arifle_TRG21_F",
"arifle_TRG21_GL_F",
"arifle_SDAR_F",
"arifle_Katiba_GL_F",
"arifle_Katiba_F",
"arifle_Katiba_C_F",
"LMG_Zafir_F",
"srifle_DMR_01_F",
"Binocular",						//Binoculars
"Rangefinder",						//Rangefinder
"Laserdesignator_02",				//Laser Designator [CSAT]
//marksman
"LMG_Mk200_BI_F",
"srifle_DMR_02_F",
"srifle_DMR_02_camo_F",
"srifle_DMR_02_sniper_F",
"srifle_DMR_03_F",
"srifle_DMR_03_khaki_F",
"srifle_DMR_03_tan_F",
"srifle_DMR_03_multicam_F",
"srifle_DMR_03_woodland_F",
"srifle_DMR_04_F",
"srifle_DMR_04_Tan_F",
"srifle_DMR_05_blk_F",
"srifle_DMR_05_hex_F",
"srifle_DMR_05_tan_f",
"srifle_DMR_06_camo_F",
"srifle_DMR_06_olive_F",
"MMG_01_hex_F",
"MMG_01_tan_F",
"MMG_02_camo_F",
"MMG_02_black_F",
"MMG_02_sand_F"
],true] call BIS_fnc_addVirtualWeaponCargo;