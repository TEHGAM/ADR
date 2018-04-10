/*
Author: BACONMOP
Populate single Building

 
 */

#define UrbanUnits ["O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AAA_F","O_soldierU_AAT_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_soldierU_GL_F","O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AA_F","O_soldierU_AT_F","O_soldierU_repair_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F","O_soldierU_SL_F","O_soldierU_TL_F"]

private _spawnedUnits = [];
private _buildingObj = _this select 0;
private _urbanGroup = createGroup east;
_urbanGroup setGroupIdGlobal [format ['AO-CacheDefenders']];
_buildingPosArray = (_buildingObj buildingPos -1);
_buildingPosNumber = random (count _buildingPosArray);
for "_x" from 0 to _buildingPosNumber do {
	_lostBuildingPos = selectRandom _buildingPosArray;
	_buildingPosArray = _buildingPosArray - [_lostBuildingPos];	
};

    {
        _x params ["_posX","_posY","_posZ"];
        //diag_log format ["x:%1 y:%2 z:%3",_posX,_posY,_posZ];
        _unit = _urbanGroup createUnit [(selectRandom UrbanUnits), [_posX,_posY,_posZ],[],0,"NONE"];
        doStop _unit;
        commandStop _unit;
        _unit disableAI "PATH";
        _unit setPos [_posX,_posY,_posZ];
		_unit setDir (random 360);
        _spawnedUnits pushBack _unit;
    } foreach (_buildingPosArray);
{_x addCuratorEditableObjects [units _urbanGroup, false];} foreach allCurators;
_spawnedUnits
