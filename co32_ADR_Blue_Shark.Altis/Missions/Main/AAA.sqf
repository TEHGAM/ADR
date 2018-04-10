/*
author: stanhope, AW community member.

description: spawns a AAA truck as subobj

Last modified: 16/11/2017 by stanhope

Modified: /
*/

private  _position = [[[getMarkerPos currentAO , PARAMS_AOSize]],["water","out"]] call BIS_fnc_randomPos;
private _flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
while {(count _flatPos) < 2} do {
    _position = [[[getMarkerPos currentAO , PARAMS_AOSize]],["water","out"]] call BIS_fnc_randomPos;
    _flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
};

private _aoTankGroup = createGroup east;
_aoTankGroup setGroupIdGlobal [format ['AO-subobjAAA']];

private _truck = "O_Truck_03_transport_F" createVehicle _flatPos;
private _AAA = "B_AAA_System_01_F" createVehicle _flatPos;

_truck setDir 0;
_AAA attachTo [_truck,[0,-2.5,2.1]];
_AAA setDir 180;
_AAA setVehicleRadar 1;
{
    createVehicleCrew _x;
    (crew _x) join _aoTankGroup;
    _x lock 3;
    _x allowCrewInImmobile true;


} forEach [_truck, _AAA];

_AAA addEventHandler ["Killed",{
    params ["_unit","","_killer"];
    _name = name _killer;
	if (_name == "Error: No vehicle") then{
		_name = "someone";
    };
	_aoName = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "name") call BIS_fnc_getCfgData;
    _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Update</t><br/>____________________<br/>%2 destroyed the goalkeeper.  Be sure to also destroy the truck.  CSAT will now have a touhger time keeping a hold of %1.",_aoName,_name];
    [_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
}];

[_aoTankGroup, _flatPos, 175] call BIS_fnc_taskPatrol;
{_x addCuratorEditableObjects [[_truck,_AAA] + units _aoTankGroup, false];} forEach allCurators;

{_x setMarkerPos _position; } forEach ["radioMarker","radioCircle"];
"radioMarker" setMarkerText "Sub-Objective: Goalkeeper";
_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Goalkeeper</t><br/>____________________<br/>OPFOR is fieldtesting their latest prototype AAA system.  A goalkeeper strapped to a transport truck.  Take it out before so they don't get any usefull data from the test.<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
[west,["SubAoTask","MainAoTask"],[
"OPFOR is fieldtesting their latest prototype AAA system.  A goalkeeper strapped to a transport truck.  Take it out before so they don't get any usefull data from the test.  Intel suggest it'll look like this:<br/><br/><img image='Media\Briefing\goalKeeper.jpg' width='300' height='150'/>",
"Goalkeeper","radioMarker"],(getMarkerPos "radioMarker"),"Created",0,true,"destroy",true] call BIS_fnc_taskCreate;

waitUntil{!alive _AAA && !alive _truck};

["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
sleep 5;
["SubAoTask",west] call bis_fnc_deleteTask;
  
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];
