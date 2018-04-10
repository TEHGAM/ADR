/*
author: stanhope, AW community member.

description: 

Last modified: 16/11/2017 by stanhope

Modified: initial release
*/

private _position = [[[getMarkerPos currentAO , PARAMS_AOSize]],["water","out"]] call BIS_fnc_randomPos;
private _flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
while {(count _flatPos) < 2} do {
    _position = [[[getMarkerPos currentAO , PARAMS_AOSize]],["water","out"]] call BIS_fnc_randomPos;
    _flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
};


private _aoTankGroup = createGroup east;
_aoTankGroup setGroupIdGlobal [format ['AO-subobjTanks']];
private _tank1 = createVehicle ["O_MBT_02_cannon_F", _flatPos, [], 0, "NONE"];
private _tank2 = createVehicle ["O_MBT_02_cannon_F", _flatPos, [], 0, "NONE"];
private _tank3 = createVehicle ["O_MBT_02_cannon_F", _flatPos, [], 0, "NONE"];
{
    createVehicleCrew _x;
    (crew _x) join _aoTankGroup;
    sleep 0.1;
    _x lock 3;
    _x allowCrewInImmobile true;
    _x addEventHandler ["Killed",{
        params ["_unit","","_killer"];
        private _name = name _killer;
        if (_name == "Error: No vehicle") then{
			_name = "Someone";
		};
		_aoName = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "name") call BIS_fnc_getCfgData;
        _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Update</t><br/>____________________<br/>%2 destroyed one of the T-100. Good job! Make sure to also find and eliminate the other T-100s at %1.",_aoName,_name];
        [_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
    }];
} forEach [_tank1, _tank2, _tank3];
[_aoTankGroup, _flatPos, 175] call BIS_fnc_taskPatrol;
_aoTankGroup setFormation "COLUMN";
_aoTankGroup setSpeedMode "LIMITED";
{_x addCuratorEditableObjects [units _aoTankGroup + [_tank1,_tank2,_tank3], false];} forEach allCurators;

{_x setMarkerPos _position; } forEach ["radioMarker","radioCircle"];
"radioMarker" setMarkerText "Sub-Objective: T-100 section";
_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>T-100 section</t><br/>____________________<br/>OPFOR have called in a T-100 section.  Find and destroy these MBTs, they must not survive this AO.<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
[west,["SubAoTask","MainAoTask"],["OPFOR have called in a T-100 section.  Find and destroy these MBTs, they must not survive this AO.","T-100 section","radioMarker"],(getMarkerPos "radioMarker"),"Created",0,true,"destroy",true] call BIS_fnc_taskCreate;

waitUntil{!alive _tank1 && !alive _tank2 && !alive _tank3};

["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
sleep 5;
["SubAoTask",west] call bis_fnc_deleteTask;
  
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];
