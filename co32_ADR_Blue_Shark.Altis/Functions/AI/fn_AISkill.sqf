/*
* Author: alganthe
* Set the mission parameter defined skill values for an array of units.
*
* Arguments:
* 0: Array of units to change <ARRAY>
*
* Return Value:
* NOTHING
*/
params ["_AIArray"];

{
    _x setSkill ["general", (derp_PARAM_AIGeneralSkill / 10)];
    _x setSkill ["aimingAccuracy", (derp_PARAM_AIAimingAccuracy / 10)];
    _x setSkill ["aimingShake", (derp_PARAM_AIAimingShake / 10)];
    _x setSkill ["aimingSpeed", (derp_PARAM_AIAimingSpeed / 10)];
    _x setSkill ["spotDistance", (derp_PARAM_AISpotingDistance / 10)];
    _x setSkill ["spotTime", (derp_PARAM_AISpottingSpeed / 10)];
    _x setSkill ["courage", (derp_PARAM_AICourage / 10)];
    _x setSkill ["reloadSpeed", (derp_PARAM_AIReloadSpeed / 10)];
    _x setSkill ["commanding", (derp_PARAM_AICommandingSkill / 10)];
} foreach _AIArray;
