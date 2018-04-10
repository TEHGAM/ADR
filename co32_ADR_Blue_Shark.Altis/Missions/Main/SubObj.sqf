/*
 Author: BACONMOP
 Description: Creates and handles Sub Objectives
 
 Last edited: 16/11/2017 by stanhope
 
 edited: moved all the code to seperate files and made this a mission control file
 
 */
subObjComplete = 0;

private ["_flatPos"];

private _subObjMission = [
	"AmmoCache",
	"RadioTower",
	"RadioTower",
	"HQ",
	"TankSection",
	"AAA"
];
private _subObj = selectRandom _subObjMission;

private _currentMission = execVM format ["missions\Main\%1.sqf", _subObj];

waitUntil {
    sleep 3;
    scriptDone _currentMission
};

subObjComplete = 1;
