//Allow player to respawn with his loadout? If true unit will respawn with all ammo from initial save! Set to false to disable this and rely on other scripts!
vas_onRespawn = false;
//Preload Weapon Config?
vas_preload = true;
//If limiting weapons its probably best to set this to true so people aren't loading custom loadouts with restricted gear.
vas_disableLoadSave = false;
//Amount of save/load slots
vas_customslots = 29; //9 is actually 10 slots, starts from 0 to whatever you set, so always remember when setting a number to minus by 1, i.e 12 will be 11.
//Disable 'VAS hasn't finished loading' Check !!! ONLY RECOMMENDED FOR THOSE THAT USE ACRE AND OTHER LARGE ADDONS !!!
vas_disableSafetyCheck = false;
/*
	NOTES ON EDITING!
	YOU MUST PUT VALID CLASS NAMES IN THE VARIABLES IN AN ARRAY FORMAT, NOT DOING SO WILL RESULT IN BREAKING THE SYSTEM!
	PLACE THE CLASS NAMES OF GUNS/ITEMS/MAGAZINES/BACKPACKS/GOGGLES IN THE CORRECT ARRAYS! TO DISABLE A SELECTION I.E
	GOGGLES vas_goggles = [""]; AND THAT WILL DISABLE THE ITEM SELECTION FOR WHATEVER VARIABLE YOU ARE WANTING TO DISABLE!

														EXAMPLE
	vas_weapons = ["srifle_EBR_ARCO_point_grip_F","arifle_Khaybar_Holo_mzls_F","arifle_TRG21_GL_F","Binocular"];
	vas_magazines = ["30Rnd_65x39_case_mag","20Rnd_762x45_Mag","30Rnd_65x39_caseless_green"];
	vas_items = ["ItemMap","ItemGPS","NVGoggles"];
	vas_backpacks = ["B_Bergen_sgg_Exp","B_AssaultPack_rgr_Medic"];
	vas_goggles = [""];

												Example for side specific (TvT)
	switch(playerSide) do
	{
		//Blufor
		case west:
		{
			vas_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
		//Opfor
		case west:
		{
			vas_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
	};
*/

//If the arrays below are empty (as they are now) all weapons, magazines, items, backpacks and goggles will be available
//Want to limit VAS to specific weapons? Place the classnames in the array!
vas_weapons = [];
//Want to limit VAS to specific magazines? Place the classnames in the array!
vas_magazines = [];
//Want to limit VAS to specific items? Place the classnames in the array!
vas_items = [];
//Want to limit backpacks? Place the classnames in the array!
vas_backpacks = [];
//Want to limit goggles? Place the classnames in the array!
vas_glasses = [];


/*
	NOTES ON EDITING:
	THIS IS THE SAME AS THE ABOVE VARIABLES, YOU NEED TO KNOW THE CLASS NAME OF THE ITEM YOU ARE RESTRICTING. THIS DOES NOT WORK IN
	CONJUNCTION WITH THE ABOVE METHOD, THIs IS ONLY FOR RESTRICTING / LIMITING ITEMS FROM VAS AND NOTHING MORE

														EXAMPLE
	vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
	vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
	vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS

												Example for side specific (TvT)
	switch(playerSide) do
	{
		//Blufor
		case west:
		{
			vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
		//Opfor
		case west:
		{
			vas_r_weapons = ["srifle_EBR_F","arifle_MX_GL_F"];
			vas_r_items = ["muzzle_snds_H","muzzle_snds_B","muzzle_snds_L","muzzle_snds_H_MG"]; //Removes suppressors from VAS
			vas_r_goggles = ["G_Diving"]; //Remove diving goggles from VAS
		};
	};
*/

//Below are variables you can use to restrict certain items from being used.
//Weapons to remove from VAS
vas_r_weapons = [
	"Laserdesignator_03"				//Laser Designator [AAF] // если запретить НАТОвский вариант, то все три запрещаются.
];
//Backpacks to remove from VAS
vas_r_backpacks = [
	"B_AssaultPack_dgtl",				//Assault Pack (Digi)
	"B_AssaultPack_mcamo",				//Assault Pack (MTP)
	"B_AssaultPack_Kerry",				//US Assault Pack (Kerry)
	"B_Bergen_mcamo",					//Bergen (MTP)
	"B_Carryall_mcamo",					//Carryall Backpack (MTP)
	"B_Kitbag_mcamo",					//Kitbag (MTP)
	"B_TacticalPack_mcamo",				//Tactical Backpack (MTP)
	"B_GMG_01_A_weapon_F",				//Dismantled Autonomous GMG
	"I_GMG_01_A_weapon_F",				//Dismantled Autonomous GMG
	"O_GMG_01_A_weapon_F",				//Dismantled Autonomous GMG
	"B_HMG_01_A_weapon_F",				//Dismantled Autonomous HMG
	"I_HMG_01_A_weapon_F",				//Dismantled Autonomous HMG
	"O_HMG_01_A_weapon_F",				//Dismantled Autonomous HMG
	"B_HMG_01_weapon_F",				//Dismantled Mk30 HMG
	"I_HMG_01_weapon_F",				//Dismantled Mk30 HMG
	"I_HMG_01_high_weapon_F",			//Dismantled Mk30 HMG (Raised)
	"B_HMG_01_high_weapon_F",			//Dismantled Mk30 HMG (Raised)
	"B_HMG_01_A_high_weapon_F",			//Dismantled Mk30A HMG (Raised)
	"I_HMG_01_A_high_weapon_F",			//Dismantled Mk30A HMG (Raised)
	"O_HMG_01_A_high_weapon_F",			//Dismantled Mk30A HMG (Raised)
	"B_GMG_01_weapon_F",				//Dismantled Mk32 GMG
	"I_GMG_01_weapon_F",				//Dismantled Mk32 GMG
	"B_GMG_01_high_weapon_F",			//Dismantled Mk32 GMG (Raised)
	"I_GMG_01_high_weapon_F",			//Dismantled Mk32 GMG (Raised)
	"B_GMG_01_A_high_weapon_F",			//Dismantled Mk32A GMG (Raised)
	"I_GMG_01_A_high_weapon_F",			//Dismantled Mk32A GMG (Raised)
	"O_GMG_01_A_high_weapon_F",			//Dismantled Mk32A GMG (Raised)
	"B_Mortar_01_support_F",			//Folded Mk6 Mortar Bipod
	"I_Mortar_01_support_F",			//Folded Mk6 Mortar Bipod
	"B_Mortar_01_weapon_F",				//Folded Mk6 Mortar Tube
	"I_Mortar_01_weapon_F",				//Folded Mk6 Mortar Tube
	"B_HMG_01_support_F",				//Folded Tripod
	"I_HMG_01_support_F",				//Folded Tripod
	"B_HMG_01_support_high_F",			//Folded Tripod Raised
	"I_HMG_01_support_high_F",			//Folded Tripod Raised
	"B_AA_01_weapon_F",					//Static Titan Launcher (AA)
	"I_AA_01_weapon_F",					//Static Titan Launcher (AA)
	"B_AT_01_weapon_F",					//Static Titan Launcher (AT)
	"I_AT_01_weapon_F",					//Static Titan Launcher (AT)
	"B_UAV_01_backpack_F",
	"I_UAV_01_backpack_F"
];

//Magazines to remove from VAS
vas_r_magazines = [];

//Items to remove from VAS
vas_r_items = [
	//---- ОДЕЖДА
	"U_B_CombatUniform_mcam",			//Combat Fatigues (MTP)
	"U_B_CombatUniform_mcam_tshirt",	//Combat Fatigues (MTP) (Tee)
	"U_B_CombatUniform_mcam_vest",		//Recon Fatigues (MTP)
	"U_B_CombatUniform_mcam_worn",		//Worn Combat Fatigues (MTP)
	"U_B_CTRG_1",						//CTRG Combat Uniform
	"U_B_CTRG_2",						//CTRG Combat Uniform (Tee)
	"U_B_CTRG_3",						//CTRG Combat Uniform (Rolled-up)
	"U_B_FullGhillie_ard",				//Full Ghillie (Arid) [NATO]
	"U_B_FullGhillie_lsh",				//Full Ghillie (Lush) [NATO]
	"U_B_FullGhillie_sard",				//Full Ghillie (Semi-Arid) [NATO]
	"U_B_GhillieSuit",					//Ghillie Suit [NATO]
	"U_B_HeliPilotCoveralls",			//Heli Pilot Coveralls [NATO]
	"U_B_PilotCoveralls",				//Pilot Coveralls [NATO]
	"U_B_Protagonist_VR",				//VR Suit [NATO]
	"U_B_Soldier_VR",					//VR Entity Suit
	"U_B_SpecopsUniform_sgg",			//Specop Fatigues (Sage)
	"U_B_survival_uniform",				//Survival Fatigues
	"U_B_Wetsuit",						//Wetsuit [NATO]
	"U_BasicBody",						//Underwear
	"U_BG_Guerilla1_1",					//Guerilla Garment
	"U_BG_Guerilla2_1",					//Guerilla Outfit (Plain, Dark)
	"U_BG_Guerilla2_2",					//Guerilla Outfit (Pattern)
	"U_BG_Guerilla2_3",					//Guerilla Outfit (Plain, Light)
	"U_BG_Guerilla3_1",					//Guerilla Smocks
	"U_BG_Guerilla3_2",					//Guerilla Smocks 1
	"U_BG_Guerrilla_6_1",				//Guerilla Apparel
	"U_BG_leader",						//Guerilla Uniform
	"U_C_Commoner1_1",					//Commoner Clothes 2
	"U_C_Commoner1_2",					//Commoner Clothes 2
	"U_C_Commoner1_3",					//Commoner Clothes 3
	"U_C_Commoner_shorts",				//Commoner Shorts
	"U_C_Driver_1",						//Driver Coverall (Fuel)
	"U_C_Driver_1_black",				//Driver Coverall (Black)
	"U_C_Driver_1_blue",				//Driver Coverall (Blue)
	"U_C_Driver_1_green",				//Driver Coverall (Green)
	"U_C_Driver_1_orange",				//Driver Coverall (Orange)
	"U_C_Driver_1_red",					//Driver Coverall (Red)
	"U_C_Driver_1_white",				//Driver Coverall (White)
	"U_C_Driver_1_yellow",				//Driver Coverall (Yellow)
	"U_C_Driver_2",						//Driver Coverall (Bluking)
	"U_C_Driver_3",						//Driver Coverall (Redstone)
	"U_C_Driver_4",						//Driver Coverall (Vrana)
	"U_C_HunterBody_grn",				//Hunting Clothes
	"U_C_Journalist",					//Journalist Clothes
	"U_C_Poloshirt_blue",				//Commoner Clothes (Blue)
	"U_C_Poloshirt_burgundy",			//Commoner Clothes (Burgundy)
	"U_C_Poloshirt_redwhite",			//Commoner Clothes (Red-White)
	"U_C_Poloshirt_salmon",				//Commoner Clothes (Salmon)
	"U_C_Poloshirt_stripped",			//Commoner Clothes (Striped)
	"U_C_Poloshirt_tricolour",			//Commoner Clothes (Tricolor)
	"U_C_Poor_1",						//Worn Clothes
	"U_C_Poor_2",						//Worn Clothes
	"U_C_Poor_shorts_1",				//Worn Shorts 1
	"U_C_Scientist",					//Scientist Clothes
	"U_C_ShirtSurfer_shorts",			//Surfer Outfit 1
	"U_C_Soldier_VR",					//VR Entity Suit
	"U_C_TeeSurfer_shorts_1",			//Surfer Outfit 2
	"U_C_TeeSurfer_shorts_2",			//Surfer Outfit 3
	"U_C_WorkerCoveralls",				//Worker Coveralls
	"U_Competitor",						//Competitor Suit
	"U_I_CombatUniform",				//Combat Fatigues [AAF]
	"U_I_CombatUniform_shortsleeve",	//Combat Fatigues [AAF] (Rolled-up)
	"U_I_CombatUniform_tshirt",			//Combat Fatigues [AAF] (Officer)
	"U_I_FullGhillie_ard",				//Full Ghillie (Arid) [AAF]
	"U_I_FullGhillie_lsh",				//Full Ghillie (Lush) [AAF]
	"U_I_FullGhillie_sard",				//Full Ghillie (Semi-Arid) [AAF]
	"U_I_G_resistanceLeader_F",			//Combat Fatigues (Stavrou)
	"U_I_G_Story_Protagonist_F",		//Worn Combat Fatigues (Kerry)
	"U_I_GhillieSuit",					//Ghillie Suit [AAF]
	"U_I_HeliPilotCoveralls",			//Heli Pilot Coveralls [AAF]
	"U_I_OfficerUniform",				//Combat Fatigues [AAF] (Officer)
	"U_I_pilotCoveralls",				//Pilot Coveralls [AAF]
	"U_I_Protagonist_VR",				//VR Suit [AAF]
	"U_I_Soldier_VR",					//VR Entity Suit
	"U_I_Wetsuit",						//Wetsuit [AAF]
	"U_IG_Guerilla1_1",					//Guerilla Garment
	"U_IG_Guerilla2_1",					//Guerilla Outfit (Plain, Dark)
	"U_IG_Guerilla2_2",					//Guerilla Outfit (Pattern)
	"U_IG_Guerilla2_3",					//Guerilla Outfit (Plain, Light)
	"U_IG_Guerilla3_1",					//Guerilla Smocks
	"U_IG_Guerilla3_2",					//Guerilla Smocks 1
	"U_IG_Guerrilla_6_1",				//Guerilla Apparel
	"U_IG_leader",						//Guerilla Uniform
	"U_KerryBody",						//Combat Fatigues (Kerry)
	"U_Marshal",						//Marshal Clothes
	"U_MillerBody",						//Combat Fatigues (Miller)
	"U_NikosAgedBody",					//Underwear 1
	"U_NikosBody",						//Nikos Clothes
	"U_O_Protagonist_VR",				//VR Suit [CSAT]
	"U_O_Soldier_VR",					//VR Entity Suit
	"U_OG_Guerilla1_1",					//Guerilla Garment
	"U_OG_Guerilla2_1",					//Guerilla Outfit (Plain, Dark)
	"U_OG_Guerilla2_2",					//Guerilla Outfit (Pattern)
	"U_OG_Guerilla2_3",					//Guerilla Outfit (Plain, Light)
	"U_OG_Guerilla3_1",					//Guerilla Smocks
	"U_OG_Guerilla3_2",					//Guerilla Smocks 1
	"U_OG_Guerrilla_6_1",				//Guerilla Apparel
	"U_OG_leader",						//Guerilla Uniform
	"U_OrestesBody",					//Jacket and Shorts
	"U_Rangemaster",					//Rangemaster Suit

	//---- РАЗГРУЗКА
	"V_I_G_resistanceLeader_F",			//Tactical Vest (Stavrou)
	"V_PlateCarrier1_blk",				//Carrier Lite (Black)
	"V_PlateCarrier1_rgr",				//Carrier Lite (Green)
	"V_PlateCarrier2_rgr",				//Carrier Rig (Green)
	"V_PlateCarrier3_rgr",				//Carrier Rig (Green)
	"V_PlateCarrier_Kerry",				//US Plate Carrier Rig (Kerry)
	"V_PlateCarrierGL_blk",				//Carrier GL Rig (Black)
	"V_PlateCarrierGL_mtp",				//Carrier GL Rig (MTP)
	"V_PlateCarrierGL_rgr",				//Carrier GL Rig (Green)
	"V_PlateCarrierH_CTRG",				//CTRG Plate Carrier Rig Mk.2 (Heavy)
	"V_PlateCarrierIA1_dgtl",			//GA Carrier Lite (Digi)
	"V_PlateCarrierIA2_dgtl",			//GA Carrier Rig (Digi)
	"V_PlateCarrierIAGL_dgtl",			//GA Carrier GL Rig (Digi)
	"V_PlateCarrierIAGL_oli",			//GA Carrier GL Rig (Olive)
	"V_PlateCarrierL_CTRG",				//CTRG Plate Carrier Rig Mk.1 (Light)
	"V_PlateCarrierSpec_blk",			//Carrier Special Rig (Black)
	"V_PlateCarrierSpec_mtp",			//Carrier Special Rig (MTP)
	"V_PlateCarrierSpec_rgr",			//Carrier Special Rig (Green)
	"V_Press_F",						//Vest (Press)
	"V_RebreatherB",					//Rebreather [NATO]
	"V_RebreatherIA",					//Rebreather [AAF]
	"V_TacVest_blk_POLICE",				//Tactical Vest (Police)

	//---- ГОЛОВНЫЕ УБОРЫ
	"H_Bandanna_mcamo",					//Bandanna (MTP)
	"H_BandMask_blk",					//Bandanna Mask (Black)
	"H_BandMask_demon",					//Bandanna Mask (Demon)
	"H_BandMask_khk",					//Bandanna Mask (Khaki)
	"H_BandMask_reaper",				//Bandanna Mask (Reaper)
	"H_Beret_02",						//Beret [NATO]
	"H_Beret_Colonel",					//Beret [NATO] (Colonel)
	"H_Booniehat_dgtl",					//Booniehat [AAF]
	"H_Booniehat_indp",					//Booniehat (Khaki)
	"H_Booniehat_mcamo",				//Booniehat (MTP)
	"H_Cap_blk_Raven",					//Cap [AAF]
	"H_Cap_khaki_specops_UK",			//Cap (UK)
	"H_Cap_tan_specops_US",				//Cap (US MTP)
	"H_Cap_usblack",					//Cap (US Black)
	"H_CrewHelmetHeli_B",				//Heli Crew Helmet [NATO]
	"H_CrewHelmetHeli_I",				//Heli Crew Helmet [AAF]
	"H_Helmet_Kerry",					//Combat Helmet (Kerry)
	"H_HelmetB",						//ECH
	"H_HelmetB_black",					//ECH (Black)
	"H_HelmetB_camo",					//ECH (Camo)
	"H_HelmetB_desert",					//ECH (Desert)
	"H_HelmetB_grass",					//ECH (Grass)
	"H_HelmetB_light",					//ECH (Light)
	"H_HelmetB_light_black",			//ECH (Light, Black)
	"H_HelmetB_light_desert",			//ECH (Light, Desert)
	"H_HelmetB_light_grass",			//ECH (Light, Grass)
	"H_HelmetB_light_sand",				//ECH (Light, Sand)
	"H_HelmetB_light_snakeskin",		//ECH (Light, Snakeskin)
	"H_HelmetB_paint",					//ECH (Spraypaint)
	"H_HelmetB_plain_blk",				//Combat Helmet (Black)
	"H_HelmetB_plain_mcamo",			//Combat Helmet (Camo)
	"H_HelmetB_sand",					//ECH (Sand)
	"H_HelmetB_snakeskin",				//ECH (Snakeskin)
	"H_HelmetCrew_B",					//Crew Helmet
	"H_HelmetCrew_I",					//Crew Helmet [AAF]
	"H_HelmetIA",						//MICH
	"H_HelmetIA_camo",					//MICH2 (Camo)
	"H_HelmetIA_net",					//MICH (Camo)
	"H_HelmetSpecB",					//SF Helmet
	"H_HelmetSpecB_blk",				//SF Helmet (Black)
	"H_HelmetSpecB_paint1",				//SF Helmet (Light paint)
	"H_HelmetSpecB_paint2",				//SF Helmet (Dark paint)
	"H_MilCap_dgtl",					//Military Cap [AAF]
	"H_MilCap_mcamo",					//Military Cap (MTP)
	"H_PilotHelmetFighter_B",			//Pilot Helmet [NATO]
	"H_PilotHelmetFighter_I",			//Pilot Helmet [AAF]
	"H_PilotHelmetHeli_B",				//Heli Pilot Helmet [NATO]
	"H_PilotHelmetHeli_I",				//Heli Pilot Helmet [AAF]
	"H_RacingHelmet_1_black_F",			//Racing Helmet (Black)
	"H_RacingHelmet_1_blue_F",			//Racing Helmet (Blue)
	"H_RacingHelmet_1_F",				//Racing Helmet (Fuel)
	"H_RacingHelmet_1_green_F",			//Racing Helmet (Green)
	"H_RacingHelmet_1_orange_F",		//Racing Helmet (Orange)
	"H_RacingHelmet_1_red_F",			//Racing Helmet (Red)
	"H_RacingHelmet_1_white_F",			//Racing Helmet (White)
	"H_RacingHelmet_1_yellow_F",		//Racing Helmet (Yellow)
	"H_RacingHelmet_2_F",				//Racing Helmet (Bluking)
	"H_RacingHelmet_3_F",				//Racing Helmet (Redstone)
	"H_RacingHelmet_4_F",				//Racing Helmet (Vrana)
	"H_TurbanO_blk",					//Black Turban

	//---- ПРЕДМЕТЫ
	"B_UavTerminal",					//UAV Terminal
	"I_UavTerminal",					//UAV Terminal

	//---- ОПТИКА
	"optic_Nightstalker",				//Nightstalker
	"optic_tws",						//TWS
	"optic_tws_mg"						//TWS MG
];

//Goggles to remove from VAS
vas_r_glasses = [];