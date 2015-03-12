/*
@file: destroyUrban.sqf
Author:

	Quiksilver 	(credit to Jester [AW] for initial build)
				(credit to chucky [allFPS] for initial help with addAction)	
				(credit to BangaBob [EOS] for EOS)
Last modified:

	29/04/2014
	
Description:

	Objective appears in urban area, with selection of OPFOR Uinfantry, and civilians.
	Inf and civs spawn in foot patrols and randomly placed in and around buildings.
	Vehicle spawning can be unstable and the veh can spawn into buildings.
	Good CQB mission and players seem to enjoy it.

_____________________________________________________________________*/


private ["_object","_briefing","_smPos","_c4Message"];

//-------------------- PREPARE MISSION. SELECT OBJECT, POSITION AND MESSAGES FROM ARRAYS

	_object = [crate1,crate2] call BIS_fnc_selectRandom;
	currentSM = ["sm1","sm2","sm3","sm4","sm5","sm6","sm7","sm8","sm9","sm10","sm11","sm12","sm13","sm14","sm15","sm16","sm17","sm18","sm19"] call BIS_fnc_selectRandom;
	_c4Message = ["The charge has been set! 30 seconds until detonation, get BACK!","The c4 has been set! 30 seconds until detonation, RUN!","The bomb is planted! 30 seconds until detonation, find cover!"] call BIS_fnc_selectRandom;

//-------------------- SPAWN OBJECTIVE (okay okay, setPos not spawn/create)

	_smPos = getMarkerPos currentSM;
	sleep 1;
	_object setPosATL _smPos;

//-------------------- SPAWN GUARDS and CIVILIANS
	
	[[currentSM],[6,1],[7,1],[0,0],[0],[0],[0,0],[5,1,1200,EAST,FALSE,FALSE]] call EOS_Spawn; //guards
	sleep 1;
	[[currentSM],[3,1],[4,1],[0,0],[0],[0],[0,0],[3,1,1100,EAST,FALSE,FALSE]] call EOS_Spawn; //civs

//-------------------- BRIEFING
	
	"sideMarker" setMarkerPos (getMarkerPos currentSM);
	sideMarkerText = "Destroy Weapons Shipment"; publicVariable "sideMarkerText";
	"sideMarker" setMarkerText "Side Mission: Destroy Weapons Shipment"; publicVariable "sideMarker";
	_briefing = "<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy Weapons Shipment</t><br/>____________________<br/>The enemy is supplying insurgents with advanced weapons and explosives. Neutralize them!<br/><br/>We've marked the location on your map; Looks like it's in town. Get your CQB gear ready.</t>";
	GlobalHint = _briefing; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["NewSideMission", "Destroy Weapons Shipment"]; publicVariable "showNotification";
			
	sideMissionUp = true; publicVariable "sideMissionUp";
	SM_SUCCESS = false;	publicVariable "SM_SUCCESS";

//--------------------- WAIT UNTIL OBJECTIVE COMPLETE: Sent to sabotage.sqf to wait for SM_SUCCESS var.

	waitUntil { sleep 3; SM_SUCCESS };
	
//--------------------- BROADCAST BOMB PLANTED
	
	hqSideChat = _c4Message; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
//-------------------- BOOM!
	
	sleep 30;									// ghetto bomb timer
	"M_NLAW_AT_F" createVehicle getPos _object; // default "Bo_Mk82"
	_object setPos [-10000,-10000,0];			// hide objective
	sleep 1;
	
//-------------------- DE-BRIEFING

	sideMissionUp = false; publicVariable "sideMissionUp";
	[] call QS_fnc_SMhintSUCCESS;
	"sideMarker" setMarkerPos [-10000,-10000,-10000]; publicVariable "sideMarker";
	
//--------------------- DELETE, DESPAWN, HIDE and RESET
	
	SM_SUCCESS = false; publicVariable "SM_SUCCESS";			// reset var for next cycle
	sleep 120;													// sleep to hide despawns from players. default 120, 1 for testing	
	[[currentSM]] call EOS_deactivate;							// despawn enemies and civs
