/*
author: stanhope
Idea proved by Tales
Code from other I&A side mission has been copy pasted in.
description: Rebels have set up a camp.  Find it and raze it to the ground.

Last modified: 5/09/2017 by stanhope
modified: fixed the update hint that keeps appearing
*/
private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2500;

//-------------------- FIND SAFE POSITION FOR MISSION
private _flatPos = [];
private _accepted = false;
while {!_accepted} do {
	while {(count _flatPos) < 2} do {
		private _position = [[[] call BIS_fnc_worldArea],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5,-1,0.3,1,0,false];
	};
	_accepted = true;
	{
		_NearBaseLoc = _flatPos distance (getMarkerPos _x);
		if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
	} forEach _noSpawning;
};

//================Create camp
private _tentsarray = [];

for "_i" from 1 to 5 do {
    private _tentPos = [_flatPos, 0.5, 5, 0, 0, 0.25, 0] call BIS_fnc_findSafePos;
    private _tent = "Land_TentDome_F" createVehicle _flatPos;
    _tent setDir (random 360);
    _tent setVectorUp surfaceNormal position _tent;
    _tent allowDamage false;
    _tentsarray = _tentsarray + [_tent];
};

//===============create militia
private _unittypes = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F"];
private _vehicletypes = ["I_G_Offroad_01_armed_F","I_static_AA_F","I_static_AA_F","I_static_AT_F"];
private _spawnedUnits = [];
private _groupsArray = [];

//infantry
private _MainInfAmount = 0;
private _patrolRange = 25;
for "_x" from 1 to 5 do {
	private _squadPos = [_flatPos, 5, 350, 2, 0, 20, 0] call BIS_fnc_findSafePos;
	private _infantryGroup = createGroup resistance;
	_MainInfAmount = _MainInfAmount + 1;
	_infantryGroup setGroupIdGlobal [format ['Side-MainInf-%1', _MainInfAmount]];
	_groupsArray = _groupsArray + [_infantryGroup];
	for "_x" from 1 to 8 do {
		private _unit = selectRandom _unittypes;
		private _grpMember = _infantryGroup createUnit [_unit, _squadPos, [], 0, "NONE"];
	};
	_patrolRange = floor(_patrolRange + random 75);
	if (_patrolRange > 300) then {_patrolRange = floor(25 + random 75);};
	[_infantryGroup, _flatPos, _patrolRange] call AW_fnc_taskCircPatrol;
	_spawnedUnits = _spawnedUnits + units _infantryGroup;
	
	{_x addCuratorEditableObjects [units _infantryGroup, false];} forEach allCurators;
};

//vehicles
private _RandomVicAmount = 0;
for "_x" from 1 to 4 do {
	private _randomPos = [[[_flatPos, 350], []], ["water", "out"]] call BIS_fnc_randomPos;
	private _grp1 = createGroup resistance;
	_RandomVicAmount = _RandomVicAmount + 1;
	_grp1 setGroupIdGlobal [format ['Side-RandVic-%1', _RandomVicAmount]];
	private _vehicletype = selectRandom _vehicletypes;
	private _vehc =  _vehicletype createVehicle _randompos;
	_vehc allowCrewInImmobile true;
	_vehc lock 2;
	switch (_vehicletype) do {
		case "I_G_Offroad_01_armed_F":{
		createVehicleCrew _vehc;
		(crew _vehc) join _grp1;
		_patrolRange = floor(_patrolRange + random 75);
		if (_patrolRange > 300) then {_patrolRange = floor(25 + random 75);};
		[_grp1, _flatPos, _patrolRange] call AW_fnc_taskCircPatrol;
		_grp1 setSpeedMode "LIMITED";
		};
		case "I_static_AA_F":{ 
		private _grpMember = _grp1 createUnit ["I_C_Soldier_Para_8_F", _flatpos, [], 0, "FORM"];
		_grpMember assignAsGunner _vehc;
		_grpMember moveInGunner _vehc;
		_vehc setDir (random 360);
		};
		case "I_static_AT_F":{ 
		private _grpMember = _grp1 createUnit ["I_C_Soldier_Para_8_F", _flatpos, [], 0, "FORM"];
		_grpMember assignAsGunner _vehc;
		_grpMember moveInGunner _vehc;
		_vehc setDir (random 360);
		};
	
	};
	_groupsArray = _groupsArray + [_grp1];
	_spawnedUnits = _spawnedUnits + units _grp1 + [_vehc];
	{_x addCuratorEditableObjects [(crew _vehc)+ [_vehc], false];} forEach allCurators;
};

//----------------task/circle/....
    private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
    { _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
    sideMarkerText = "Militia Camp";
    "sideMarker" setMarkerText "Side Mission: Militia camp";
    [west,["MilitiaCampTask"],
    ["Intel suggest that hostile milita forces have set up camp somewhere around here.  Move in, kill all the hostiles and then raze their camp to the ground.  High flying drones captured this image of their camp: <br/><br/><img image='Media\Briefing\campSite.jpg' width='300' height='150'/>"
    ,"Side Mission:  Militia camp","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;

//============core loop============
SM_SUCCESS = false;
sideMissionUp = true;
	sideMissionSpawnComplete = true;
	publicVariableServer "sideMissionSpawnComplete";

while { sideMissionUp } do {

	private _EnemiesCount = 0;
	{
		{
			if (alive _x) then {_EnemiesCount = _EnemiesCount + 1;};
		} count (units _x);
	
	} forEach _groupsArray;
	if (_EnemiesCount < 5) exitWith {};
	sleep 10;
};

{_x allowDamage true;} forEach _tentsarray;
private _targetStartText = format["<t align='center' size='2.2'>Side mission update</t><br/>____________________<br/>Most enemy units are dead now.  Go raze that camp to the ground"];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

[(_tentsarray select 0),"Plant charges",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\destroy_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
"_target distance _this <= 5","_target distance _this <= 5",
{   hint "Planting charges ...";
     params ["","_hero"];
    if ( currentWeapon _hero != "" ) then
    {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
    _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
},{},{
    params["_tent","_hero"];
    private _name = name _hero;
    private _targetStartText = format["<t align='center' size='2.2'>Side mission update</t><br/>____________________<br/>%1 has planted charges on the camp.  Get clear, detonation in 30 seconds!", _name];
    [_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
    private _pos = getPos _tent;
    sleep 30;			// ghetto bomb timer
    "Bo_GBU12_LGB" createVehicle (_pos getPos [0,0]);
    sleep 0.2;
    "Bo_GBU12_LGB" createVehicle (_pos getPos [1.5,0]);
    sleep 0.2;
    "Bo_GBU12_LGB" createVehicle (_pos getPos [1.5,90]);
    sleep 0.2;
    "Bo_GBU12_LGB" createVehicle (_pos getPos [1.5,180]);
    sleep 0.2;
    "Bo_GBU12_LGB" createVehicle (_pos getPos [1.5,270]);

},
{   hint "You stopped planting charges.";
    private _unit = _this select 1;
    _unit playMoveNow "";
},[], 8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

while { sideMissionUp && !SM_SUCCESS } do {
    sleep 3;
	private _Tentcount = 0;
	{
		if (alive _x) then {_Tentcount = _Tentcount + 1;};
	} forEach _tentsarray;
	
	if (_Tentcount < 2) then {
	SM_SUCCESS = true;
	sideMissionUp = false;
	};
};

//---------- DE-BRIEF
	["MilitiaCampTask", "Succeeded",true] call BIS_fnc_taskSetState;
	sleep 5;
	["MilitiaCampTask",west] call bis_fnc_deleteTask;
	[] spawn AW_fnc_SMhintSUCCESS;
	sideMissionUp = false;

    { _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
    sleep 120;
    { deleteVehicle _x; sleep 0.1; } forEach _tentsarray;
    [_spawnedUnits] spawn AW_fnc_SMdelete;
