/*
Author:	Quiksilver
	
Last modified:	3/01/2017 by Stan, AW community member
	
modified:	reworked the targeting loop + some of the spawning in stuff

Description:
	Anti-Air Battery.
	To make them more dangerous, they have buffed skill and unlimited ammo.
*/
private _AISkillUnitsArray = [];

private _basepos = getMarkerPos "BASE";
private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2000;

//-------------------- 1. FIND POSITION FOR OBJECTIVE
	private _flatPos = [];
	private _accepted = false;
	while {!_accepted} do {
		while {(count _flatPos) < 2} do {
			private _position = [[[getMarkerPos currentAO,6000]],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [20,-1,0.35,1,0,false,objNull];
		};

		_accepted = true;
		{
			_NearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
		} forEach _noSpawning;
	};
	
//-------------------- 2. SPAWN OBJECTIVES & ammo truck(for ambiance and plausibiliy of unlimited ammo)
	private _unitsArray = []; 			// for crew and h-barriers
	private _groupsArray = [];
	private _PTdir = random 360;
	
	//create the group and an officer to keep the group CSAT
	private _priorityGroup = createGroup east;
	_priorityGroup setGroupIdGlobal [format ['Prio-objective']];
	"O_officer_F" createUnit [[(_flatPos select 0) + 20, (_flatPos select 1) + random 20, (_flatPos select 2)], _priorityGroup];
	
	//create the actuall vehicles
	priorityObj0 = createVehicle ["O_APC_Tracked_02_AA_F", (_flatpos getPos [10, 0]), [], 0, "NONE"];
	priorityObj1 = createVehicle ["B_AAA_System_01_F", (_flatpos getPos [10, 120]), [], 0, "NONE"];
	[priorityObj1,["Green",1], true] call BIS_fnc_initVehicle;
	priorityObj2 = createVehicle ["B_SAM_System_02_F", (_flatpos getPos [10, 240]), [], 0, "NONE"];
	[priorityObj2,["Green",1],true] call BIS_fnc_initVehicle;
	ammoTruck = createVehicle ["O_Truck_03_ammo_F", (_flatpos getPos [30, random 360]), [], 0, "NONE"];
	
	//wait untill they're actually created
	sleep 0.5;
	waitUntil {(!isNull priorityObj0)&&(!isNull priorityObj1)&&(!isNull priorityObj2)&&(!isNull ammoTruck)};
	
	//set a bunch of stuff, including unlimited ammo
	{
		_x setDir (_PTdir + (random 5));
		_x addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
		createvehiclecrew _x;
		(crew _x) join _priorityGroup;
		sleep 0.1;
		_x setVehicleRadar 1;
		_x setVehicleReceiveRemoteTargets true;
		_x setVehicleReportRemoteTargets true;
		_x lock 3;
		_x allowCrewInImmobile true;
		_x doWatch _basepos;
		_x setFuel 0;
	} forEach [priorityObj0, priorityObj1, priorityObj2];
	
	ammoTruck setDir _PTdir;
	ammoTruck lock 3;
	
	//delete that officer again
	deleteVehicle ((units _priorityGroup) select 0);
	
	{
		[(units _x)] call derp_fnc_AISkill;
		_x setBehaviour "COMBAT";
		_x setCombatMode "RED";	
		_x allowFleeing 0;
	}forEach [_priorityGroup];
	
	//add stuff to the right arrays and zeus
	_groupsArray = _groupsArray + [_priorityGroup];
	_unitsArray = _unitsArray + (units _priorityGroup);
	{_x addCuratorEditableObjects [[priorityObj0,priorityObj1, priorityObj2, ammoTruck]+ (units _priorityGroup), true];} foreach allCurators;
	sleep 0.1;

//-------------------- 4. SPAWN H-BARRIER RING
	private _distance = 20;
	private _dir = 0;
	for "_c" from 1 to 10 do
	{
		private _pos = _flatpos getPos [_distance, _dir];
		private _barrier = "Land_HBarrierBig_F" createVehicle _pos;
		waitUntil {alive _barrier};
		_barrier setDir _dir;
		_dir = _dir + 36;
		_barrier allowDamage false; 
		_barrier setVectorUp surfaceNormal position _barrier;
		_unitsArray = _unitsArray + [_barrier];
	};	
	sleep 0.1;

//-------------------- 5. SPAWN FORCE PROTECTION
private _infgroupamount = 0;
private _unitArray = (missionConfigFile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
private _patrolrange = 50;

for "_x" from 1 to 5 do {
	_randomPos = [_flatPos, 5, 350, 2, 0, 20, 0] call BIS_fnc_findSafePos;
	private _infantryGroup = createGroup east;
	_infgroupamount = _infgroupamount + 1;
	_infantryGroup setGroupIdGlobal [format ['Prio-infantry-%1',_infgroupamount]];
	for "_x" from 1 to 8 do {
		_unit = selectRandom _unitArray;
		_grpMember = _infantryGroup createUnit [_unit, _randomPos, [], 0, "NONE"];
	};
	sleep 0.5;
	_patrolrange = _patrolrange + 25 + random (25);
	if (_patrolrange > 225) then {_patrolrange = 50;};
	[_infantryGroup, _flatpos, _patrolrange] call AW_fnc_taskCircPatrol;
	{_x addCuratorEditableObjects [units _infantryGroup, true];} forEach allCurators;
	
	_AISkillUnitsArray = _AISkillUnitsArray + (units _infantryGroup);
	_unitsArray = _unitsArray + (units _infantryGroup);
};
[_AISkillUnitsArray] call derp_fnc_AISkill;
sleep 0.1;	
	
//-------------------- reduce dammage
	{
		_x setVariable ["selections", []];
		_x setVariable ["gethit", []];
		_x addEventHandler
		[
			"HandleDamage",
			{
				params ["_unit","_selection","_inputDamage","","","",""];
				_selections = _unit getVariable ["selections", []];
				_gethit = _unit getVariable ["gethit", []];
				
				if !(_selection in _selections) then
				{
					_selections set [count _selections, _selection];
					_gethit set [count _gethit, 0];
				};
				_i = _selections find _selection;
				_olddamage = _gethit select _i;
				_damage = _olddamage + (_inputDamage - _olddamage) * 0.35;
				_gethit set [_i, _damage];
				_damage;
			}
		];
	}forEach [priorityObj0,priorityObj1,priorityObj2];
	
//-------------------- 7. BRIEFING
	private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["priorityMarker", "priorityCircle"];  
	
	priorityTargetText = "Anti-Air Battery";
	"priorityMarker" setMarkerText "Priority Target: Anti-Air Battery";
	
	[west,["priorAnti-AirTask"],[
	"OPFOR forces are setting up an anti-air battery to hit you guys damned hard! We've picked up their positions with thermal imaging scans and have marked it on your map. This is a priority target, boys! They're just setting up now.  Previous sites looked like this: <br/><br/><img image='Media\Briefing\prioAA.jpg' width='300' height='150'/>"
	,"Priority Target: Anti-air","priorityCircle"],(getMarkerPos "priorityCircle"),"Created",0,true,"NewPriorityTarget",true] call BIS_fnc_taskCreate;

	prioMissionSpawnComplete = true;
	publicVariableServer "prioMissionSpawnComplete";
	
//-------------------- 8. CORE LOOP
//set some stuff
private _loopVar = true;
private _shooterList = [priorityObj0, priorityObj1, priorityObj2];
private _disabledShooters = 0;

while {_loopVar} do {
	
	//check if we can still fire
	{
		if (canFire _x) then {
			_x doWatch _basepos;
		} else {
			_shooterList = _shooterList - [_x];
			_disabledShooters = _disabledShooters + 1;
		};
	} forEach _shooterList;
	if (_disabledShooters > 2) exitWith {_loopVar = false;};	
	
	//start selecting targets
	_targetList = _flatPos nearEntities [["Air"],4000];
	
	//if there aren't no air contacts proceed please
	if ((count _targetList) > 0) then {
		//select all blufor units
		private _targetListEnemy = [];
		{
			if ((side _x) == west) then {
				_targetListEnemy pushBack _x;
			};
		} forEach _targetList;
	
		if ((count _targetListEnemy) > 0) then {
			//i know where you are, now the AI does too 
			{_priorityGroup reveal [_x,4];} forEach _targetListEnemy;
			
			private _targetSelect = selectRandom _targetListEnemy;
			{
				if (canFire _x) then {
					_x doWatch _targetSelect;
					_x doTarget _targetSelect;
					_x doFire _targetSelect;
				};
			} forEach _shooterList;
			sleep 2;
		};
	};
	//loop timeout
	sleep 6;
};

//-------------------- 9. DE-BRIEF
    ["priorAnti-AirTask", "Succeeded",true] call BIS_fnc_taskSetState;
    sleep 10;
    ["priorAnti-AirTask",west] call bis_fnc_deleteTask;
    {_x setMarkerPos [-10000,-10000,-10000];} forEach ["priorityMarker","priorityCircle"];

//-------------------- 10. DELETE
    sleep 120;
    _toDelete = _unitsArray  + [priorityObj0,priorityObj1,priorityObj2,ammoTruck];
    { deleteVehicle _x } forEach _toDelete;
    [_groupsArray] spawn AW_fnc_SMdelete;
