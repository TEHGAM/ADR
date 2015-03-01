/*
Author: 

	Quiksilver

Last modified: 

	12/05/2014

Description:

	Main AO mission control
		
______________________________________________*/

private ["_mission","_missionList","_currentMission","_nextMission","_loopTimeout"];

_loopTimeout = 20;

_missionList = [
	"regionNW",
	"regionNE",
	"regionSW",
	"regionSE",
	"regionCE"
];

//if (PARAMS_AOReinforcementJet == 1) then {_null = [] execVM "mission\main\CAS.sqf";};		

/*
_currentMission = execVM "mission\main\region\regionCE.sqf";

waitUntil {
	sleep 5;
	scriptDone _currentMission
};
*/

while { true } do {	
	
	_mission = _missionList call BIS_fnc_selectRandom;
	_currentMission = execVM format ["mission\main\region\%1.sqf", _mission];
	
	waitUntil {
		sleep 5;
		scriptDone _currentMission
	};
	sleep _loopTimeout;
};
	
	
