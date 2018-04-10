/*
 * Author: Alganthe
 * Modified By: BACONMOP
 * Populate MilitaryBuildings
 *
 * 
 */


_pos = _this select 0;
_radius = _this select 1;

#define UrbanUnits ["O_soldierU_A_F","O_soldierU_AAR_F","O_soldierU_AAA_F","O_soldierU_AAT_F","O_soldierU_AR_F","O_soldierU_medic_F","O_engineer_U_F","O_soldierU_exp_F","O_soldierU_GL_F","O_Urban_HeavyGunner_F","O_soldierU_M_F","O_soldierU_AA_F","O_soldierU_AT_F","O_soldierU_repair_F","O_soldierU_F","O_soldierU_LAT_F","O_Urban_Sharpshooter_F","O_soldierU_SL_F","O_soldierU_TL_F"]
#define MilitaryBuildings ["Land_Cargo_House_V1_F","Land_Cargo_House_V2_F","Land_Cargo_House_V3_F","Land_Medevac_house_V1_F","Land_Research_house_V1_F","Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V2_F","Land_Cargo_HQ_V3_F","Land_Research_HQ_F","Land_Medevac_HQ_V1_F","Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F","Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V3_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_F"]

private _spawnedUnits = [];
private _milBuildings = nearestObjects [_pos, MilitaryBuildings, 225];

if (count _milBuildings > 0 ) then {
    diag_log format ["stuff started, buildings: %1", _milBuildings];
    private _urbanGroup = createGroup east;

    {
        _x params ["_building"];
        {
            _x params ["_posX","_posY","_posZ"];
            diag_log format ["x:%1 y:%2 z:%3",_posX,_posY,_posZ];
            _unit = _urbanGroup createUnit [(selectRandom UrbanUnits), [_posX,_posY,_posZ],[],0,"NONE"];
            doStop _unit;
            commandStop _unit;
            _unit disableAI "FSM";
            _unit disableAI "AUTOCOMBAT";
            _unit setPos [_posX,_posY,_posZ];

            _spawnedUnits pushBack _unit;
        } foreach (_building buildingPos -1);
    } foreach _milBuildings;
};

_spawnedUnits
