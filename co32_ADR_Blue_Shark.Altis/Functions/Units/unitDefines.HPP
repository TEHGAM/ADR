
/*
    Author: alganthe
    This file is where all the enemies and objects are going to be defined (the ones from the missions / SM) at least.
    Please keep the format of the defines as is, if a define is an array keep it an array.
*/

//------------------------------------ Main AO

// Vehicles
#define MRAPList ["O_T_MRAP_02_hmg_ghex_F", "O_T_MRAP_02_gmg_ghex_F", "O_T_LSV_02_armed_F"]
#define AAVehicleList ["O_T_APC_Tracked_02_AA_ghex_F"]
#define RandomVehicleList ["O_T_MBT_02_cannon_ghex_F", "O_T_APC_Tracked_02_cannon_ghex_F", "O_T_APC_Wheeled_02_rcws_ghex_F"]

// Urban groups related stuff
#define UrbanGroupsCFGPATH >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >>
#define UrbanGroupsList ["OIA_GuardSquad"]
#define UrbanUnits ["O_soldierU_A_F", "O_soldierU_AAR_F", "O_soldierU_AAA_F", "O_soldierU_AAT_F", "O_soldierU_AR_F", "O_soldierU_medic_F", "O_engineer_U_F", "O_soldierU_exp_F", "O_soldierU_GL_F", "O_Urban_HeavyGunner_F", "O_soldierU_M_F", "O_soldierU_AA_F", "O_soldierU_AT_F", "O_soldierU_repair_F", "O_soldierU_F", "O_soldierU_LAT_F", "O_Urban_Sharpshooter_F", "O_soldierU_SL_F", "O_soldierU_TL_F"]

// Infantry groups related stuff
#define InfantryGroupsCFGPATH >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >>
#define InfantryGroupList ["O_T_InfSquad", "O_T_InfSquad_Weapons", "O_T_InfTeam", "O_T_reconPatrol"]
#define AAGroupsList ["O_T_InfTeam_AA"]
#define ATGroupsList ["O_T_InfTeam_AT"]

// Buildings that are always going to be filled when present in the AO
#define MilitaryBuildings ["Land_Cargo_House_V1_F", "Land_Cargo_House_V2_F", "Land_Cargo_House_V3_F", "Land_Cargo_House_V4_F", "Land_Medevac_house_V1_F", "Land_Research_house_V1_F", "Land_Cargo_HQ_V1_F", "Land_Cargo_HQ_V2_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V4_F", "Land_Research_HQ_F", "Land_Medevac_HQ_V1_F", "Land_Cargo_Patrol_V1_F", "Land_Cargo_Patrol_V2_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F", "Land_Cargo_Tower_V4_F", "Land_i_Barracks_V1_F","Land_Barracks_01_dilapidated_F", "Land_Barracks_01_grey_F", "Land_i_Barracks_V2_F", "Land_PillboxBunker_01_big_F", "Land_PillboxBunker_01_hex_F", "Land_PillboxBunker_01_rectangle_F"]

//------------------------------------ Random stuff
#define AirReinforcementVehicleList ["O_Heli_Light_02_F"]
