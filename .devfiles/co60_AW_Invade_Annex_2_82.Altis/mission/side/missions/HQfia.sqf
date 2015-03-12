/*
@file: HQfia.sqf
Author:

	Quiksilver
	
Last modified:

	24/04/2014
	
Description:

	Secure HQ supplies before destroying it.
	Enemy type is FIA resistance who are hostile to blufor.

____________________________________*/

private ["_flatPos","_accepted","_position","_enemiesArray","_fuzzyPos","_x","_briefing","_unitsArray","_object","_SMveh","_SMaa","_tower1","_tower2","_tower3","_c4Message"];

_c4Message = ["Supply crate secured. The charge has been set! 30 seconds until detonation.","Weapons secured. The explosives have been set! 30 seconds until detonation.","Insurgents supply secured. The charge is planted! 30 seconds until detonation."] call BIS_fnc_selectRandom;

//-------------------- FIND POSITION FOR OBJECTIVE

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Dome_Small_F",0,false];
		};

		if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700 && (_flatPos distance (getMarkerPos currentAO)) > 500) then {
			_accepted = true;
		};
	};

//-------------------- SPAWN OBJECTIVE

	sideObj = "Land_Cargo_HQ_V2_F" createVehicle _flatPos;
	waitUntil {alive sideObj};
	sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), (getPos sideObj select 2)];
	sideObj setVectorUp [0,0,1];
	
	_object = [crate3,crate4] call BIS_fnc_selectRandom;
	_object setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) + 2)];
	sleep 0.3;
	_tower1 = [sideObj, 50, 0] call BIS_fnc_relPos;
	_tower2 = [sideObj, 50, 120] call BIS_fnc_relPos;
	_tower3 = [sideObj, 50, 240] call BIS_fnc_relPos;
	sleep 0.3;
	tower1 = "Land_Cargo_Patrol_V2_F" createVehicle _tower1;
	tower2 = "Land_Cargo_Patrol_V2_F" createVehicle _tower2;
	tower3 = "Land_Cargo_Patrol_V2_F" createVehicle _tower3;
	sleep 0.3;
	tower1 setDir 180;
	tower2 setDir 300;
	tower3 setDir 60;
	
	{ _x allowDamage false } forEach [tower1,tower2,tower3];
	sleep 0.3;

//-------------------- SPAWN FORCE PROTECTION


	_enemiesArray = [sideObj] call QS_fnc_SMenemyFIA;
		

//-------------------- SPAWN BRIEFING

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Secure Insurgency Supply"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Side Mission: Secure Insurgency Supply"; publicVariable "sideMarker";
	publicVariable "sideObj";
	
	_briefing = "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Secure Insurgency Supply</t><br/>____________________<br/>OPFOR are training an insurgency on Altis.<br/><br/>We've marked the position on your map; head over there, sanitize the area and secure their supply.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["NewSideMission", "Secure Insurgency Supply"]; publicVariable "showNotification";
	sideMarkerText = "Secure Insurgency Supply"; publicVariable "sideMarkerText";
	
//-------------------- [ CORE LOOPS ] ------------------------ [ CORE LOOPS ]

	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";

while { sideMissionUp } do {

	//--------------------------------------------- IF PACKAGE DESTROYED [FAIL]

	if (!alive sideObj) exitWith {
		
		//-------------------- DE-BRIEFING
		
		sideMissionUp = false; publicVariable "sideMissionUp";
		hqSideChat = "Objective destroyed! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		[] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		
		//-------------------- DELETE
		
		_object setPos [-10000,-10000,0];
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,tower1,tower2,tower3];
		deleteVehicle nearestObject [getPos sideObj,"Land_Cargo_HQ_V2_ruins_F"];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};
	
	//----------------------------------------------- IF PACKAGE SECURED [SUCCESS]
	
	if (SM_SUCCESS) exitWith {
		
		hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
		//-------------------- BOOM!
	
		sleep 30;											// ghetto bomb timer
		"Bo_Mk82" createVehicle getPos _object; 			// default "Bo_Mk82"
		sleep 0.1;
		_object setPos [-10000,-10000,0];					// hide objective
	
		//-------------------- DE-BRIEFING

		sideMissionUp = false; publicVariable "sideMissionUp";
		[] call QS_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
	
		//--------------------- DELETE
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,tower1,tower2,tower3];
		deleteVehicle nearestObject [getPos sideObj,"Land_Cargo_HQ_V1_ruins_F"];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};
};