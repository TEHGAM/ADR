/*
 * Author: BACONMOP
 * Populate single Building
 *
 * 
 */ 
#define UrbanUnits ["O_diver_TL_F","O_diver_exp_F","O_diver_F"]

private _spawnedUnits = [];
private _buildingObj = _this select 0;
private _urbanGroup = createGroup east;
_buildingPosArray = (_buildingObj buildingPos -1);
_buildingPosNumber = random (count _buildingPosArray);
for "_x" from 0 to _buildingPosNumber do {
	_lostBuildingPos = _buildingPosArray call BIS_fnc_SelectRandom;
	_buildingPosArray = _buildingPosArray - [_lostBuildingPos];	
};

{
	_x params ["_posX","_posY","_posZ"];
	diag_log format ["x:%1 y:%2 z:%3",_posX,_posY,_posZ];
	_unit = _urbanGroup createUnit [(selectRandom UrbanUnits), [_posX,_posY,_posZ],[],0,"NONE"];
	doStop _unit;
	commandStop _unit;
	_unit disableAI "FSM";
	_unit disableAI "AUTOCOMBAT";
	_unit setPos [_posX,_posY,_posZ];
	_unit setDir (random 360);
	_spawnedUnits pushBack _unit;
} foreach (_buildingPosArray);


_spawnedUnits
