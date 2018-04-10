/*
Author: BACONMOP
Description: for defining the faction
*/

if (AW_PARAM_MainEnemyFaction == 1) then {
	mainFaction = "CSAT";
	mainSide = "east";
};
if (AW_PARAM_MainEnemyFaction == 2) then {
	mainFaction = "CSATTropic";
	mainSide = "east";
};
if (AW_PARAM_MainEnemyFaction == 3) then {
	mainFaction = "AAF";
	mainSide = "resistance";
};
if (AW_PARAM_MainEnemyFaction == 4) then {
	mainFaction = "paraMil";
	mainSide = "resistance";
};
if (AW_PARAM_MainEnemyFaction == 5) then {
	mainFaction = "bandits";
	mainSide = "resistance";
};
if (AW_PARAM_MainEnemyFaction == 6) then {
	mainFaction = "FIAIndep";
	mainSide = "resistance";
};
if (AW_PARAM_MainEnemyFaction == 7) then {
	mainFaction = "FIAOpfor";
	mainSide = "east";
};

if (AW_PARAM_SecondaryEnemyFaction == 1) then {
	secondaryMainFaction = "CSAT";
	secondarySide = "east";
};
if (AW_PARAM_SecondaryEnemyFaction == 2) then {
	secondaryMainFaction = "CSATTropic";
	secondarySide = "east";
};
if (AW_PARAM_SecondaryEnemyFaction == 3) then {
	secondaryMainFaction = "AAF";
	secondarySide = "resistance";
};
if (AW_PARAM_SecondaryEnemyFaction == 4) then {
	secondaryMainFaction = "paraMil";
	secondarySide = "resistance";
};
if (AW_PARAM_SecondaryEnemyFaction == 5) then {
	secondaryMainFaction = "bandits";
	secondarySide = "resistance";
};
if (AW_PARAM_SecondaryEnemyFaction == 6) then {
	secondaryMainFaction = "FIAIndep";
	secondarySide = "resistance";
};
if (AW_PARAM_SecondaryEnemyFaction == 7) then {
	secondaryMainFaction = "FIAOpfor";
	secondarySide = "east";
};

publicVariable "mainFaction";
publicVariable "secondaryMainFaction";