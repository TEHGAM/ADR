/*
Author:

	Quiksilver
	
Last modified:

	24/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Anti-Air Battery.
		Two stationary ZSU-39 Tigris spawn with an H-barrier ring, at a random position near the AO.
		To make them more dangerous, they have buffed skill and unlimited ammo.
		To-do: make them spawn between base and AO. http://forums.bistudio.com/showthread.php?176757-Finding-a-random-position-between-two-points
		
Error log:
		
6:25:59 Error in expression <ove priorityObj2 } do {

_targetList = (getPos _flatPos) nearEntities [["Air"],5>
 6:25:59   Error position: <getPos _flatPos) nearEntities [["Air"],5>
 6:25:59   Error getpos: Type Array, expected Object,Location
 6:25:59 File mpmissions\__cur_mp.Altis\mission\side\missions\priorityAA.sqf, line 199
	
_____________________________________________________________________________________*/

private ["_basepos","_loopVar","_dir","_PTdir","_pos","_barrier","_unitsArray","_flatPos","_accepted","_position","_enemiesArray","_targetList","_fuzzyPos","_x","_briefing","_enemiesArray","_unitsArray","_flatPos1","_flatPos2","_flatPos3","_doTargets","_targetSelect","_targetListEnemy"];

//-------------------- 1. FIND POSITION FOR OBJECTIVE

	_basepos = getMarkerPos "respawn_west";
	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [[[_basepos,2000]],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];

		while {(count _flatPos) < 2} do {
			_position = [[[_basepos,6000]],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
		};

		if ((_flatPos distance _basepos) > 2000) then {
			if ((_flatPos distance _basepos) < 3750) then {
				if ((_flatPos distance (getMarkerPos currentAO)) > 500) then {
					_accepted = true;
				};
			};
		};
	};

	_flatPos1 = [(_flatPos select 0) - 2, (_flatPos select 1) - 2, (_flatPos select 2)];
	_flatPos2 = [(_flatPos select 0) + 2, (_flatPos select 1) + 2, (_flatPos select 2)];
	_flatPos3 = [(_flatPos select 0) + 20, (_flatPos select 1) + random 20, (_flatPos select 2)];
	
//-------------------- 2. SPAWN OBJECTIVES

	_PTdir = random 360;
	
	sleep 1;
	
	priorityObj1 = "O_APC_Tracked_02_AA_F" createVehicle _flatPos1;
	waitUntil {!isNull priorityObj1};
	priorityObj1 setDir _PTdir;
	
	sleep 1;
	
	priorityObj2 = "O_APC_Tracked_02_AA_F" createVehicle _flatPos2;
	waitUntil {!isNull priorityObj2};
	priorityObj2 setDir _PTdir;
	
	sleep 1;
	
	//----- SPAWN AMMO TRUCK (for ambiance and plausibiliy of unlimited ammo)
	
	ammoTruck = "O_Truck_03_ammo_F" createVehicle _flatPos3;
	waitUntil {!isNull ammoTruck};
	ammoTruck setDir random 360;
	
	{_x lock 3;_x allowCrewInImmobile true;} forEach [priorityObj1,priorityObj2,ammoTruck];
	
//-------------------- 3. SPAWN CREW
	
	_unitsArray = [objNull]; 			// for crew and h-barriers
	
	_priorityGroup = createGroup east;
	
		"O_officer_F" createUnit [_flatPos, _priorityGroup];
		"O_officer_F" createUnit [_flatPos, _priorityGroup];
		"O_engineer_F" createUnit [_flatPos, _priorityGroup];
		"O_engineer_F" createUnit [_flatPos, _priorityGroup];
		
		((units _priorityGroup) select 0) assignAsCommander priorityObj1;
		((units _priorityGroup) select 0) moveInCommander priorityObj1;
		((units _priorityGroup) select 1) assignAsCommander priorityObj2;
		((units _priorityGroup) select 1) moveInCommander priorityObj2;
		((units _priorityGroup) select 2) assignAsGunner priorityObj1;
		((units _priorityGroup) select 2) moveInGunner priorityObj1;
		((units _priorityGroup) select 3) assignAsGunner priorityObj2;
		((units _priorityGroup) select 3) moveInGunner priorityObj2;
	
	_unitsArray = _unitsArray + [_priorityGroup];

	{
		_x addCuratorEditableObjects [[priorityObj1, priorityObj2, ammoTruck] + (units _priorityGroup), false];
	} foreach adminCurators;

	
	//---------- Engines on baby
	
	sleep 0.1;
	priorityObj1 engineOn true;
	sleep 0.1;
	priorityObj2 engineOn true;
	priorityObj1 doWatch _basepos;
	priorityObj2 doWatch _basepos;
	

//-------------------- 4. SPAWN H-BARRIER RING

	sleep 1;

	_distance = 16;
	_dir = 0;
	for "_c" from 0 to 7 do
	{
		_pos = [_flatPos, _distance, _dir] call BIS_fnc_relPos;
		_barrier = "Land_HBarrierBig_F" createVehicle _pos;
		waitUntil {alive _barrier};
		_barrier setDir _dir;
		_dir = _dir + 45;
		_barrier allowDamage false; 
		_barrier enableSimulation false;
		
		_unitsArray = _unitsArray + [_barrier];
	};

//-------------------- 5. SPAWN FORCE PROTECTION

	_enemiesArray = [priorityObj1] call QS_fnc_PTenemyEAST;

//-------------------- 6. THAT GIRL IS SO DANGEROUS!

	[(units _priorityGroup)] call QS_fnc_setSkill4;
	_priorityGroup setBehaviour "COMBAT";
	_priorityGroup setCombatMode "RED";	
	_priorityGroup allowFleeing 0;
	
	//----- 6a. UNLIMITED AMMO

	priorityObj1 addEventHandler ["Fired",{ priorityObj1 setVehicleAmmo 1 }];
	priorityObj2 addEventHandler ["Fired",{ priorityObj2 setVehicleAmmo 1 }];

	//-------------------- 6b. ABIT OF EXTRA HEALTH

	//---------- OBJ 1
	
		priorityObj1 setVariable ["selections", []];
		priorityObj1 setVariable ["gethit", []];
		priorityObj1 addEventHandler
		[
			"HandleDamage",
			{
				_unit = _this select 0;
				_selections = _unit getVariable ["selections", []];
				_gethit = _unit getVariable ["gethit", []];
				_selection = _this select 1;
				if !(_selection in _selections) then
				{
					_selections set [count _selections, _selection];
					_gethit set [count _gethit, 0];
				};
				_i = _selections find _selection;
				_olddamage = _gethit select _i;
				_damage = _olddamage + ((_this select 2) - _olddamage) * 0.25;
				_gethit set [_i, _damage];
				_damage;
			}
		];
	
	//---------- OBJ 2
	
		priorityObj2 setVariable ["selections", []];
		priorityObj2 setVariable ["gethit", []];
		priorityObj2 addEventHandler
		[
			"HandleDamage",
			{
				_unit = _this select 0;
				_selections = _unit getVariable ["selections", []];
				_gethit = _unit getVariable ["gethit", []];
				_selection = _this select 1;
				if !(_selection in _selections) then
				{
					_selections set [count _selections, _selection];
					_gethit set [count _gethit, 0];
				};
				_i = _selections find _selection;
				_olddamage = _gethit select _i;
				_damage = _olddamage + ((_this select 2) - _olddamage) * 0.25;
				_gethit set [_i, _damage];
				_damage;
			}
		];

	//----- 6c. CAN SEE ALL PLAYERS OR NEARBY TARGETS (TARGET PILOTS?) SMALL RADAR DOME NEARBY?

		/* WIP: See below loop */
	
//-------------------- 7. BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["priorityMarker", "priorityCircle"];  
	priorityTargetText = "Anti-Air Battery"; publicVariable "priorityTargetText";
	"priorityMarker" setMarkerText "Priority Target: Anti-Air Battery"; publicVariable "priorityMarker";
	_briefing = "<t align='center' size='2.2'>Priority Target</t><br/><t size='1.5' color='#b60000'>Anti-Air Battery</t><br/>____________________<br/>OPFOR forces are setting up an anti-air battery to hit you guys damned hard! We've picked up their positions with thermal imaging scans and have marked it on your map.<br/><br/>This is a priority target, boys!";
	GlobalHint = _briefing; hint parseText _briefing; publicVariable "GlobalHint";
	showNotification = ["NewPriorityTarget", "Destroy Anti-Air"]; publicVariable "showNotification";
	
//-------------------- 8. CORE LOOP

_loopVar = TRUE;
_doTargets = [];
_targetSelect = objNull;
while {_loopVar} do {

	//========== Small targeting system routine
	
	_doTargets = [];
	_targetSelect = objNull;
	_targetList = _flatPos nearEntities [["Air"],7500];
	if ((count _targetList) > 0) then {
		{_priorityGroup reveal [_x,4];} forEach _targetList;
		_targetListEnemy = [];
		{
			if ((side _x) == west) then {
				0 = _targetListEnemy pushBack _x;
			};
		} count _targetList;
		
		if ((count _targetListEnemy) > 0) then {
			{
				if ((getPos _x select 2) > 25) then {
					0 = _doTargets pushBack _x;
				};
			} count _targetListEnemy;
			
			if ((count _doTargets) > 0) then {
				_targetSelect = _doTargets select (floor (random (count _doTargets)));
				if (canFire priorityObj1) then {
					priorityObj1 doWatch [(getPos _targetSelect select 0),(getPos _targetSelect select 1),2000];
					priorityObj1 doTarget _targetSelect;
					sleep 2;
					priorityObj1 fireAtTarget [_targetSelect,"missiles_titan"];
					sleep 2;
					if (canFire priorityObj2) then {
						_targetSelect = _doTargets select (floor (random (count _doTargets)));
						priorityObj2 doWatch [(getPos _targetSelect select 0),(getPos _targetSelect select 1),2000];
						priorityObj2 doTarget _targetSelect;
						sleep 2;
						priorityObj2 fireAtTarget [_targetSelect,"missiles_titan"];
						sleep 2;
					};
				} else {
					if (canFire priorityObj2) then {
						priorityObj2 doTarget _targetSelect;
						sleep 2;
						priorityObj2 doFire _targetSelect;
						sleep 2;
					};
				};
			};
		};
	};
	
	//============================== Exit strategy

	if (!alive priorityObj1) then {
		if (!alive priorityObj2) then {
			
			_loopVar = FALSE;

			//-------------------- 9. DE-BRIEF
			
			_completeText = "<t align='center' size='2.2'>Priority Target</t><br/><t size='1.5' color='#08b000'>NEUTRALISED</t><br/>____________________<br/>Incredible job, boys! Make sure you jump on those priority targets quickly; they can really cause havoc if they're left to their own devices.<br/><br/>Keep on with the main objective; we'll tell you if anything comes up.";
			GlobalHint = _completeText; hint parseText _completeText; publicVariable "GlobalHint";
			showNotification = ["CompletedPriorityTarget", "Anti-Air Battery Neutralised"]; publicVariable "showNotification";
			{_x setMarkerPos [-10000,-10000,-10000];} forEach ["priorityMarker","priorityCircle"]; publicVariable "priorityMarker";

			//-------------------- 10. DELETE

			sleep 120;
			{_x removeEventHandler ["Fired", 0];} forEach [priorityObj1,priorityObj2];
			{_x removeEventHandler ["HandleDamage",1];} forEach [priorityObj1,priorityObj2];
			{[_x] spawn QS_fnc_SMdelete;} forEach [_enemiesArray,_unitsArray];
			{deleteVehicle _x;} forEach [priorityObj1,priorityObj2,ammoTruck];
		};
	};
	sleep 5;
};

	