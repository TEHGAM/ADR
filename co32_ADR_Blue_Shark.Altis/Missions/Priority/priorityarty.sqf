/*
Author:

	Quiksilver
	Rarek [AW]

Last modified:3/09/2017 by stanhope

modified:
Fixed it getting stuck in a loop

Description:

	Not done with this, want to get the Commanders gun firing, and some other stuff.
*/

private ["_flatPos","_accepted","_NearBaseLoc","_nospawning","_MaxSleepTime","_position","_PTdir","_unitsArray","_priorityGroup",
"_distance","_dir","_c","_pos","_barrier","_enemiesArray","_unit","_targetPos","_fuzzyPos","_briefing","_completeText","_targetUnit"];

private _spawnedUnits = [];

private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2000;

//-------------------- 1. FIND POSITION

	_flatPos = [0,0,0];
	_accepted = false;
	_nospawning =  BaseArray + [currentAO];  
	
	while {!_accepted} do {
		_position = [[[getMarkerPos currentAO , 2500]],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];

		while {(count _flatPos) < 2} do {
			_position = [[[getMarkerPos currentAO , 2500]],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
		};

		_accepted = true;
		{
			_NearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
		} forEach _noSpawning;
	};
	
	private _flatPos1 = _flatpos getPos [5, 0];
	private _flatPos2 = _flatpos getPos [5, 180];
	private _flatPos3 = _flatpos getPos [25, random 360];

//-------------------- 2. SPAWN OBJECTIVES

	_PTdir = random 360;

	priorityObj1 = "O_MBT_02_arty_F" createVehicle _flatPos1;
	priorityObj2 = "O_MBT_02_arty_F" createVehicle _flatPos2;
	ammoTruck = "O_Truck_03_ammo_F" createVehicle _flatPos3;
	
	waitUntil {!isNull priorityObj1 && !isNull priorityObj2 && !isNull ammoTruck};
	{
	_x lock 3;
	_x allowCrewInImmobile true; 
	_spawnedUnits pushBack _x;
	_x setDir _PTdir;
	_x setFuel 0;
	} forEach [priorityObj1,priorityObj2,ammoTruck];

//-------------------- 3. SPAWN CREW - Same method as in priorityaa

	sleep 0.1;

	_unitsArray = [objNull];                        // for crew and h-barriers
	_groupsArray= [objNull];

	_priorityGroup = createGroup east;
	
	{
		_x addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
		createvehiclecrew _x;
		(crew _x) join _priorityGroup;
		sleep 0.1;
		_x dowatch getMarkerpos currentAO;
	} forEach [priorityObj1, priorityObj2];
	
	_priorityGroup setGroupIdGlobal [format ['Prio-arty']];

	 {
	_spawnedUnits = _spawnedUnits + units _x;
	[(units _x)] call AW_fnc_setSkill4;
	_x setBehaviour "COMBAT";
	_x setCombatMode "RED";
	_x allowFleeing 0;
	} foreach [_priorityGroup];

	//=====zeus adding
	_groupsArray = _groupsArray + [_priorityGroup];	
	{_x addCuratorEditableObjects [[priorityObj1, priorityObj2, ammoTruck]+ (units _priorityGroup), false];} foreach allCurators;

//-------------------- 4. SPAWN H-BARRIER RING

	sleep 0.1;

	private _distance = 18;
	private _dir = 0;
	for "_c" from 1 to 8 do
	{
		_pos = _flatpos getPos [_distance, _dir];
		_barrier = "Land_HBarrierBig_F" createVehicle _pos;
		waitUntil {alive _barrier};
		_barrier setDir _dir;
		_dir = _dir + 45;
		_barrier allowDamage false; 
		_barrier setVectorUp surfaceNormal position _barrier;
		_unitsArray = _unitsArray + [_barrier];
	};	
	sleep 0.1;

//-------------------- 5. SPAWN FORCE PROTECTION

	private _infantryGroupamount = 0;
	_infPos = getPos priorityObj1;
	for "_x" from 1 to 5 do {
		private _randomPos = [[[_infPos, 300 * 1.2], []], ["water", "out"]] call BIS_fnc_randomPos;
		private _infantryGroup = createGroup EAST;
		_infantryGroupamount = _infantryGroupamount + 1;
		_infantryGroup setGroupIdGlobal [format ['Prio-protection-inf-%1', _infantryGroupamount]];
		for "_x" from 1 to 8 do {
			private _squadPos = [[[_randomPos, 10], []], ["water", "out"]] call BIS_fnc_randomPos;
			_unitArray = (missionconfigfile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
			_unit = _unitArray call BIS_fnc_selectRandom;
			_grpMember = _infantryGroup createUnit [_unit, _squadPos, [], 0, "FORM"];
		};

		[_infantryGroup, _infPos, 300 / 1.6] call AW_FNC_taskPatrol;
		_spawnedUnits = _spawnedUnits + (units _infantryGroup);
		{_x addCuratorEditableObjects [(units _infantryGroup), true];} foreach allCurators;
		sleep 0.5;
	};

	sleep 0.1;


//-------------------- 7. BRIEF

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["priorityMarker", "priorityCircle"];

	priorityTargetText = "Artillery";
	"priorityMarker" setMarkerText "Priority Target: Artillery";
	[west,["priorArtyTask"],["OPFOR forces are setting up an artillery battery to hit you guys damned hard! We've picked up their positions with thermal imaging scans and have marked it on your map. This is a priority target, boys! They're just setting up now; they'll be firing in about five minutes!  Previous sites looked like this: <br/><br/><img image='Media\Briefing\prioArty.jpg' width='300' height='150'/>","Priority Target: Artillery","priorityCircle"],(getMarkerPos "priorityCircle"),"Created",0,true,"NewPriorityTarget",true] call BIS_fnc_taskCreate;

	prioMissionSpawnComplete = true;
	publicVariableServer "prioMissionSpawnComplete";
	
//-------------------- FIRING SEQUENCE LOOP

while {canFire priorityObj1 || canFire priorityObj2} do {
	_shouldSearchTargets = true;
	_targetUnit = objNull;
	_targetPos = [0, 0, 0];

	while {_shouldSearchTargets} do {
	
		if (!(canFire priorityObj1) && !(canFire priorityObj2)) exitWith{ _shouldSearchTargets = false; };
		
		_playerCount = count playableUnits;

		if (_playerCount >= 0) then {
		
			_targetUnit = selectRandom playableUnits;
			
			if ( !(isNull _targetUnit) && (vehicle _targetUnit == _targetUnit) && (side _targetUnit == WEST)) then {
				
				_targetPos = getPos _targetUnit;
				private _farEnoughFromBase = true;
				_distance = 0;
				{
					_distance = _targetPos distance (getMarkerPos _x);
					if (_distance < 1000) then {_farEnoughFromBase = false;};
				} forEach BaseArray;
				
				if ( _farEnoughFromBase ) then {
					if ( ((East knowsAbout _targetUnit) > 1.9) || ((Independent knowsAbout _targetUnit) > 1.9) ) then { 
						if (!(canFire priorityObj1) && !(canFire priorityObj2)) exitWith{_shouldSearchTargets = false;};
						{if (alive _x) then {[_x, _targetPos] call AW_fnc_artyStrike;};} forEach [priorityObj1, priorityObj2];
						_shouldSearchTargets = false;
					};
				};
			};
		} else {
			_shouldSearchTargets = false;	//Because there's less than three players on the server.
		};
		sleep 2;
	};
	
	if (!(canFire priorityObj1) && !(canFire priorityObj2)) exitWith{};
	
	private _TimeSlept = 0;
	
	_MaxSleepTime = abs (PARAMS_ArtilleryTargetTickTimeMax - PARAMS_ArtilleryTargetTickTimeMin);
	
	while {_TimeSlept < PARAMS_ArtilleryTargetTickTimeMin} do {
		private _TimeToSleep = random _MaxSleepTime;
		if (_TimeToSleep < 20) then {_TimeToSleep = 20;};
		_TimeSlept = _TimeSlept + _TimeToSleep;
		sleep _TimeToSleep;
		if (!(canFire priorityObj1) && !(canFire priorityObj2)) exitWith{}; 
	};
		
};
//-------------------- DE-BRIEF

	["priorArtyTask", "Succeeded",true] call BIS_fnc_taskSetState;
	sleep 5;
	["priorArtyTask",west] call bis_fnc_deleteTask;
	{ _x setMarkerPos [-10000,-10000,-10000] } forEach ["priorityMarker","priorityCircle"];

//-------------------- DELETE
	sleep 120;
	_ToDelete = _unitsArray + _spawnedUnits;
	{ deleteVehicle _x } forEach _ToDelete;
