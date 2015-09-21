/*
Author: ToxaBes
Description: Infantry Mission control
*/
private ["_mission","_missionList","_currentMission","_delay","_loopTimeout"];

// how often mission will be available (20-30 mins by default)
_delay = 1000 + (random 400);
_loopTimeout = 200 + (random 200);

// list of missions
_missionList = [	
	"heliCrash",
	"heliCrash"
];

infantryMissionUp = false; publicVariable "infantryMissionUp";	
while { true } do {
	if (!infantryMissionUp) then {	
		hqSideChat = "Доступна спецоперация, ждите указаний!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;	
		sleep 5;	
		_mission = _missionList call BIS_fnc_selectRandom;
		_currentMission = execVM format ["mission\infantry\missions\%1.sqf", _mission];	
		waitUntil {
			sleep 5;
			scriptDone _currentMission;
		};		
		sleep _delay;		
	};
	_loopTimeout;
};
