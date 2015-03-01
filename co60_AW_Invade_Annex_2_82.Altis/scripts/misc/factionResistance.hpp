/*
@filename: enemyInd.hpp
Author:

	Quiksilver
	
Description:
	INDEPENDENT
	Units, vehicles and groups, for use elsewhere in the mission.
	Doing this alleviates the need to dig through configFile, which eats more server CPU.
	Also allows greater control over what is being spawned, and where, yet allows for random composition groups.
	
	Sentry = 2-man
	Team = 4-man
	Squad = 8-man
__________________________________________________*/

class ind {
	units[] = {
		"I_Soldier_A_F",
		"I_Soldier_AR_F",
		"I_medic_F",
		"I_engineer_F",
		"I_Soldier_exp_F",
		"I_Soldier_GL_F",
		"I_Soldier_M_F",
		"I_Soldier_AA_F",
		"I_Soldier_AT_F",
		"I_Soldier_repair_F",
		"I_soldier_F",
		"I_Soldier_LAT_F",
		"I_Soldier_lite_F",
		"I_Soldier_SL_F",
		"I_Soldier_TL_F"
	};
};
