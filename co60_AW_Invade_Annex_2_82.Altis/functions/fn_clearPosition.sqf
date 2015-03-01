/*
Author: 

	Quiksilver
	
Last modified:

	17/07/2014 ArmA 1.24 by Quiksilver

Description: 

	Clear position of obstructions that could cause ArmA 3 signature spontaneous combustion.
	Send obstructions to safe positions nearby
	
Syntax:

	[center position,radius to sweep,min dist to relocate,max dist to relocate] call QS_fnc_clearPosition
	
_________________________________________________________________*/

private ["_pos","_rad","_dir","_obstructions","_obstructions2","_obstructionsArray","_obstructions2Array","_minDistFromCenter","_maxDistFromCenter","_accepted","_safePos","_emptyPosition","_obstructionsDead"];

_pos = _this select 0;
_rad = _this select 1;
_minDist = _this select 2;
_maxDist = _this select 3;

_obstructions2Array = _pos nearEntities [allDead,_rad];

{deleteVehicle _x;} count _obstructions2Array;

_obstructions = ["Air","LandVehicle","StaticWeapon","Ship"];
_obstructionsArray = _pos nearEntities [_obstructions,_rad];

{
	_emptyPosition = _pos findEmptyPosition [_minDist,_maxDist,"O_APC_Tracked_02_AA_F"];
	while {count _emptyPosition < 2} do {
		_emptyPosition = _pos findEmptyPosition [_minDist,_maxDist,"O_APC_Tracked_02_AA_F"];
	};
	_x setPos _emptyPosition;
} count _obstructionsArray;