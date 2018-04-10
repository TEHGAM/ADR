/*
@filename: secureIntelVehicle.sqf
Author:

	Quiksilver

Description:

	Recover intel from a vehicle (add Action)
		If driver sees you, will attempt escape.
			If escapes, mission fail.
		If vehicle destroyed, mission fail.
		If intel recovered, mission success.

Last modified:

	29/07/2017 by stanhope
	
modified:
	
	pos finder

		
Status:

	20/04/2014
	WIP Third pass
	Open beta

Notes / To Do:

	- Locality issues and variables? Seems okay for now, but still work on the Side Mission selector.
	- remove action after completion?
	- [_intelObj,"AW_fnc_removeAction",nil,true] spawn BIS_fnc_MP;
	- Create ambush
	- Increase sleep timer before delete, too tight!

___________________________________________________________________________*/

#define OBJVEH_TYPES "O_MRAP_02_F","I_MRAP_03_F"
#define OBJUNIT_TYPES "O_officer_F","O_Soldier_SL_F","O_recon_TL_F","O_diver_TL_F"

private ["_x","_targetTrigger","_aGroup","_bGroup","_cGroup","_objUnit1","_objUnit2","_objUnit3","_obj1","_obj2","_obj3","_intelObj","_enemiesArray","_randomDir","_poi","_flatPos","_flatPos1","_flatPos2","_flatPos3","_position","_accepted","_fuzzyPos","_briefing","_escapeWP"];

private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2000;

//-------------------------------------------------------------------------- FIND POSITION FOR VEHICLE

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];
		};

		_accepted = true;
		{
			_NearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
		} forEach _noSpawning;
	};

//-------------------------------------------------------------------------- NEARBY POSITIONS TO SPAWN STUFF (THEY SPAWN IN TRIANGLE SO NO ONE WILL KNOW WHICH IS THE OBJ VEHICLE. HEHEHEHE.

	_flatPos1 = [_flatPos, 2, random 360] call BIS_fnc_relPos;
	_flatPos2 = [_flatPos, 10, random 360] call BIS_fnc_relPos;
	_flatPos3 = [_flatPos, 15, random 360] call BIS_fnc_relPos;
//-------------------------------------------------------------------------- CREATE GROUP, VEHICLE AND UNIT

	_aGroup = createGroup east;
	_bGroup = createGroup east;
	_cGroup = createGroup east;

	//--------- OBJ 1

	_obj1 = [OBJVEH_TYPES] call BIS_fnc_selectRandom createVehicle _flatPos;
	waitUntil {sleep 0.3; alive _obj1};
	_obj1 setDir (random 360);

	sleep 0.3;

	"O_officer_F" createUnit [_flatPos1, _aGroup];
	_objUnit1 = ((units _aGroup) select 0);
		((units _aGroup) select 0) assignAsDriver _obj1;
		((units _aGroup) select 0) moveInDriver _obj1;

	//--------- OBJ 2

	_obj2 = [OBJVEH_TYPES] call BIS_fnc_selectRandom createVehicle _flatPos2;
	waitUntil {sleep 0.3; alive _obj2};
	_obj2 setDir (random 360);

	sleep 0.3;

	"O_officer_F" createUnit [_flatPos1, _bGroup];
	_objUnit2 = ((units _bGroup) select 0);
		((units _bGroup) select 0) assignAsDriver _obj2;
		((units _bGroup) select 0) moveInDriver _obj2;

	//-------- OBJ 3

	_obj3 = [OBJVEH_TYPES] call BIS_fnc_selectRandom createVehicle _flatPos3;
	waitUntil {sleep 0.3; alive _obj3};
	_obj3 setDir (random 360);

	sleep 0.3;

	"O_officer_F" createUnit [_flatPos2, _cGroup];
	_objUnit3 = ((units _cGroup) select 0);
		((units _cGroup) select 0) assignAsDriver _obj3;
		((units _cGroup) select 0) moveInDriver _obj3;

	sleep 0.3;

	{ _x lock 3 } forEach [_obj1,_obj2,_obj3];

	sleep 0.3;

//--------------------------------------------------------------------------- ADD ACTION TO OBJECTIVE VEHICLE. NOTE: NEEDS WORK STILL. avoid BIS_fnc_MP! Good enough for now though.

	//---------- WHICH VEHICLE IS THE OBJECTIVE?

	_intelObj = [_obj1,_obj2,_obj3] call BIS_fnc_selectRandom;

	sleep 0.3;

	//---------- OKAY, NOW ADD ACTION TO IT

	[_intelObj,"AW_fnc_addActionGetIntel",nil,true] spawn BIS_fnc_MP;

//--------------------------------------------------------------------------- CREATE DETECTION TRIGGER ON OBJECTIVE VEHICLE

	sleep 0.3;

	_targetTrigger = createTrigger ["EmptyDetector", getPos _intelObj];
	_targetTrigger setTriggerArea [500, 500, 0, false];
	_targetTrigger setTriggerActivation ["WEST", "PRESENT", false];
	_targetTrigger setTriggerStatements ["this","",""];
	sleep 0.3;
	_targetTrigger attachTo [_intelObj,[0,0,0]];
	sleep 0.3;

//--------------------------------------------------------------------------- SPAWN GUARDS

	_enemiesArray = [_obj1] call AW_fnc_SMenemyEASTintel;

//--------------------------------------------------------------------------- BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Secure Intel";
	"sideMarker" setMarkerText "Side Mission: Secure Intel";
    [west,["secureIntelVicTask"],["We have reports from locals that sensitive, strategic information is changing hands. This is a target of opportunity! We've marked the position on your map; head over there and secure the intel. It should be stored on one of the vehicles or on their persons","Side Mission: Secure Intel","sideCircle"], (getMarkerPos "sideCircle"),"Created",0,true,"intel",true] call BIS_fnc_taskCreate;
	sideMarkerText = "Secure Intel";

	sleep 0.3;

	//----- Reset VARS for loops

	sideMissionUp = true;
	NOT_ESCAPING = true;		// is this necessary public?
	GETTING_AWAY = false;		// is this necessary public?
	HE_ESCAPED = false;			// is this necessary public?
	SM_SUCCESS = false;
	sideMissionSpawnComplete = true;
	publicVariableServer "sideMissionSpawnComplete";	
	
	
	sleep 0.3;

//-------------------------- [ CORE LOOPS ] ----------------------------- [ CORE LOOPS ] ---------------------------- [ CORE LOOPS ]

while { sideMissionUp } do {

	sleep 0.3;

	//------------------------------------------ IF VEHICLE IS DESTROYED [FAIL]

	if (!alive _intelObj) exitWith {

		sleep 0.3;

        ["secureIntelVicTask", "Failed",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["secureIntelVicTask",west] call bis_fnc_deleteTask;
		sideMissionUp = false;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker","sideCircle"];

		sleep 120;

		{ deleteVehicle _x } forEach [_targetTrigger,_objUnit1,_objUnit2,_objUnit3,_obj1,_obj2,_obj3];
		[_enemiesArray] spawn AW_fnc_SMdelete;
	};

	//----------------------------------------- IS THE ENEMY TRYING TO ESCAPE?

	if (NOT_ESCAPING) then {

		//---------- NO? then LOOP until YES or an exitWith {}.

		sleep 0.3;

		if (_intelObj call BIS_fnc_enemyDetected) then {

			sleep 0.3;

			hqSideChat = "Target has spotted you and is trying to escape with the intel!";
			[hqSideChat] remoteExec ["AW_fnc_globalSideChat",0,false];

			//---------- WHERE TO / HOW WILL THE OBJECTIVES ESCAPE?

			{
				_escape1WP = _x addWaypoint [getMarkerPos currentAO, 100];
				_escape1WP setWaypointType "MOVE";
				_escape1WP setWaypointBehaviour "CARELESS";
				_escape1WP setWaypointSpeed "FULL";
			} forEach [_aGroup,_bGroup,_cGroup];

			//---------- END THE NOT ESCAPING LOOP

			NOT_ESCAPING = false;

			sleep 0.3;

			//---------- SET GETTING AWAY TO TRUE TO DETECT IF HE'S ESCAPED.

			GETTING_AWAY = true;
		};
	};

	//-------------------------------------------- THE ENEMY IS TRYING TO ESCAPE

	if (GETTING_AWAY) then {

		sleep 0.3;

		//_targetTrigger attachTo [_intelObj,[0,0,0]];

		if (count list _targetTrigger < 1) then {

			sleep 0.3;

			HE_ESCAPED = true;

			sleep 0.3;

			GETTING_AWAY = false;
		};
	};

	//------------------------------------------- THE ENEMY ESCAPED [FAIL]

	if (HE_ESCAPED) exitWith {

            ["secureIntelVicTask", "Failed",true] call BIS_fnc_taskSetState;
            sleep 5;
            ["secureIntelVicTask",west] call bis_fnc_deleteTask;

			sleep 0.3;

			sideMissionUp = false;
			{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker","sideCircle"];

			//---------- DELETE

			{ deleteVehicle _x } forEach [_targetTrigger,_objUnit1,_objUnit2,_objUnit3,_obj1,_obj2,_obj3];
			sleep 120;
			[_enemiesArray] spawn AW_fnc_SMdelete;
	};

	//-------------------------------------------- THE INTEL WAS RECOVERED [SUCCESS]

	if (SM_SUCCESS) exitWith {

		sleep 0.3;

        ["secureIntelVicTask", "Succeeded",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["secureIntelVicTask",west] call bis_fnc_deleteTask;
		sideMissionUp = false;
		[] spawn AW_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker","sideCircle"];

		//---------- REMOVE 'GET INTEL' ACTION

			[_intelObj,"AW_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;

		//---------- DELETE

		sleep 120;

		{ deleteVehicle _x } forEach [_targetTrigger,_objUnit1,_objUnit2,_objUnit3,_obj1,_obj2,_obj3];
		[_enemiesArray] spawn AW_fnc_SMdelete;
	};
	//-------------------- END LOOP
};
