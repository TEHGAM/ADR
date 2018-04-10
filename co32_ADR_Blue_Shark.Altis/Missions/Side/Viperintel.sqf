/*
author: stanhope
Idea proved by chutnut & Eagle-eye
Code from other I&A side mission has been copy pasted in

description:  Vipers are sitting on some intel.  It's hidden somewhere in an area.  Find and secure it.

Last modified: 23/10/2017 by stanhope

modified: pos finder, addaction=>holdaction, general tweaks to code
*/

private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2500;

//-------------------- FIND SAFE POSITION FOR MISSION
private _flatPos = [];
private _accepted = false;
while {!_accepted} do {
	while {(count _flatPos) < 2} do {
		private _position = [[[] call BIS_fnc_worldArea],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [4,-1,0.3,1,0,false];
	};

	_accepted = true;
	{
		_NearBaseLoc = _flatPos distance (getMarkerPos _x);
		if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
	} forEach _noSpawning;
};
	
//----------spawn intel, tent

private _tent = "Land_IRMaskingCover_01_F" createVehicle _flatPos;
_tent allowDamage false;
_tent enableSimulation false;

private _intellobj = "Land_TripodScreen_01_large_F" createVehicle _flatPos;

_intellobj addEventHandler ["Killed",{
	params ["_unit","","_killer"];
	_name = name _killer;
	if (_name == "Error: No vehicle") then{
	    _name = "Someone";
	};
	_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Intel Destroyed</t><br/>____________________<br/>%1 destroyed the Intel, mission failed.",_name];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
}];

[_intellobj,"Secure intel",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
"_target distance _this <= 4","_target distance _this <= 4",
{
    hint "Downloading Intel...";
    params ["","_hero"];
    if ( currentWeapon _hero != "" ) then
    {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
    _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
},{},{execVM "missions\side\actions\recover.sqf";},
{
    hint "You stop downloading the intel.";
    private _unit = _this select 1;
    _unit playMoveNow "";
},[],
8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

//-----spawn force protection
sideObj = _intellobj;
private _enemiesArray = [sideObj] call AW_fnc_smenemyeastrescuepilot;

//-----spawn viper protection:
private _vipergroupPos = [_intellobj, 5, 50, 2, 0, 20, 0] call BIS_fnc_findSafePos;

private _vipergroup = createGroup east;
_vipergroup setGroupIdGlobal [format ['Side-ViperGroup']];
for "_i" from 1 to 8 do {

	private _unittype = selectRandom ["O_V_Soldier_hex_F","O_V_Soldier_TL_hex_F","O_V_Soldier_Exp_hex_F","O_V_Soldier_Medic_hex_F","O_V_Soldier_M_hex_F","O_V_Soldier_LAT_hex_F","O_V_Soldier_JTAC_hex_F"];
	private _unit = _vipergroup createUnit [_unittype, _vipergroupPos, [], 5, "NONE"];
	_unit setSkill 1;
};
[_vipergroup, _flatPos, 25] call BIS_fnc_taskPatrol;
{_x addCuratorEditableObjects [units _vipergroup, false];} forEach allCurators;
_enemiesArray = _enemiesArray + units _vipergroup;

//----------------task/circle/....
    private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
    { _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
    sideMarkerText = "Capture intel";
    "sideMarker" setMarkerText "Side Mission: Capture intel";
    [west,["ViperIntellTask"],
    ["We've spotted an enemy viper team with a significant force protection around them.  They must be sitting on some valuable intel.  Go get this intel.  Our intel suggests that the objective will look like this: <img image='Media\Briefing\viperIntel.jpg' width='300' height='150'/>",
    "Side Mission: Capture intel","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;

//==============mission core==============
sideMissionUp = true;
SM_SUCCESS = false;
	sideMissionSpawnComplete = true;
	publicVariableServer "sideMissionSpawnComplete";

waitUntil{sleep 5; (!alive _intellobj) || SM_SUCCESS  || !sideMissionUp};

    if (!alive _intellobj || !sideMissionUp) then {
        ["ViperIntellTask", "Failed",true] call BIS_fnc_taskSetState;
        sideMissionUp = false;
        SM_SUCCESS = false;
    };

    if (SM_SUCCESS) then {
        ["ViperIntellTask", "Succeeded",true] call BIS_fnc_taskSetState;
        [] spawn AW_fnc_SMhintSUCCESS;
        sideMissionUp = false;
    };

sleep 5;
["ViperIntellTask",west] call bis_fnc_deleteTask;
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
sleep 120;
{ deleteVehicle _x } forEach [_tent,_intellobj];
[_enemiesArray] spawn AW_fnc_SMdelete;
