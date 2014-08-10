/*
Author: 
	Rarek [AW] & Quiksilver

Description:
	Spawn an artillery battery that targets players, forcing them to react or die.
	Becomes progressively more accurate with each barrage.
	Best suited for 20+ players.
	A little unfair for low-pop servers, consider disabling or gimping in some ways if not many people expected.
	If low server pop, can cause people to leave server if it appears too often.

To do:	
	Create PARAM for side mission units
*/

private ["_firstRun","_isGroup","_obj","_position","_flatPos","_nearUnits","_accepted","_pos","_barrier","_dir","_unitsArray","_randomPos","_spawnGroup","_unit","_targetPos","_radius","_randomWait","_briefing","_flatPosAlt","_flatPosClose","_priorityGroup","_distance","_firingMessages","_completeText","_x","_enemiesArray","_artySniperGroup","_car","_carGroup"];

priorityTargetUp = false;
priorityTargets = ["None"];

_firstRun = true;
_unitsArray = [objNull];
_completeText =
"<t align='center' size='2.2'>Priority Target</t><br/><t size='1.5' color='#08b000'>NEUTRALISED</t><br/>____________________<br/>Incredible job, boys! Make sure you jump on those priority targets quickly; they can really cause havoc if they're left to their own devices.<br/><br/>Keep on with the main objective; we'll tell you if anything comes up.";

while {true} do {

	//-------------------- Random time between arty spawn

	_randomWait = (random 3300);   // default 3600 (55 min)
	sleep (600 + _randomWait);	// default 600 (10 min) 
	
	//-------------------- Secondary delete
	
	if (_firstRun) then
	{
		_firstRun = false;
	} else {
		//Delete old PT objects
		for "_c" from 0 to (count _unitsArray) do
		{
			_obj = _unitsArray select _c;
			_isGroup = false;
			if (_obj in allGroups) then { _isGroup = true; } else { _isGroup = false; };
			if (_isGroup) then
			{
				{
					if (!isNull _x) then
					{
						deleteVehicle _x;
					};
				} forEach (units _obj);
				deleteGroup _obj;
			} else {
				if (!isNull _obj) then
				{
					deleteVehicle _obj;
				};
			};
		};
	};
	
	//-------------------- Briefing hint
	
	_briefing = 
	"<t align='center' size='2.2'>Priority Target</t><br/><t size='1.5' color='#b60000'>Artillery</t><br/>____________________<br/>OPFOR forces are setting up an artillery battery to hit you guys damned hard! We've picked up their positions with thermal imaging scans and have marked it on your map.<br/><br/>This is a priority target, boys! They're just setting up now; they'll be firing in about five minutes!";

	//-------------------- Find good position to spawn arty
	
	_flatPos = [0];
	_accepted = false;
	while {!_accepted} do
	{
		while {(count _flatPos) < 3} do
		{
			_position = [[[getMarkerPos currentAO,2500]],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
		};
		
		if
		((_flatPos distance (getMarkerPos "respawn_west")) > 1000 && (_flatPos distance (getMarkerPos currentAO)) > 800) then {
			_nearUnits = 0;
			{
				if ((_flatPos distance (getPos _x)) < 500) then
				{
					_nearUnits = _nearUnits + 1;
				};
			} forEach playableUnits;
			
			if (_nearUnits == 0) then
			{
				_accepted = true;
			};
		} else {
			_flatPos = [0];
		};
	};
	
	_flatPosAlt = [(_flatPos select 0) - 2, (_flatPos select 1), (_flatPos select 2)];
	_flatPosClose = [(_flatPos select 0) + 2, (_flatPos select 1), (_flatPos select 2)];
	
	//--------------------- Spawn artillery target at selected positions
	
	_priorityGroup = createGroup EAST;
	priorityVeh1 = "O_MBT_02_arty_F" createVehicle _flatPosAlt;
	waitUntil {!isNull priorityVeh1};
	priorityVeh2 = "O_MBT_02_arty_F" createVehicle _flatPosClose;
	waitUntil {!isNull priorityVeh2};
	priorityVeh1 lock 3;
	priorityVeh2 lock 3;
	
	priorityVeh1 addEventHandler["Fired",{if (!isPlayer (gunner priorityVeh1)) then { priorityVeh1 setVehicleAmmo 1; };}];
	priorityVeh2 addEventHandler["Fired",{if (!isPlayer (gunner priorityVeh2)) then { priorityVeh2 setVehicleAmmo 1; };}];

	"O_crew_F" createUnit [_flatPosAlt, _priorityGroup, "priorityTarget1 = this; this moveInGunner priorityVeh1;"];
	"O_crew_F" createUnit [_flatPosClose, _priorityGroup, "priorityTarget2 = this; this moveInGunner priorityVeh2;"];

	waitUntil {alive priorityTarget1 && alive priorityTarget2};
	priorityTargets = [priorityTarget1, priorityTarget2];
	{ publicVariable _x; } forEach ["priorityTarget1", "priorityTarget2", "priorityTargets", "priorityVeh1", "priorityVeh2"];
	
	//-------------------- Small sleep to let units settle in
	
	sleep 10;

	//-------------------- Define unitsArray for deletion after completion
	
	_unitsArray = [PriorityTarget1, PriorityTarget2, priorityVeh1, priorityVeh2];

	//-------------------- Spawn H-Barrier cover "Land_HBarrierBig_F"
	
	_distance = 20;
	_dir = 0;
	for "_c" from 0 to 11 do
	{
		_pos = [_flatPos, _distance, _dir] call BIS_fnc_relPos;
		_barrier = "Land_HBarrierBig_F" createVehicle _pos; //Land_HBarrierBig_F or Land_HBarrier_3_F
		waitUntil {alive _barrier};
		_barrier setDir _dir;
		_dir = _dir + 30;
		
		_unitsArray = _unitsArray + [_barrier];
	};

	//-------------------- Spawn some enemies protecting the units
	
	for "_c" from 0 to 1 do
	{
		_randomPos = [[[_flatPos, 200],[]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
		[(units _spawnGroup)] call QS_fnc_setSkill1;
		
		_unitsArray = _unitsArray + [_spawnGroup];
	};
	
	for "_c" from 0 to 1 do
	{
		_randomPos = [[[_flatPos, 200],[]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSquad")] call BIS_fnc_spawnGroup;
		[_spawnGroup, _flatPos] call BIS_fnc_taskDefend;
		[(units _spawnGroup)] call QS_fnc_setSkill1;
		
		_unitsArray = _unitsArray + [_spawnGroup];
	};

	for "_c" from 0 to 1 do
	{
		_artySniperGroup = createGroup east;
		_randomPos = [_flatPos, 400, 50] call BIS_fnc_findOverwatch;
		_artySniperGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
		[(units _artySniperGroup)] call QS_fnc_setSkill3;
		_artySniperGroup setBehaviour "COMBAT";
				
		_unitsArray = _unitsArray + [_artySniperGroup];
	};
	
	for "_c" from 0 to 1 do
	{
		_randomPos = [[[_flatPos, 200],[]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT")] call BIS_fnc_spawnGroup;
		[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
		[(units _spawnGroup)] call QS_fnc_setSkill1;
				
		_unitsArray = _unitsArray + [_spawnGroup];
	};
	
		_carGroup = createGroup east;
		_randomPos = [[[_flatPos, 200],[]],["water","out"]] call BIS_fnc_randomPos;
		_car = "O_MRAP_02_hmg_F" createVehicle _randomPos;
		waitUntil{!isNull _car};

			"O_soldier_repair_F" createUnit [_randomPos,_carGroup];
			"O_crew_F" createUnit [_randomPos,_carGroup];

			((units _carGroup) select 0) assignAsDriver _car;
			((units _carGroup) select 1) assignAsGunner _car;
			((units _carGroup) select 0) moveInDriver _car;
			((units _carGroup) select 1) moveInGunner _car;
			
		[_carGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
		_unitsArray = _unitsArray + [_carGroup];
		[(units _carGroup)] call QS_fnc_setSkill1;
		_car lock 3;	
	

	//--------------------------- Set marker up
	
	_fuzzyPos = 
	[
		((_flatPos select 0) - 300) + (random 600),
		((_flatPos select 1) - 300) + (random 600),
		0
	];

	{ _x setMarkerPos _fuzzyPos; } forEach ["priorityMarker", "priorityCircle"];
	"priorityMarker" setMarkerText "Priority Target: Artillery";
	publicVariable "priorityMarker";
	priorityTargetUp = true;
	priorityTargetText = "Artillery";
	publicVariable "priorityTargetUp";
	publicVariable "priorityTargetText";

	//---------------------------- Send Global Hint
	
	GlobalHint = _briefing; publicVariable "GlobalHint"; hint parseText _briefing;
	showNotification = ["NewPriorityTarget", "Destroy Artillery"]; publicVariable "showNotification";

	//----------------------------- Wait for 1-2 minutes while the mortars "set up"
	
	sleep (random 60);
	
	//----------------------------- Set mortars attacking while still alive
	
	_firingMessages = [
		"Thermal scans are picking up those enemy Artillery firing! Heads down!",
		"Enemy Artillery rounds incoming! Advise you seek cover immediately.",
		"OPFOR Artillery rounds incoming! Seek cover immediately!",
		"The Artillery team's firing, boys! Down on the ground!",
		"Get that damned Artillery team down; they're firing right now! Seek cover!",
		"They're zeroing in! Incoming Artillery fire; heads down!"
	];
	
	//---------------------------- Declared here so we can "zero in" gradually 
	
	_radius = 120; // default 80
	
	while {alive priorityTarget1 || alive priorityTarget2} do {
		
		_accepted = false;
		_unit = objNull;
		_targetPos = [0,0,0];
		
		while {!_accepted} do {
			_unit = (playableUnits select (floor (random (count playableUnits))));
			_targetPos = getPos _unit;
			
			if ((_targetPos distance (getMarkerPos "aoMarker")) < 3000 && vehicle _unit == _unit && side _unit == WEST) then { _accepted = true; }
			else {
			sleep 30;
			};	
		};
		
		if (PARAMS_ArtilleryTargetTickWarning == 1) then {
			hqSideChat = _firingMessages call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		};
		
		_dir = [_flatPos, _targetPos] call BIS_fnc_dirTo;
		{ _x setDir _dir; } forEach [priorityVeh1, priorityVeh2];
		sleep 5;
		{
			if (alive _x) then {
				for "_c" from 0 to 3 do {
					_pos = 
					[
						(_targetPos select 0) - _radius + (2 * random _radius),
						(_targetPos select 1) - _radius + (2 * random _radius),
						0
					];
					_x doArtilleryFire [_pos, "32Rnd_155mm_Mo_shells", 1];
					sleep 4; // 8
				};
			};
		} forEach priorityTargets;
		
		//---------------------------- Zero in on target
		
		if (_radius > 10) then { _radius = _radius - 10; };
		
		if (PARAMS_ArtilleryTargetTickTimeMax <= PARAMS_ArtilleryTargetTickTimeMin) then {
			sleep PARAMS_ArtilleryTargetTickTimeMin;
		} else {
			sleep (PARAMS_ArtilleryTargetTickTimeMin + (random (PARAMS_ArtilleryTargetTickTimeMax - PARAMS_ArtilleryTargetTickTimeMin)));
		};
	};
	
	//---------------------------- Send completion hint
	
	GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
	showNotification = ["CompletedPriorityTarget", "Enemy Artillery Neutralised"]; publicVariable "showNotification";
	
	//----------------------------- Set global VAR saying mission is complete
	
	priorityTargetUp = false;
	publicVariable "priorityTargetUp";

	//--------------------------- Hide markers
	
	"priorityMarker" setMarkerPos [-10000,-10000,-10000];
	"priorityCircle" setMarkerPos [-10000,-10000,-10000];
	publicVariable "priorityMarker";
	
	//---------------------------- Delete
	
		sleep 120;
	
		for "_c" from 0 to (count _unitsArray) do
		{
			_obj = _unitsArray select _c;
			_isGroup = false;
			if (_obj in allGroups) then { _isGroup = true; } else { _isGroup = false; };
			if (_isGroup) then
			{
				{
					if (!isNull _x) then
					{
						deleteVehicle _x;
					};
				} forEach (units _obj);
				deleteGroup _obj;
			} else {
				if (!isNull _obj) then
				{
					deleteVehicle _obj;
				};
			};
		};
};