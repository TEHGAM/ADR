/*
@filename: enemyInd.hpp
Author:

	BACONMOP

Description:
	Units, vehicles and groups, for use elsewhere in the mission.
	Also allows greater control over what is being spawned, and where, yet allows for random composition groups.

	Sentry = 2-man
	Team = 4-man
	Squad = 8-man
__________________________________________________*/

class paraMil {
    class Groups {
        class atSquad {
            class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_C_Soldier_Para_2_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Para_5_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "I_C_Soldier_Para_5_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Para_1_F";
            };
        };
    };
	class aaSquad {
		class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_C_Soldier_Para_2_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_Soldier_AA_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "I_Soldier_AA_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Para_1_F";
            };
		};
	class mgSquad {
		class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_C_Soldier_Para_2_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Para_4_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "I_C_Soldier_Para_4_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Para_6_F";
            };
		};
	units[] = {
		"I_C_Soldier_Para_7_F",
		"I_C_Soldier_Para_2_F",
		"I_C_Soldier_Para_3_F",
		"I_C_Soldier_Para_3_F",
		"I_C_Soldier_Para_4_F",
		"I_C_Soldier_Para_6_F",
		"I_C_Soldier_Para_8_F",
		"I_C_Soldier_Para_1_F",
		"I_C_Soldier_Para_5_F"
	};
	helicopters[] = {
		"I_Heli_Transport_02_F",
		"I_Heli_light_03_F",
		"I_Heli_light_03_unarmed_F"
	};
	planes[] = {
		"I_Plane_Fighter_03_AA_F",
		"I_Plane_Fighter_03_CAS_F"
	};
	AAvic[] = {
		"I_G_Offroad_01_armed_F"
	};
	APCs[] = {
		"I_APC_Wheeled_03_cannon_F"
	};
	tanks[] = {
		"I_APC_tracked_03_cannon_F"
	};
	arty[] = {
		"I_G_Mortar_01_F"
	};
	cars[] = {
		"I_C_Offroad_02_unarmed_F",
		"I_C_Van_01_transport_F",
		"I_G_Offroad_01_armed_F",
		"I_G_Offroad_01_F",
		"I_G_Offroad_01_repair_F",
		"I_G_Quadbike_01_F"
	};
	boats[] = {
		"I_C_Boat_Transport_01_F",
		"I_C_Boat_Transport_02_F"
	};
	turrets[] = {
		"I_HMG_01_F",
		"I_HMG_01_high_F",
		"I_GMG_01_F",
		"I_GMG_01_high_F"
	};
	drones[] = {

	};
	divers[] = {

	};
	specialForces[] = {

	};
};

class bandits {
	class Groups {
		class atSquad {
            class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_4_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_2_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_2_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_8_F";
            };
        };
		class aaSquad {
            class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_4_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_Soldier_AA_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "I_Soldier_AA_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_7_F";
            };
        };
		class mgSquad {
            class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_4_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_3_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_3_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_C_Soldier_Bandit_6_F";
            };
        };
	};
	units[] = {
		"I_C_Soldier_Bandit_7_F",
		"I_C_Soldier_Bandit_3_F",
		"I_C_Soldier_Bandit_2_F",
		"I_C_Pilot_F",
		"I_C_Soldier_Bandit_5_F",
		"I_C_Soldier_Bandit_6_F",
		"I_C_Soldier_Bandit_1_F",
		"I_C_Soldier_Bandit_8_F",
		"I_C_Soldier_Bandit_4_F"
	};
	helicopters[] = {
		"I_C_Heli_Light_01_civil_F"
	};
	planes[] = {
		"I_Plane_Fighter_03_AA_F",
		"I_Plane_Fighter_03_CAS_F"
	};
	AAvic[] = {
		"I_G_Offroad_01_armed_F"
	};
	APCs[] = {
		"I_APC_Wheeled_03_cannon_F"
	};
	tanks[] = {
		"I_APC_tracked_03_cannon_F"
	};
	arty[] = {
		"I_G_Mortar_01_F"
	};
	cars[] = {
		"I_C_Offroad_02_unarmed_F",
		"I_C_Van_01_transport_F",
		"I_G_Offroad_01_armed_F",
		"I_G_Offroad_01_F",
		"I_G_Offroad_01_repair_F",
		"I_G_Quadbike_01_F"
	};
	boats[] = {
		"I_C_Boat_Transport_01_F",
		"I_C_Boat_Transport_02_F"
	};
	turrets[] = {
		"I_HMG_01_F",
	};
	drones[] = {

	};
	divers[] = {

	};
	specialForces[] = {

	};
};

class FIAIndep {
	class Groups {
		class atSquad {
            class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_G_Soldier_TL_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_Soldier_LAT_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "I_G_Soldier_LAT_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_Soldier_F";
            };
        };
		class aaSquad {
            class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_G_Soldier_SL_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_Soldier_AA_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "I_Soldier_AA_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_Soldier_F";
            };
        };
		class mgSquad {
            class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_G_Soldier_SL_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_Soldier_AR_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "CORPORAL";
                side = 2;
                vehicle = "I_G_Soldier_AR_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_Soldier_A_F";
            };
        };
		class InfSquad {
            class Unit0 {
                position[] = {0,0,0};
                rank = "SERGEANT";
                side = 2;
                vehicle = "I_G_Soldier_SL_F";
            };
            class Unit1 {
                position[] = {5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_medic_F";
            };
            class Unit2 {
                position[] = {-5,-5,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_Soldier_AR_F";
            };
            class Unit3 {
                position[] = {10,-10,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_Soldier_A_F";
            };
			class Unit4 {
				position[] = {-10,-10,0};
				rank = "CORPORAL";
				side = 2;
				vehicle = "I_G_Soldier_TL_F";
			};
			class Unit5 {
                position[] = {15,-15,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_Sharpshooter_F";
            };
			class Unit6 {
                position[] = {-15,-15,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_engineer_F";
            };
			class Unit7 {
                position[] = {20,20,0};
                rank = "Private";
                side = 2;
                vehicle = "I_G_Soldier_LAT_F";
            };
        };
	};
	units[] = {
		"I_G_Soldier_A_F",
		"I_G_Soldier_AR_F",
		"I_G_medic_F",
		"I_G_engineer_F",
		"I_G_Soldier_exp_F",
		"I_G_Soldier_GL_F",
		"I_G_Soldier_M_F",
		"I_G_officer_F",
		"I_G_Soldier_F",
		"I_G_Soldier_LAT_F",
		"I_G_Soldier_lite_F",
		"I_G_Sharpshooter_F",
		"I_G_Soldier_SL_F",
		"I_G_Soldier_TL_F"
	};
	helicopters[] = {
		"I_Heli_Transport_02_F",
		"I_Heli_light_03_F",
		"I_Heli_light_03_unarmed_F"
	};
	planes[] = {
		"I_Plane_Fighter_03_AA_F",
		"I_Plane_Fighter_03_CAS_F"
	};
	AAvic[] = {
		"I_G_Offroad_01_armed_F"
	};
	APCs[] = {
		"I_APC_Wheeled_03_cannon_F"
	};
	tanks[] = {
		"I_APC_tracked_03_cannon_F"
	};
	arty[] = {
		"I_G_Mortar_01_F"
	};
	cars[] = {
		"I_C_Offroad_02_unarmed_F",
		"I_C_Van_01_transport_F",
		"I_G_Offroad_01_armed_F",
		"I_G_Offroad_01_F",
		"I_G_Offroad_01_repair_F",
		"I_G_Quadbike_01_F"
	};
	boats[] = {
		"I_C_Boat_Transport_01_F",
		"I_C_Boat_Transport_02_F"
	};
	turrets[] = {
		"I_HMG_01_F",
		"I_HMG_01_high_F",
		"I_GMG_01_F",
		"I_GMG_01_high_F"
	};
	drones[] = {

	};
	divers[] = {

	};
	specialForces[] = {

	};
};

class AAF {
	units[] = {
		"I_Soldier_A_F",
		"I_Soldier_AAR_F",
		"I_Soldier_AAA_F",
		"I_Soldier_AAT_F",
		"I_Soldier_AR_F",
		"I_medic_F",
		"I_engineer_F",
		"I_Soldier_exp_F",
		"I_Soldier_GL_F",
		"I_Soldier_M_F",
		"I_Soldier_AA_F",
		"I_Soldier_AT_F",
		"I_officer_F",
		"I_Soldier_repair_F",
		"I_soldier_F",
		"I_Soldier_LAT_F",
		"I_Soldier_lite_F",
		"I_Soldier_SL_F",
		"I_Soldier_TL_F"
	};
	helicopters[] = {
		"I_Heli_Transport_02_F",
		"I_Heli_light_03_F",
		"I_Heli_light_03_unarmed_F"
	};
	planes[] = {
		"I_Plane_Fighter_03_AA_F",
		"I_Plane_Fighter_03_CAS_F"
	};
	AAvic[] = {
		"I_G_Offroad_01_armed_F",
		"I_APC_Wheeled_03_cannon_F"
	};
	APCs[] = {
		"I_APC_Wheeled_03_cannon_F",
		"I_APC_tracked_03_cannon_F"
	};
	tanks[] = {
		"I_MBT_03_cannon_F"
	};
	arty[] = {
		"I_G_Mortar_01_F"
	};
	cars[] = {
		"I_C_Offroad_02_unarmed_F",
		"I_G_Offroad_01_armed_F",
		"I_G_Offroad_01_F",
		"I_G_Offroad_01_repair_F",
		"I_MRAP_03_gmg_F",
		"I_MRAP_03_F",
		"I_MRAP_03_hmg_F",
		"I_Truck_02_transport_F",
		"I_Truck_02_covered_F"
	};
	boats[] = {
		"I_C_Boat_Transport_01_F",
		"I_C_Boat_Transport_02_F",
		"I_Boat_Armed_01_minigun_F"
	};
	turrets[] = {
		"I_HMG_01_F",
		"I_HMG_01_high_F",
		"I_GMG_01_F",
		"I_GMG_01_high_F",
		"I_static_AA_F",
		"I_static_AT_F"
	};
	drones[] = {
	"I_UAV_02_F",
	"I_UAV_02_CAS_F"
	};
	divers[] = {
	"I_diver_F",
	"I_diver_exp_F",
	"I_diver_exp_F",
	"I_diver_TL_F"
	};
	specialForces[] = {

	};
};

class CSAT{
	units[] = {
		"O_Soldier_A_F",
		"O_Soldier_AAR_F",
		"O_medic_F",
		"O_crew_F",
		"O_engineer_F",
		"O_soldier_exp_F",
		"O_HeavyGunner_F",
		"O_soldier_M_F",
		"O_Soldier_AA_F",
		"O_Soldier_AT_F",
		"O_officer_F",
		"O_soldier_repair_F",
		"O_Soldier_F",
		"O_Soldier_LAT_F",
		"O_Soldier_lite_F",
		"O_Sharpshooter_F",
		"O_Soldier_SL_F",
		"O_Soldier_TL_F",
		"O_Soldier_AR_F",
		"O_Soldier_GL_F"
	};
	helicopters[] = {
		"O_Heli_Transport_04_bench_F",
		"O_Heli_Transport_04_covered_F",
		"O_Heli_Attack_02_F",
		"O_Heli_Attack_02_black_F",
		"O_Heli_Light_02_F",
		"O_Heli_Light_02_v2_F",
		"O_Heli_Light_02_unarmed_F"
	};
	planes[] = {
		"O_Plane_CAS_02_F",
		"O_T_VTOL_02_infantry_F"
	};
	AAvic[] = {
		"O_APC_Tracked_02_AA_F"
	};
	APCs[] = {
		"O_APC_Tracked_02_cannon_F",
		"O_APC_Wheeled_02_rcws_F"
	};
	tanks[] = {
		"O_MBT_02_cannon_F"
	};
	arty[] = {
		"O_MBT_02_arty_F"
	};
	cars[] = {
		"O_MRAP_02_hmg_F",
		"O_MRAP_02_gmg_F",
		"O_MRAP_02_F",
		"O_LSV_02_armed_F",
		"O_Truck_03_transport_F",
		"O_Truck_03_covered_F"
	};
	boats[] = {
		"O_Boat_Armed_01_hmg_F"
	};
	turrets[] = {
		"O_HMG_01_F",
		"O_HMG_01_high_F",
		"O_GMG_01_F",
		"O_GMG_01_high_F",
		"O_static_AA_F",
		"O_static_AT_F"
	};
	drones[] = {
	"O_UAV_02_F",
	"O_UAV_02_CAS_F"
	};
	divers[] = {
	"O_diver_F",
	"O_diver_exp_F",
	"O_diver_TL_F"
	};
	specialForces[] = {
	"O_recon_TL_F",
	"O_recon_LAT_F",
	"O_recon_F",
	"O_Pathfinder_F",
	"O_recon_medic_F",
	"O_recon_M_F",
	"O_recon_JTAC_F",
	"O_recon_exp_F"
	};
};

class CSATTropic {
	units[] = {
		"O_T_Soldier_A_F",
		"O_T_Soldier_AAR_F",
		"O_T_Soldier_AR_F",
		"O_T_Medic_F",
		"O_T_Engineer_F",
		"O_T_Soldier_Exp_F",
		"O_T_Soldier_GL_F",
		"O_T_Soldier_M_F",
		"O_T_Soldier_AA_F",
		"O_T_Soldier_AT_F",
		"O_T_Officer_F",
		"O_T_Soldier_Repair_F",
		"O_T_Soldier_F",
		"O_T_Soldier_LAT_F",
		"O_T_Soldier_TL_F"
	};
	helicopters[] = {
		"O_Heli_Transport_04_bench_F",
		"O_Heli_Transport_04_covered_F",
		"O_Heli_Attack_02_F",
		"O_Heli_Attack_02_black_F",
		"O_Heli_Light_02_F",
		"O_Heli_Light_02_v2_F",
		"O_Heli_Light_02_unarmed_F"
	};
	planes[] = {
		"O_Plane_CAS_02_F",
		"O_T_VTOL_02_infantry_F"
	};
	AAvic[] = {
		"O_T_APC_Tracked_02_AA_ghex_F"
	};
	APCs[] = {
		"O_T_APC_Tracked_02_cannon_ghex_F",
		"O_T_APC_Wheeled_02_rcws_ghex_F"
	};
	tanks[] = {
		"O_T_MBT_02_cannon_ghex_F"
	};
	arty[] = {
		"O_T_MBT_02_arty_ghex_F"
	};
	cars[] = {
		"O_T_MRAP_02_ghex_F",
		"O_T_MRAP_02_gmg_ghex_F",
		"O_T_MRAP_02_hmg_ghex_F",
		"O_T_LSV_02_armed_F",
		"O_T_Truck_03_transport_ghex_F",
		"O_T_Truck_03_covered_ghex_F"
	};
	boats[] = {
		"O_T_Boat_Armed_01_hmg_F",
		"O_T_Boat_Transport_01_F"
	};
	turrets[] = {
		"O_HMG_01_F",
		"O_HMG_01_high_F",
		"O_GMG_01_F",
		"O_GMG_01_high_F",
		"O_static_AA_F",
		"O_static_AT_F"
	};
	drones[] = {
	"O_T_UAV_04_CAS_F"
	};
	divers[] = {
	"O_T_Diver_TL_F",
	"O_T_Diver_Exp_F",
	"O_T_Diver_F"
	};
	specialForces[] = {
	"O_V_Soldier_TL_ghex_F",
	"O_V_Soldier_Medic_ghex_F",
	"O_V_Soldier_LAT_ghex_F",
	"O_V_Soldier_ghex_F",
	"O_V_Soldier_M_ghex_F",
	"O_V_Soldier_JTAC_ghex_F",
	"O_V_Soldier_Exp_ghex_F"
	};
};

class FIAOpfor {
	units[] = {
		"O_G_Soldier_A_F",
		"O_G_Soldier_AR_F",
		"O_G_medic_F",
		"O_G_engineer_F",
		"O_G_Soldier_exp_F",
		"O_G_Soldier_GL_F",
		"O_G_Soldier_M_F",
		"O_G_officer_F",
		"O_G_Soldier_F",
		"O_G_Soldier_LAT_F",
		"O_G_Soldier_lite_F",
		"O_G_Sharpshooter_F",
		"O_G_Soldier_SL_F",
		"O_G_Soldier_TL_F"
	};
	helicopters[] = {
		"O_Heli_Transport_04_covered_F",
		"O_Heli_Light_02_F",
		"O_Heli_Light_02_v2_F",
		"O_Heli_Light_02_unarmed_F"
	};
	planes[] = {
	};
	AAvic[] = {
		"O_G_Offroad_01_armed_F"
	};
	APCs[] = {

		"O_APC_Wheeled_02_rcws_F",
		"O_G_Offroad_01_armed_F"
	};
	tanks[] = {
		"O_APC_Tracked_02_cannon_F"
	};
	arty[] = {
		"O_Mortar_01_F"
	};
	cars[] = {
		"O_G_Van_01_transport_F",
		"O_G_Offroad_01_armed_F",
		"O_G_Offroad_01_F",
		"O_LSV_02_armed_F",
		"I_C_Offroad_02_unarmed_F",
	};
	boats[] = {
		"O_Boat_Armed_01_hmg_F"
	};
	turrets[] = {
		"O_HMG_01_F",
		"O_HMG_01_high_F",
		"O_GMG_01_F",
		"O_GMG_01_high_F"
	};
	drones[] = {

	};
	divers[] = {

	};
	specialForces[] = {

	};
};

class NATO {
	units[] = {
		"B_Soldier_A_F",
		"B_soldier_AAR_F",
		"B_soldier_AR_F",
		"B_medic_F",
		"B_soldier_exp_F",
		"B_Soldier_GL_F",
		"B_HeavyGunner_F",
		"B_soldier_M_F",
		"B_soldier_AA_F",
		"B_soldier_AT_F",
		"B_Soldier_F",
		"B_soldier_LAT_F",
		"B_Soldier_lite_F",
		"B_Sharpshooter_F",
		"B_Soldier_SL_F",
		"B_Soldier_TL_F",
		"B_officer_F",
		"B_soldier_repair_F"
	};
	helicopters[] = {
		"B_CTRG_Heli_Transport_01_sand_F",
		"B_CTRG_Heli_Transport_01_tropic_F",
		"B_Heli_Transport_03_F",
		"B_Heli_Transport_03_unarmed_F",
		"B_Heli_Light_01_F",
		"B_Heli_Transport_01_F",
		"B_Heli_Transport_01_camo_F"
	};
	drones[] = {
	"B_UAV_02_F",
	"B_UAV_02_CAS_F"
	};
	divers[] = {
	"B_diver_TL_F",
	"B_diver_exp_F",
	"B_diver_F"
	};
	specialForces[] = {
	"B_recon_TL_F",
	"B_Recon_Sharpshooter_F",
	"B_recon_LAT_F",
	"B_recon_F",
	"B_recon_medic_F",
	"B_recon_M_F",
	"B_recon_JTAC_F",
	"B_recon_exp_F"
	};
};

class NATOTropic {
	units[] = {
		"B_T_Soldier_A_F",
		"B_T_Soldier_AR_F",
		"B_T_Medic_F",
		"B_T_Engineer_F",
		"B_T_Soldier_AAR_F",
		"B_T_Crew_F",
		"B_T_Soldier_Exp_F",
		"B_T_Soldier_GL_F",
		"B_T_soldier_M_F",
		"B_T_Soldier_AT_F",
		"B_T_Officer_F",
		"B_T_Soldier_Repair_F",
		"B_T_Soldier_F",
		"B_T_Soldier_LAT_F",
		"B_T_Soldier_SL_F",
		"B_T_Soldier_TL_F",
		"B_T_Soldier_AA_F"
	};
	drones[] = {
		"B_T_UAV_03_F"
	};
	divers[] = {
	"B_T_Diver_TL_F",
	"B_T_Diver_Exp_F",
	"B_T_Diver_F"
	};
	specialForces[] = {
	"B_T_Recon_TL_F",
	"B_T_Recon_LAT_F",
	"B_T_Recon_F",
	"B_T_Recon_Medic_F",
	"B_T_Recon_M_F",
	"B_T_Recon_JTAC_F",
	"B_T_Recon_Exp_F"
	};
	helicopters[] = {
		"B_CTRG_Heli_Transport_01_sand_F",
		"B_CTRG_Heli_Transport_01_tropic_F",
		"B_Heli_Transport_03_F",
		"B_Heli_Transport_03_unarmed_F",
		"B_Heli_Light_01_F",
		"B_Heli_Transport_01_F",
		"B_Heli_Transport_01_camo_F"
	};
};

class FIABlufor {
	units[] = {
		"B_G_Soldier_A_F,",
		"B_G_Soldier_AR_F",
		"B_G_medic_F",
		"B_G_engineer_F",
		"B_G_Soldier_GL_F",
		"B_G_officer_F",
		"B_G_Soldier_F",
		"B_G_Soldier_LAT_F",
		"B_G_Soldier_lite_F",
		"B_G_Sharpshooter_F",
		"B_G_Soldier_SL_F",
		"B_G_Soldier_TL_F",
		"B_G_Soldier_exp_F",
		"B_G_Soldier_M_F"
	};
	helicopters[] = {
		"B_Heli_Light_01_F",
		"B_Heli_Transport_01_F",
		"B_Heli_Transport_01_camo_F"
	};
	drones[] = {

	};
	divers[] = {
	
	};
	specialForces[] = {
	
	};
};

class CTRG {
	units[] = {
		"B_CTRG_Soldier_AR_tna_F",
		"B_CTRG_Soldier_Exp_tna_F",
		"B_CTRG_Soldier_JTAC_tna_F",
		"B_CTRG_Soldier_M_tna_F",
		"B_CTRG_Soldier_Medic_tna_F",
		"B_CTRG_Soldier_tna_F",
		"B_CTRG_Soldier_LAT_tna_F",
		"B_CTRG_Soldier_TL_tna_F"
	};
	helicopters[] = {
		"B_CTRG_Heli_Transport_01_sand_F",
		"B_CTRG_Heli_Transport_01_tropic_F",
		"B_Heli_Transport_03_F",
		"B_Heli_Transport_03_unarmed_F",
		"B_Heli_Light_01_F",
		"B_Heli_Transport_01_F",
		"B_Heli_Transport_01_camo_F"
	};
	drones[] = {

	};
	divers[] = {

	};
	specialForces[] = {

	};
};

class Gendarmerie {
	units[] = {
		"B_GEN_Commander_F",
		"B_GEN_Soldier_F"
	};
	helicopters[] = {
		"B_Heli_Light_01_F"
	};
	cars[] = {
		"B_GEN_Offroad_01_gen_F"
	};
};

class specialVics {
	trucks[] = {
		{"B_G_Offroad_01_repair_F", "B_Mortar_01_F",[0,-2.5,.3]}, 			//Mobile Mortar Truck
		{"B_G_Offroad_01_repair_F", "B_GMG_01_high_F", [0,-2.5,.8]}			//Offroad (Armed GMG)
	};
	helicopters[] = {
		{"B_Heli_Light_01_armed_F","HMG_127_APC","500Rnd_127x99_mag_Tracer_Red","5000Rnd_762x51_Belt","M134_minigun"}, 					//Pawnee GAU - 19 [heli, add weap, add ammo, remove old weap, remove old ammo]
		{"B_Heli_Light_01_armed_F","GMG_20mm","40Rnd_20mm_G_belt","5000Rnd_762x51_Belt","M134_minigun"} 								//Pawnee GMG - 20MM [heli, add weap, add ammo, remove old weap, remove old ammo]
	};
};
