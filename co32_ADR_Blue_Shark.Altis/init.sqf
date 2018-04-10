/*
Author: BACONMOP

Description:
	Things that may run on both server and client.
	Deprecated initialization file, still using until the below is correctly partitioned between server and client.
*/
missionActive = true;
enableSaving false;

Base_AA_Active = false;
Base_AA_Cooldown = false;
CVN_CIWS_Active = false;
CVN_CIWS_Cooldown = false;

jetspawnpos = 0;

//TK message
sendTKhintC = { 
	params["_killed"];
	hintC format ["%1, you just teamkilled %2, which is not allowed. You should apologize to %2.", name player, _killed];
};
TKArray = [];

//---------------------------------- Mission vars (for all clients)
derp_PARAM_AOSize = "AOSize" call BIS_fnc_getParamValue;
derp_PARAM_AntiAirAmount = "AntiAirAmount" call BIS_fnc_getParamValue;
derp_PARAM_MRAPAmount = "MRAPAmount" call BIS_fnc_getParamValue;
derp_PARAM_InfantryGroupsAmount = "InfantryGroupsAmount" call BIS_fnc_getParamValue;
derp_PARAM_AAGroupsAmount = "AAGroupsAmount" call BIS_fnc_getParamValue;
derp_PARAM_ATGroupsAmount = "ATGroupsAmount" call BIS_fnc_getParamValue;
derp_PARAM_RandomVehcsAmount = "RandomVehcsAmount" call BIS_fnc_getParamValue;

derp_PARAM_AIAimingAccuracy = "AIAimingAccuracy" call BIS_fnc_getParamValue;
derp_PARAM_AIAimingShake = "AIAimingShake" call BIS_fnc_getParamValue;
derp_PARAM_AIAimingSpeed = "AIAimingSpeed" call BIS_fnc_getParamValue;
derp_PARAM_AISpotingDistance = "AISpotingDistance" call BIS_fnc_getParamValue;
derp_PARAM_AISpottingSpeed = "AISpottingSpeed" call BIS_fnc_getParamValue;
derp_PARAM_AICourage = "AICourage" call BIS_fnc_getParamValue;
derp_PARAM_AIReloadSpeed = "AIReloadSpeed" call BIS_fnc_getParamValue;
derp_PARAM_AICommandingSkill = "AICommandingSkill" call BIS_fnc_getParamValue;
derp_PARAM_AIGeneralSkill = "AIGeneralSkill" call BIS_fnc_getParamValue;

//Dynamic groups
["Initialize"] call BIS_fnc_dynamicGroups;

//params
for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

//Ares/achilles stuff:
If (local player) then{
    missionNamespace setVariable ['Ares_Allow_Zeus_To_Execute_Code', false];
};

/*VCOM AI settings*/

//Enable or disable the INGAME setting menu. This is off by default due to compatability issues with multiple mods and scripts. And I am tired of hearing people complain all the time :D 
VCOM_AIINGAMEMENU = false;	
//Variable for enabling/disabling skill changes for AI. True is on, False is off.
VCOM_AISkillEnabled = true;
//Variable for finding out which config was loaded.
//VCOM_AIConfig = "Userconfig Folder";
//Turn this on to see certain debug messages. 1 is on
VCOM_AIDEBUG = 0;
//Turn on map markers that track AI movement
VCOM_UseMarkers = false;
//Turns off VCOMAI for AI units in a players squad
NOAI_FOR_PLAYERLEADERS = 1;
//Will AI garrison static weapons nearby?
VCOM_STATICGARRISON = 1;
//How far can the AI hear gunshots from?
VCOM_HEARINGDISTANCE = 500;
//Should AI be able to call for artillery. 1 = YES 0 = NO
VCOM_Artillery = 0;
//What should the dispersion be for AI artillery rounds? In meters.
VCOM_ArtillerySpread = 600;
//What is the delay between firing artillery rounds? In seconds.
VCOM_ArtilleryCooldown = 300;
//Should we let AI use flanking manuevers? false means they can flank
VCOM_NOPATHING = false;
//Should AI use smoke grenades? Besides default A3 behavior?
VCOM_USESMOKE = true;
//Chance of AI using grenades
VCOM_GRENADECHANCE = 30;
//Should the AI lay mines?
VCOM_MineLaying = false;
//Chance of AI to lay a mine.
VCOM_MineLayChance = 40;
//AI will automatically disembark from vehicles when in combat.
VCOM_AIDisembark = true;
//How low should an AI's mag count be for them to consider finding more ammo? This DOES NOT include the mag loaded in the gun already.
VCOM_AIMagLimit = 2;
//Should the rain impact accuracy of AI? DEFAULT = true;
VCOM_RainImpact = true;
//How much should rain impact the accuracy of AI? Default = 3. Default formula is -> _WeatherCheck = (rain)/3; "rain" is on a scale from 0 to 1. 1 Being very intense rain.
VCOM_RainPercent = 3;
//Should AI and players have an additional layer of suppression that decreases aiming when suppressed? Default = true;
VCOM_Suppression = true;
//How much should suppression impact both AI and player aiming? Default is 5. Normal ArmA is 1.
VCOM_SuppressionVar = 5;
//Should AI/players be impacted by adrenaline? This provides players and AI with a small speed boost to animations to assist with cover seeking and positioning for a short time. Default = true;
VCOM_Adrenaline = true;
//How much of a speed boost should players/AI recieve? Default = 1.15; (1 is ArmA's normal speed).
VCOM_AdrenalineVar = 1.15;
//How many AI UNITS can be calculating cover positions at once?
VCOM_CurrentlyMovingLimit = 6;
//How many AI UNITS can be suppressing others at once?
VCOM_CurrentlySuppressingLimit = 12;
//The distance a unit needs to be away for Vcom AI to temporary disable itself upon the unit? The AI unit will also need to be out of combat.
VCOM_DisableDistance = 2000;
//How many AI can be checking roles/equipment/additional commands at once? This will impact FPS of AI in and out of battle. The goal is to limit how many benign commands are being run at once and bogging down a server with over a couple HUNDRED AI.
VCOM_BasicCheckLimit = 20;
//How many squad leaders can be executing advanced code at once.
VCOM_LeaderExecuteLimit = 10;
//How low should the FPS be, before Vcom pauses simulation. This will not disable simulation on AI - they will run default Bohemia AI.
VCOM_FPSFreeze = 10;
//Should the AI consider stealing/using empty ground vehicles?
VCOM_VehicleUse = false;
//Should the AI notice IR lasers?
VCOM_IRLaser = true;
//The distance, in meters, of how far AI will look for empty unlocked vehicles to steal.
VCOM_AIDISTANCEVEHPATH = 0;


//The longer an AI's target stays in 1 location, the more accurate and aware of the target the AI becomes.DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
VCOM_IncreasingAccuracy = true;
//VCOM_SideBasedMovement- Remove sides from the array below to force that specific AI side to not execute any advance movement code. (I.E. Moving to reinforce allies, being alerted by distant gunshots and etc). AI with this will still react normally in combat. DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
VCOM_SideBasedMovement = [WEST,EAST,RESISTANCE];
//VCOM_SideBasedExecution- Remove sides from the array below to remove that specific AI side from executing any of the VCOMAI scripts at all. DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
VCOM_SideBasedExecution = [WEST,EAST,RESISTANCE];
//Distance AI will respond to call of help from each other
VCOM_Unit_AIWarnDistance = 1000;
//Distance the AI will attempt to flank around the enemy. I.E. How far off a waypoint, or around the enemy squad, the AI are willing to go in combat.
VCOM_WaypointDistance = 300;
//Switching this to true will enable side specific skill settings. Side specific skills get added IN ADDITION TO the normal ranked skill.
VCOM_SIDESPECIFIC = false;
//Switching this to true will enable classname specific skill settings. VCOM_SIDESPECIFIC and VCOM_CLASSNAMESPECIFIC can both be true, however any units in the VCOM_CLASSNAMESPECIFIC array are given priority over everything else.
VCOM_CLASSNAMESPECIFIC = false; 
//Here you can assign certain unit classnames to specific skill levels. This will override the AI skill level above.
VCOM_SKILL_CLASSNAMES = []; 
/*
EXAMPLE FOR VCOM_SKILL_CLASSNAMES

VCOM_SKILL_CLASSNAMES = [["Classname1",[aimingaccuracy,aimingshake,spotdistance,spottime,courage,commanding,aimingspeed,general,endurance,reloadspeed]],["Classname2",[aimingaccuracy,aimingshake,spotdistance,spottime,courage,commanding,aimingspeed,general,endurance,reloadspeed]]];
VCOM_SKILL_CLASSNAMES = [["B_Crew_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]],["B_soldier_AAT_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]]]; 
VCOM_SKILL_CLASSNAMES = [["B_GEN_Soldier_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]],["B_G_Soldier_AR_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]]]; 
*/
