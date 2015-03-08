/*
@file: destroyRadar.sqf
Author:

	Quiksilver
	
Last modified:

	25/04/2014
	
Description:

	Get radar telemetry from enemy radar site, then destroy it.
_________________________________________________________________________*/

private ["_objPos","_flatPos","_accepted","_position","_randomDir","_hangar","_x","_enemiesArray","_briefing","_fuzzyPos","_unitsArray","_dummy","_object","_tower1","_tower2","_tower3"];

_c4Message = ["Radar data secured. The charge has been set! 15 seconds until detonation.","Radar telemetry secured. The explosives have been set! 15 seconds until detonation.","Radar intel secured. The charge is planted! 15 seconds until detonation."] call BIS_fnc_selectRandom;

//-------------------- FIND SAFE POSITION FOR OBJECTIVE

	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5,0,0.1,sizeOf "Land_Radar_Small_F",0,false];

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [5,0,0.1,sizeOf "Land_Radar_Small_F",0,false];
		};

		if ((_flatPos distance (getMarkerPos "respawn_west")) > 1000 && (_flatPos distance (getMarkerPos currentAO)) > 500) then
		{
			_accepted = true;
		};
	};
	
	_objPos = [_flatPos, 15, 30, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

//-------------------- SPAWN OBJECTIVE

	sideObj = "Land_Radar_Small_F" createVehicle _flatPos;
	waitUntil {!isNull sideObj};
	sideObj setDir random 360;
	
	house = "Land_Cargo_House_V3_F" createVehicle _objPos;
	house setDir random 360;
	house allowDamage false;
	
	_dummy = [explosivesDummy1,explosivesDummy2] call BIS_fnc_selectRandom;
	sleep 0.3;
	_object = [research1,research2] call BIS_fnc_selectRandom;
	sleep 0.3;
	{ _x enableSimulation true; } forEach [researchTable,_object];
	sleep 0.3;
	researchTable setPos [(getPos house select 0), (getPos house select 1), ((getPos house select 2) + 1)];
	sleep 1;
	[researchTable,_object,[0,0,0.9]] call BIS_fnc_relPosObject;
	sleep 0.3;
	_tower1 = [sideObj, 50, 0] call BIS_fnc_relPos;
	_tower2 = [sideObj, 50, 120] call BIS_fnc_relPos;
	_tower3 = [sideObj, 50, 240] call BIS_fnc_relPos;
	sleep 0.3;
	tower1 = "Land_Cargo_Patrol_V3_F" createVehicle _tower1;
	tower2 = "Land_Cargo_Patrol_V3_F" createVehicle _tower2;
	tower3 = "Land_Cargo_Patrol_V3_F" createVehicle _tower3;
	sleep 0.3;
	tower1 setDir 180;
	tower2 setDir 300;
	tower3 setDir 60;
	
	{ _x allowDamage false } forEach [tower1,tower2,tower3];
	sleep 0.3;
	

//-------------------- SPAWN FORCE PROTECTION

	_enemiesArray = [sideObj] call QS_fnc_SMenemyEAST;
	
//-------------------- BRIEF

	_fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	"sideMarker" setMarkerText "Side Mission: Secure Radar"; publicVariable "sideMarker";
	publicVariable "sideObj";

	_briefing = "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Secure Radar</t><br/>____________________<br/>OPFOR have captured a small radar on the island to support their aircraft.<br/><br/>We've marked the position on your map; head over there and secure the site. Take the data and destroy it.</t>";
	GlobalHint = _briefing; hint parseText _briefing; publicVariable "GlobalHint";
	showNotification = ["NewSideMission", "Secure Radar"]; publicVariable "showNotification";
	sideMarkerText = "Secure Radar"; publicVariable "sideMarkerText";
	
	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";


while { sideMissionUp } do {

	if (!alive sideObj) exitWith {
		
		//-------------------- DE-BRIEFING
		
		hqSideChat = "Intel destroyed! Mission FAILED!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
		[] spawn QS_fnc_SMhintFAIL;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		sideMissionUp = false; publicVariable "sideMissionUp";
		
		//-------------------- DELETE
		
		{ _x setPos [-10000,-10000,0]; } forEach [_object,researchTable,_dummy];			// hide objective pieces
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,house,tower1,tower2,tower3];
		deleteVehicle nearestObject [getPos sideObj,"Land_Radar_Small_ruins_F"];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};
	
	if (SM_SUCCESS) exitWith {
		
		hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
		//-------------------- BOOM!
		
		_dummy setPos [(getPos sideObj select 0), ((getPos sideObj select 1) +5), ((getPos sideObj select 2) + 0.5)];
		sleep 0.1;
		_object setPos [-10000,-10000,0];					// hide objective
		sleep 12;											// ghetto bomb timer
		"Bo_Mk82" createVehicle getPos _dummy; 				// default "Bo_Mk82","Bo_GBU12_LGB"
		_dummy setPos [-10000,-10000,1];					// hide dummy
		researchTable setPos [-10000,-10000,1];				// hide research table
		sleep 0.1;
	
		//-------------------- DE-BRIEFING

		[] call QS_fnc_SMhintSUCCESS;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
		sideMissionUp = false; publicVariable "sideMissionUp";
	
		//--------------------- DELETE
		sleep 120;
		{ deleteVehicle _x } forEach [sideObj,house,tower1,tower2,tower3];
		deleteVehicle nearestObject [getPos sideObj,"Land_Radar_Small_ruins_F"];
		[_enemiesArray] spawn QS_fnc_SMdelete;
	};
};