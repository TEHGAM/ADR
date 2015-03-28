/*
@filename: secureIntelUnit.sqf
Author:

	Quiksilver
	
Description:

	Recover intel from a unit

Status:
	
	29/04/2014
	Second pass
	
Notes / To Do:
	
	- known bug: detection trigger on _intelObj doesnt seem to recognize his position when he is in a cargo seat of a vehicle. Only detects once he gets out.
	
___________________________________________________________________________*/

#define OBJVEH_TYPES "O_MRAP_02_F","I_MRAP_03_F","O_MRAP_02_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F","O_Heli_Light_02_unarmed_F"
#define ALTVEH_TYPES "O_MRAP_02_F"
#define OBJUNIT_TYPES "O_officer_F","I_officer_F","I_Soldier_SL_F","O_Soldier_SL_F","O_recon_TL_F","O_diver_TL_F"

private ["_x","_targetTrigger","_surrenderTrigger","_aGroup","_bGroup","_cGroup","_decoy1","_decoy2","_obj1","_obj2","_obj3","_intelDriver","_decoyDriver1","_decoyDriver2","_intelObj","_enemiesArray","_randomDir","_poi","_flatPos","_flatPos1","_flatPos2","_flatPos3","_position","_accepted","_fuzzyPos","_briefing","_escapeWP","_meetingPos"];

//-------------------------------------------------------------------------- FIND POSITION FOR MISSION

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];
			
		while {(count _flatPos) < 3} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];
		};
				
		if ((_flatPos distance (getMarkerPos "respawn_west")) > 3000 && (_flatPos distance (getMarkerPos currentAO)) > 3000) then {
			_accepted = true;
		};
	};
	
//-------------------------------------------------------------------------- NEARBY POSITIONS TO SPAWN STUFF (THEY SPAWN IN TRIANGLE SO NO ONE WILL KNOW WHICH IS THE OBJ. HEHEHEHE. 
	
	_flatPos1 = [_flatPos, 2, random 360] call BIS_fnc_relPos;
	_flatPos2 = [_flatPos, 10, random 360] call BIS_fnc_relPos;
	_flatPos3 = [_flatPos, 15, random 360] call BIS_fnc_relPos;
	
//-------------------------------------------------------------------------- CREATE GROUP, VEHICLE AND UNIT
	
	_aGroup = createGroup east;
	_bGroup = createGroup east;
	_cGroup = createGroup east;
	_surrenderGroup = createGroup west;
	
	//--------- INTEL OBJ
	
	_obj1 = [OBJVEH_TYPES] call BIS_fnc_selectRandom createVehicle _flatPos;
	waitUntil {sleep 0.3; alive _obj1};
	_obj1 setDir (random 360);
	
	sleep 0.3;
	
	[OBJUNIT_TYPES] call BIS_fnc_selectRandom createUnit [_flatPos1, _aGroup];
	"O_crew_F" createUnit [_flatPos1, _aGroup];
	
	sleep 0.3;
	
	_intelObj = ((units _aGroup) select 0);
	_intelDriver = ((units _aGroup) select 1);
		
	sleep 0.3;
		((units _aGroup) select 0) assignAsCargo _obj1;
		((units _aGroup) select 1) assignAsDriver _obj1;
		((units _aGroup) select 1) moveInDriver _obj1;
	
	//--------- OBJ 2 
	
	_obj2 = [OBJVEH_TYPES] call BIS_fnc_selectRandom createVehicle _flatPos2;
	waitUntil {sleep 0.3; alive _obj2};
	_obj2 setDir (random 360);
	
	sleep 0.3;
	
	[OBJUNIT_TYPES] call BIS_fnc_selectRandom createUnit [_flatPos1, _bGroup];
	"O_crew_F" createUnit [_flatPos1, _bGroup];
	
	sleep 0.3;
	
	_decoy1 = ((units _bGroup) select 0);
	_decoyDriver1 = ((units _bGroup) select 1);
	
	sleep 0.3;
		((units _bGroup) select 0) assignAsCargo _obj2;
		((units _bGroup) select 1) assignAsDriver _obj2;
		((units _bGroup) select 1) moveInDriver _obj2;	
	
	//-------- OBJ 3
	
	_obj3 = [ALTVEH_TYPES] call BIS_fnc_selectRandom createVehicle _flatPos3;
	waitUntil {sleep 0.3; alive _obj3};
	_obj3 setDir (random 360);
	sleep 0.3;
	[OBJUNIT_TYPES] call BIS_fnc_selectRandom createUnit [_flatPos1, _cGroup];
	"O_crew_F" createUnit [_flatPos1, _cGroup];
	sleep 0.3;
	
	_decoy2 = ((units _cGroup) select 0);
	_decoyDriver2 = ((units _cGroup) select 1);
	
	sleep 0.3;
		((units _cGroup) select 0) assignAsCargo _obj3;
		((units _cGroup) select 1) assignAsDriver _obj3;
		((units _cGroup) select 1) moveInDriver _obj3;
	
	//---------- COMMON
	
	{ _x lock 3 } forEach [_obj1,_obj2,_obj3];
	[(units _aGroup)] call QS_fnc_setSkill2;
	[(units _bGroup)] call QS_fnc_setSkill2;
	[(units _cGroup)] call QS_fnc_setSkill2;
	
//--------------------------------------------------------------------------- ADD ACTION TO OBJECTIVE. NOTE: NEEDS WORK STILL. avoid BIS_fnc_MP! Good enough for now though.
	
	sleep 0.1;
	[_intelObj,"QS_fnc_addActionGetIntel",nil,true] spawn BIS_fnc_MP; 
	sleep 0.1;
	[_intelObj,"QS_fnc_addActionSurrender",nil,true] spawn BIS_fnc_MP;
	sleep 0.1;
	removeAllWeapons _intelObj;
	
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

	_enemiesArray = [_obj1] call QS_fnc_SMenemyEASTintel;
	
//--------------------------------------------------------------------------- SPAWN AMBUSH

	/* WIP */
	
//--------------------------------------------------------------------------- BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];			
	sideMarkerText = "Secure Intel"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Side Mission: Secure Intel"; publicVariable "sideMarker"; 	
	_briefing = "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Secure Intel</t><br/>____________________<br/>We have reports from locals that sensitive, strategic information is changing hands. This is a target of opportunity!<br/><br/>We've marked the position on your map; head over there and secure the intel. It should be stored on one of the vehicles or on their persons.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["NewSideMission", "Secure Intel"]; publicVariable "showNotification";
	sideMarkerText = "Secure Intel"; publicVariable "sideMarkerText";
	
	sleep 0.3;
	
	//----- Reset VARS for next time
	
	sideMissionUp = true; publicVariable "sideMissionUp";
	
	NOT_ESCAPING = true; publicVariable "NOT_ESCAPING";
	GETTING_AWAY = false; publicVariable "GETTING_AWAY";		// is this necessary public?
	HE_ESCAPED = false; publicVariable "HE_ESCAPED";			// is this necessary public?
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";
	HE_SURRENDERS = false; publicVariable "HE_SURRENDERS";
	
//-------------------------- [ CORE LOOPS ] ----------------------------- [ CORE LOOPS ] ---------------------------- [ CORE LOOPS ]
	
while { sideMissionUp } do {

	sleep 0.3;

	//------------------------------------------ IF VEHICLE IS DESTROYED [FAIL]
	
	if (!alive _intelObj) exitWith {
	
		sleep 0.3;
		
		//---------- DE-BRIEF
		
		hqSideChat = "Objective destroyed! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		sideMissionUp = false; publicVariable "sideMissionUp";
		[] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		
		//---------- REMOVE ACTION
		
		[_intelObj,"QS_fnc_removeAction",nil,true] spawn BIS_fnc_MP; 
		
		//---------- DELETE
		
		sleep 120;
		{ deleteVehicle _x } forEach [_targetTrigger,_intelObj,_decoy1,_decoy2,_intelDriver,_obj1,_obj2,_obj3,_decoyDriver1,_decoyDriver2];
		[_enemiesArray] spawn QS_fnc_SMdelete;
		
	};
	
	//----------------------------------------- IS THE ENEMY TRYING TO ESCAPE? 
	
	if (NOT_ESCAPING) then {
	
		//---------- NO? then LOOP until YES or an exitWith {}.
	
		sleep 0.3;
	
		if (_intelObj call BIS_fnc_enemyDetected) then {
		
			sleep 0.3;
		
			hqSideChat = "Target has spotted you and is trying to escape with the intel!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		
			//---------- WHERE TO / HOW WILL THE OBJECTIVES ESCAPE?
			
			{
				_escape1WP = _x addWaypoint [getMarkerPos currentAO, 100];	
				_escape1WP setWaypointType "MOVE";
				_escape1WP setWaypointBehaviour "CARELESS";
				_escape1WP setWaypointSpeed "FULL";
			} forEach [_aGroup,_bGroup,_cGroup];
				
			sleep 0.3;
			
			//---------- SET GETTING AWAY TO TRUE TO DETECT IF HE'S ESCAPED.
			
			GETTING_AWAY = true; publicVariable "GETTING_AWAY";
			
			//---------- END THE NOT ESCAPING LOOP
		
			NOT_ESCAPING = false; publicVariable "NOT_ESCAPING";
		};
	};
	
	//-------------------------------------------- THE ENEMY IS TRYING TO ESCAPE
	
	if (GETTING_AWAY) then {
	
		sleep 5;  // too long?
			
		//_targetTrigger attachTo [_intelObj,[0,0,0]];
	
		if (count list _targetTrigger < 1) then {
	
			sleep 0.3;
		
			HE_ESCAPED = true; publicVariable "HE_ESCAPED";
			
			sleep 0.3;
			
			GETTING_AWAY = false; publicVariable "GETTING_AWAY";
		};
		
		//---------- DETECT IF HE SURRENDERS
	
		if (HE_SURRENDERS) then {

			sleep 0.3;
		
			removeAllWeapons _intelObj;
			_intelObj playAction "Surrender";
			_intelObj disableAI "ANIM";	
			[_intelObj] joinSilent _surrenderGroup;
			
			//----- REMOVE 'SURRENDER' ACTION
			
			[_intelObj,"QS_fnc_removeAction1",nil,true] spawn BIS_fnc_MP; 
		};
		
	};
	
	//------------------------------------------- THE ENEMY ESCAPED [FAIL]
	
	if (HE_ESCAPED) exitWith {
			
			//---------- DE-BRIEF
			
			hqSideChat = "Objective escaped! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
			sideMissionUp = false; publicVariable "sideMissionUp";
			[] spawn QS_fnc_SMhintFAIL;
			{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
			
			//---------- DELETE
			
			{ deleteVehicle _x } forEach [_targetTrigger,_intelObj,_decoy1,_decoy2,_intelDriver,_obj1,_obj2,_obj3,_decoyDriver1,_decoyDriver2];
			sleep 120;
			[_enemiesArray] spawn QS_fnc_SMdelete;
	};
	
	//-------------------------------------------- THE INTEL WAS RECOVERED [SUCCESS]
	
	if (SM_SUCCESS) exitWith {
	
		sleep 0.3;
		
		//---------- DE-BRIEF
		
		hqSideChat = "Intel received. Mission accomplished! We're sending the data up to HQ for analysis."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		sideMissionUp = false; publicVariable "sideMissionUp";
		[] spawn QS_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		
		//---------- REMOVE 'GET INTEL' ACTION
		
		[_intelObj,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP; 
		
		//---------- DELETE

		sleep 120;
		{ deleteVehicle _x } forEach [_targetTrigger,_intelObj,_decoy1,_decoy2,_intelDriver,_obj1,_obj2,_obj3,_decoyDriver1,_decoyDriver2];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};	
};

