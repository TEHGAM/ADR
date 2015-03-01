//Allow player to respawn with his loadout? If true unit will respawn with all ammo from initial save! Set to false to disable this and rely on other scripts!
vas_onRespawn = false;
//Preload Weapon Config?
vas_preload = true;
//If limiting weapons its probably best to set this to true so people aren't loading custom loadouts with restricted gear.
vas_disableLoadSave = false;
//Amount of save/load slots
vas_customslots = 19; //9 is actually 10 slots, starts from 0 to whatever you set, so always remember when setting a number to minus by 1, i.e 12 will be 11.
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
vas_r_weapons = [];
//Backpacks to remove from VAS
vas_r_backpacks = [
	"O_Mortar_01_support_F",
	"I_Mortar_01_support_F",
	"O_Mortar_01_weapon_F",
	"I_Mortar_01_weapon_F",
	"O_UAV_01_backpack_F",
	"I_UAV_01_backpack_F",
	"O_HMG_01_support_F",
	"I_HMG_01_support_F",
	"O_HMG_01_support_high_F",
	"I_HMG_01_support_high_F",
 	"O_HMG_01_weapon_F",
 	"I_HMG_01_weapon_F",
 	//"B_HMG_01_A_weapon_F",
 	"O_HMG_01_A_weapon_F",
 	"I_HMG_01_A_weapon_F",
  	"O_GMG_01_weapon_F",
  	"I_GMG_01_weapon_F",
  	//"B_GMG_01_A_weapon_F",
  	"O_GMG_01_A_weapon_F",
  	"I_GMG_01_A_weapon_F",
   	"O_HMG_01_high_weapon_F",
  	"I_HMG_01_high_weapon_F",
   	//"B_HMG_01_A_high_weapon_F",
   	"O_HMG_01_A_high_weapon_F",
   	"I_HMG_01_A_high_weapon_F",
   	"O_GMG_01_high_weapon_F",
   	"I_GMG_01_high_weapon_F",
   	//"B_GMG_01_A_high_weapon_F",
   	"O_GMG_01_A_high_weapon_F",
   	"I_GMG_01_A_high_weapon_F",
	"I_AT_01_weapon_F",
	"O_AT_01_weapon_F",
	"I_AA_01_weapon_F",
	"O_AA_01_weapon_F"
];

//Magazines to remove from VAS
vas_r_magazines = [];

//Items to remove from VAS
vas_r_items = [
	"I_UavTerminal",
	"O_UavTerminal",
	"U_C_Commoner1_1",
	"U_C_Commoner1_2",
	"U_C_Commoner1_3",
	"U_C_Commoner1_4",
	"U_C_Commoner1_5",
	"U_C_Commoner1_6",
	"U_C_Commoner2_1",
	"U_C_Commoner2_2",
	"U_C_Commoner2_3",
	"U_C_Commoner2_4",
	"U_C_Commoner2_5",
	"U_C_Commoner2_6",
	"U_I_GhillieSuit",
	"U_O_GhillieSuit",
	"U_I_Wetsuit",
	"U_O_Wetsuit",
	"U_NikosBody",
	"U_OrestesBody",
	"U_AttisBody",
	"U_AntigonaBody",
	"U_IG_Menelaos",
	"U_C_Novak",
	"U_OI_Scientist",
	"U_C_Poor_1",
	"U_C_Poor_2",
	"U_C_Scavenger_1",
	"U_C_Scavenger_2",
	"U_C_Farmer",
	"U_C_Fisherman",
	"U_C_WorkerOveralls",
	"U_C_FishermanOveralls",
	"U_C_PriestBody",
	"U_C_Poor_shorts_1",
	"U_C_Poor_shorts_2",
	"U_C_Commoner_shorts",
	"U_C_HunterBody_brn",
	"U_O_CombatUniform_ocamo",
	"U_O_CombatUniform_oucamo",
	"U_O_SpecopsUniform_blk",
	"U_O_SpecopsUniform_ocamo",
	"U_O_OfficerUniform_ocamo",
	"U_O_GhillieSuit",
	"U_O_PilotCoveralls",
	"U_O_Wetsuit",
	"U_I_CombatUniform",
	"U_I_CombatUniform_shortsleeve",
	"U_I_CombatUniform_tshirt",
	"U_I_OfficerUniform",
	"U_I_GhillieSuit",
	"U_I_HeliPilotCoveralls",
	"U_I_pilotCoveralls",
	"U_I_Wetsuit",
	"U_C_TeeSurfer_shorts_1",
	"U_C_TeeSurfer_shorts_2",
	"U_B_CombatUniform_sgg",
	"U_B_CombatUniform_sgg_tshirt",
	"U_B_CombatUniform_sgg_vest",
	"U_B_CombatUniform_wdl",
	"U_B_CombatUniform_wdl_tshirt",
	"U_B_CombatUniform_wdl_vest",
	"U_BasicBody"
];

//Goggles to remove from VAS
vas_r_glasses = [];