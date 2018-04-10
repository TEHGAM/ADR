/*
Author: BACONMOP
side mission defend police

Last modified:  13/11/2017 by McKillen
	
modified:   general tweaks
*/
private ["_RandomTownPosition","_BluforUnits","_OpforFaction","_OpforUnits"];

private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2500;

// Find Location --------------------------
private _towns = nearestLocations [(getMarkerPos "Base"), ["NameVillage","NameCity","NameCityCapital"], 25000];

	private _accepted = false;
	while {!_accepted} do {
		_RandomTownPosition = position (selectRandom _towns);
		_accepted = true;
		{	private _NearBaseLoc = _RandomTownPosition distance (getMarkerPos _x);
			if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
		} forEach _noSpawning;
	};

private _flatPos = [_RandomTownPosition, 1, 250, 2, 0, 20, 0] call BIS_fnc_findSafePos;

//----------------------select random stuff---------------------
//Blufor units
private _BluforFaction = selectRandom ["FIA","Gendarmerie"];
switch (_BluforFaction) do {
	case "FIA":{
	_BluforUnits = ["B_G_Soldier_F","B_G_Soldier_lite_F","B_G_Soldier_TL_F","B_G_Soldier_AR_F",
	"B_G_medic_F","B_G_Soldier_M_F","B_G_officer_F"];
	};
	case "Gendarmerie":{
	_BluforUnits = ["B_GEN_Commander_F","B_GEN_Soldier_F","B_GEN_Soldier_F","B_GEN_Soldier_F",
	"B_GEN_Soldier_F","B_GEN_Soldier_F"];
	};
};

//enemy units (opfor or indep)
private _OpforSide = selectRandom [East,Independent];

switch (_OpforSide) do {
	case Independent:{
	_OpforFaction = selectRandom ["IND_C_F","IND_F"];
	};
	case East:{
	_OpforFaction = selectRandom ["OPF_F","OPF_U_F"];
	};
};

switch (_OpforFaction) do {
	case "IND_C_F":{
	_OpforUnits = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_5_F","I_C_Soldier_Bandit_2_F",
	"I_C_Soldier_Para_4_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_3_F",
	"I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F"];
	};
	case "IND_F":{
	_OpforUnits = ["I_soldier_F","I_soldier_F","I_soldier_F","I_Soldier_lite_F","I_Soldier_GL_F",
	"I_Soldier_AR_F","I_Soldier_TL_F","I_Soldier_M_F","I_medic_F","I_soldier_F","I_Soldier_AT_F","I_Soldier_LAT_F","I_Soldier_AA_F"];
	};
	case "OPF_F":{
	_OpforUnits = ["O_Soldier_F","O_Soldier_F","O_Soldier_F","O_officer_F","O_Soldier_lite_F","O_Soldier_LAT_F","O_Soldier_AT_F",
	"O_Soldier_GL_F","O_Soldier_AR_F","O_soldier_M_F","O_medic_F","O_HeavyGunner_F","O_Sharpshooter_F","O_Soldier_AA_F"];
	};
	case "OPF_U_F":{
	_OpforUnits = ["O_soldierU_F","O_soldierU_AR_F","O_soldierU_TL_F","O_soldierU_medic_F","O_soldierU_LAT_F","O_soldierU_AT_F","O_soldierU_AA_F",
	"O_soldierU_M_F","O_SoldierU_GL_F","O_Urban_Sharpshooter_F","O_Urban_HeavyGunner_F","O_soldierU_F","O_soldierU_F"];
	};
};

// Police Creation -----------------------
private _squadSize = 3 + random 6;
private _BluforGroup = createGroup west;

for "_i" from 0 to _squadSize do {
	private _policeUnit = _BluforGroup createUnit [selectRandom _BluforUnits, _flatPos, [], 0, "FORM"];
	((units _BluforGroup) select _i) addEventHandler ["Killed",{
		private _BluforKilled = format["<t align='center'><t size='2.2'>Side Mission update</t><br/>____________________<br/>One of the BLUFOR units just died.  Go save the remaining ones!</t>"];
		[_BluforKilled] remoteExec ["AW_fnc_globalHint",0,false];
	}];
	sleep 0.1;
};

[_BluforGroup, _RandomTownPosition, 150] call bis_fnc_taskPatrol;
{_x addCuratorEditableObjects [units _BluforGroup, false];} forEach allCurators;


// Briefing ----------------------------

switch (_BluforFaction) do{
	case "FIA":{
	
	{ _x setMarkerPos _RandomTownPosition; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Protect FIA";
	"sideMarker" setMarkerText "Side Mission: Protect friendly FIA forces";
	[west,["policeTask"],["Undercover agents have provided Intel that hostile forces are planning to attack a squad of allied FIA forces. We have the approximate location the the police force. Get over there and protect the police.","Side Mission: Protect FIA Force","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"defend",true] call BIS_fnc_taskCreate;
	
	};
	case "Gendarmerie":{
	{ _x setMarkerPos _RandomTownPosition; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Police Protect";
	"sideMarker" setMarkerText "Side Mission: Protect U.N. Police Force";
	[west,["policeTask"],["Undercover agents have provided Intel that hostile forces are planning to attack a U.N. Police Force. We have the approximate location the the police force. Get over there and protect the police.","Side Mission: Protect U.N. Police Force","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"defend",true] call BIS_fnc_taskCreate;
	};
};

// Give players time to get there -------
sleep 180;
private _EnemyOnTheMove = format["<t align='center'><t size='2.2'>Side Mission update</t><br/>____________________<br/>Intel suggest that hostile forces are mobilizing!</t>"];
[_EnemyOnTheMove] remoteExec ["AW_fnc_globalHint",0,false];

// Enemy Creation -----------------------
private _grp2 = createGroup _OpforSide;
private _grp3 = createGroup _OpforSide;
private _grp4 = createGroup _OpforSide;

private _opForAttackos = [_flatPos, 750, 1250, 2, 0, 20, 0] call BIS_fnc_findSafePos;

private _opForGrp2Pos = [_opForAttackos, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;
private _opForGrp3Pos = [_opForAttackos, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;
private _opForGrp4Pos = [_opForAttackos, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;

for "_i" from 0 to 7 do {
	_opForUnit = _grp2 createUnit [selectRandom _OpforUnits, _opForGrp2Pos, [], 0, "FORM"];
	_opForUnit disableAI "FSM";
	sleep 0.1;
};
[_grp2,_RandomTownPosition] call BIS_fnc_taskAttack;

for "_i" from 0 to 7 do {
	_opForUnit = _grp3 createUnit [selectRandom _OpforUnits, _opForGrp3Pos, [], 0, "FORM"];
	_opForUnit disableAI "FSM";
	sleep 0.1;
};
[_grp3,_RandomTownPosition] call BIS_fnc_taskAttack;

for "_i" from 0 to 7 do {
	_opForUnit = _grp4 createUnit [selectRandom _OpforUnits, _opForGrp4Pos, [], 0, "FORM"];
	_opForUnit disableAI "FSM";
	sleep 0.1;
};
[_grp4,_RandomTownPosition] call BIS_fnc_taskAttack;

private _enemiesArray = units _grp2 + units _grp3 + units _grp4;
{_x addCuratorEditableObjects [_enemiesArray, false];} forEach allCurators;

//Mission config
sideMissionUp = true;
SM_SUCCESS = false;
	sideMissionSpawnComplete = true;
	publicVariableServer "sideMissionSpawnComplete";

// Wait for one side to be dead -----------
waitUntil{sleep 5; ((!sideMissionUp) || ({alive _x} count (units _BluforGroup)) < 1 || (({alive _x} count (units _grp2)) < 1 && ({alive _x} count (units _grp3)) < 1 && ({alive _x} count (units _grp4)) < 1 ));};

// Debrief --------------------------------

if (({alive _x} count (units _BluforGroup)) < 1) then {
	private _BluforKilled = format["<t align='center'><t size='2.2'>Side Mission update</t><br/>____________________<br/>All allied units died.</t>"];
    [_BluforKilled] remoteExec ["AW_fnc_globalHint",0,false];
    ["policeTask", "Failed",true] call BIS_fnc_taskSetState;

};
if (({alive _x} count (units _grp2)) < 1 || !sideMissionUp) then {
	[] call AW_fnc_SMhintSUCCESS;
    ["policeTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
};

// Deletion --------------------------------
sleep 5;
["policeTask",west] call bis_fnc_deleteTask;
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
sleep 120;
private _todelete = (units _BluforGroup) + _enemiesArray;
[_todelete] spawn AW_fnc_SMdelete;
