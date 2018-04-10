#include "unitDefines.hpp"
/*
    Author: alganthe
    Handles creating the AI
    Last Modified: 19/08/2017 by stanhope
    Modified: Group names
*/

params ["_smPos","_radiusSize","_AAAVehcAmount","_MRAPAmount","_randomVehcsAmount","_infantryGroupsAmount","_AAGroupsAmount","_ATGroupsAmount"];
private _spawnedUnits = [];
private _AISkillUnitsArray = [];

//-------------------------------------------------- AA vehicles
private ["_grp1"];
private _AAvicgrpCount = 0;
for "_x" from 1 to _AAAVehcAmount do {

    private _randomPos = [[[_smPos, (_radiusSize / 1.5)], []], ["water", "out"]] call BIS_fnc_randomPos;
	_AAVicList = (missionconfigfile >> "unitList" >> secondaryMainFaction >> "AAvic") call BIS_fnc_getCfgData;
    private _AAVehicle = (selectRandom _AAVicList) createVehicle _randomPos;

    _AAVehicle allowCrewInImmobile true;
    _AAVehicle lock 2;
    _grp1 = createGroup Resistance;
	_AAvicgrpCount = _AAvicgrpCount + 1;
	_grp1 setGroupIdGlobal [format ['Side-AAVic-%1', _AAvicgrpCount]];
    [_AAVehicle,_grp1,secondaryMainFaction] call AW_fnc_createCrew;
    _spawnedUnits pushBack _AAVehicle;

    {
        _spawnedUnits pushBack _x;
    } foreach (crew _AAVehicle);

    private _group = group _AAVehicle;

    [_group, _smPos, _radiusSize / 2] call BIS_fnc_taskPatrol;
    _group setSpeedMode "LIMITED";
};

//-------------------------------------------------- MRAP
private ["_grp1"];
private _MRAPCount = 0;
for "_x" from 1 to _MRAPAmount do {
    private _randomPos = [[[_smPos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
	_MRAPList = (missionconfigfile >> "unitList" >> secondaryMainFaction >> "cars") call BIS_fnc_getCfgData;
    private _MRAP = (selectRandom MRAPList) createVehicle _randompos;

    _MRAP allowCrewInImmobile true;
    _MRAP lock 2;
    _grp1 = createGroup Resistance;
	_MRAPCount = _MRAPCount + 1;
	_grp1 setGroupIdGlobal [format ['Side-MRAP-%1', _MRAPCount]];
    [_MRAP,_grp1,secondaryMainFaction] call AW_fnc_createCrew;
    _spawnedUnits pushBack _MRAP;

    {
        _spawnedUnits pushBack _x;
    } foreach (crew _MRAP);

    private _group = group _MRAP;

    [_group, _smPos, _radiusSize / 3] call BIS_fnc_taskPatrol;
    _group setSpeedMode "LIMITED";
};

//-------------------------------------------------- random vehcs
private ["_grp1"];
private _RandomVicCount = 0;
for "_x" from 1 to _randomVehcsAmount do {
    private _randomPos = [[[_smPos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
	_RandomVehicleList = (missionconfigfile >> "unitList" >> secondaryMainFaction >> "APCs") call BIS_fnc_getCfgData;
    private _vehc = (selectRandom _RandomVehicleList) createVehicle _randompos;

    _vehc allowCrewInImmobile true;
    _vehc lock 2;
    _grp1 = createGroup Resistance;
	_RandomVicCount = _RandomVicCount + 1;
	_grp1 setGroupIdGlobal [format ['Side-RandomVic-%1', _RandomVicCount]];
    [_vehc,_grp1,secondaryMainFaction] call AW_fnc_createCrew;
    _spawnedUnits pushBack _vehc;
    {
        _spawnedUnits pushBack _x;
    } foreach (crew _vehc);
    private _group = group _vehc;

    [_group, _smPos, _radiusSize / 2] call BIS_fnc_taskPatrol;
    _group setSpeedMode "LIMITED";
};

//-------------------------------------------------- main infantry groups
private _MaininfCount = 0;
for "_x" from 1 to _infantryGroupsAmount do {
    private _randomPos = [[[_smPos, _radiusSize * 1.2], []], ["water", "out"]] call BIS_fnc_randomPos;
	private _infantryGroup = createGroup EAST;
	_MaininfCount = _MaininfCount + 1;
	_infantryGroup setGroupIdGlobal [format ['Side-MainInf-%1', _MaininfCount]];
	for "_x" from 1 to 8 do {
		_unitArray = (missionconfigfile >> "unitList" >> secondaryMainFaction >> "units") call BIS_fnc_getCfgData;
		_unit = _unitArray call BIS_fnc_selectRandom;
		_grpMember = _infantryGroup createUnit [_unit, _randomPos, [], 0, "FORM"];
	};

    [_infantryGroup, _smPos, _radiusSize / 1.6] call AW_FNC_taskPatrol;

    {
        _spawnedUnits pushBack _x;
        _AISkillUnitsArray pushBack _x;
    } foreach (units _infantryGroup);
};


//-------------------------------------------------- AA groups
private _AAInfAmount = 0;
for "_x" from 1 to _AAGroupsAmount do {
    private _randomPos = [[[_smPos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
    private _infantryGroup = [_randomPos, EAST, (configfile InfantryGroupsCFGPATH (selectRandom AAGroupsList))] call BIS_fnc_spawnGroup;
	_AAInfAmount = _AAInfAmount + 1;
	_infantryGroup setGroupIdGlobal [format ['Side-AAInf-%1', _AAInfAmount]];

    [_infantryGroup, _smPos, _radiusSize / 1.6] call AW_FNC_taskPatrol;

    {
        _spawnedUnits pushBack _x;
        _AISkillUnitsArray pushBack _x;
    } foreach (units _infantryGroup);
};

//-------------------------------------------------- AT groups
private _ATInfAmount = 0;
for "_x" from 1 to _ATGroupsAmount do {
    private _randomPos = [[[_smPos, _radiusSize], []], ["water", "out"]] call BIS_fnc_randomPos;
    private _infantryGroup = [_randomPos, EAST, (configfile InfantryGroupsCFGPATH (selectRandom ATGroupsList))] call BIS_fnc_spawnGroup;
	_ATInfAmount = _ATInfAmount + 1;
	_infantryGroup setGroupIdGlobal [format ['Side-ATInf-%1', _ATInfAmount]];
    [_infantryGroup, _smPos, _radiusSize / 1.6] call AW_FNC_taskPatrol;

    {
        _spawnedUnits pushBack _x;
        _AISkillUnitsArray pushBack _x;
    } foreach (units _infantryGroup);
};

//-------------------------------------------------- SetSkill + network operations
[_AISkillUnitsArray] call derp_fnc_AISkill;

if (isServer) then {
    {
        _x addCuratorEditableObjects [_spawnedUnits, true];
    } foreach allCurators;
    _spawnedUnits
} else {
    [_spawnedUnits, true] remoteExec ["derp_fnc_remoteAddCuratorEditableObjects", 2];
    spawnedUnits = _spawnedUnits;
    publicVariableServer "spawnedUnits";
    spawnedUnits = nil;
};
