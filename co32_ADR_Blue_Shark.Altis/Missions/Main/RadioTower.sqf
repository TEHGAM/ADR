/*
author: unknown

description: 

Last modified: 16/11/2017 by stanhope

Modified: initial release
*/
private _aoLoaction = getMarkerPos currentAO;
private _flatPos = [];
while {(count _flatPos) < 1} do {
    _position = [[[_aoLoaction, PARAMS_AOSize]],["water","out"]] call BIS_fnc_randomPos;
    _flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
};

radioTower = "Land_TTowerBig_2_F" createVehicle _flatPos;
waitUntil {alive radioTower};
radioTower setVectorUp [0,0,1];
radioTower setDir 0;
_flatPos = getPos radioTower;

_barrier1 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 11, (_flatPos select 1) + 4, 0], [], 0, "CAN_COLLIDE"];
_barrier1 setDir 90;
_barrier2 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 11, (_flatPos select 1) - 6, 0], [], 0, "CAN_COLLIDE"];
_barrier2 setDir 90;
_barrier3 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 9, (_flatPos select 1) + 4, 0], [], 0, "CAN_COLLIDE"];
_barrier3 setDir 90;
_barrier4 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 9, (_flatPos select 1) - 6, 0], [], 0, "CAN_COLLIDE"];
_barrier4 setDir 90;
_barrier5 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 6, (_flatPos select 1) + 9, 0], [], 0, "CAN_COLLIDE"];
_barrier6 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 4, (_flatPos select 1) + 9, 0], [], 0, "CAN_COLLIDE"];
_barrier7 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) + 6, (_flatPos select 1) - 11, 0], [], 0, "CAN_COLLIDE"];
_barrier8 = createVehicle ["Land_HBarrier_Big_F", [(_flatPos select 0) - 4, (_flatPos select 1) - 11, 0], [], 0, "CAN_COLLIDE"];
_spawnedObjects = [_barrier1,_barrier2,_barrier3,_barrier4,_barrier5,_barrier6,_barrier7,_barrier8];
	
{_x setVectorUp surfaceNormal position _x;} forEach _spawnedObjects;
//Spawn mines, 12 for each 90° around the RT
for "_i" from 1 to 12 do {
	_minePos = radioTower getPos [random [3, 6, 10]  , random(90)];
	_mine = createMine ["APERSMine", _minePos, [],0];
	_spawnedObjects pushBack _mine;
};
for "_i" from 1 to 12 do {
	_minePos = radioTower getPos [random [3, 6, 10]  , 90+ random(90)];
	_mine = createMine ["APERSMine", _minePos, [],0];
	_spawnedObjects pushBack _mine;
};
for "_i" from 1 to 12 do {
	_minePos = radioTower getPos [random [3, 6, 10]  , 180 + random(90)];
	_mine = createMine ["APERSMine", _minePos, [],0];
	_spawnedObjects pushBack _mine;
};
for "_i" from 1 to 12 do {
	_minePos = radioTower getPos [random [3, 6, 10]  , 270 + random(90)];
	_mine = createMine ["APERSMine", _minePos, [],0];
	_spawnedObjects pushBack _mine;
};

radioTower addEventHandler ["Killed",{
    params ["_unit","","_killer"];
    _name = name _killer;
    if (_name == "Error: No vehicle") then{
		_name = "someone";
    };
	_aoName = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "name") call BIS_fnc_getCfgData;
    _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job with that radio tower, %2 destroyed it. OPFOR should have a tougher time organizing their air efforts in %1.",_aoName,_name];
    [_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
}];

{ _x setMarkerPos _flatPos; } forEach ["radioMarker"/*,"radioCircle"*/];
"radioMarker" setMarkerText "Sub-Objective: Radio Tower";
private _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Radio Tower</t><br/>____________________
<br/>OPFOR have setup a radio communications tower in the AO. Take it out quickly or else they will use it to call in air strikes.<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
[west,["SubAoTask","MainAoTask"],[
"OPFOR have setup a radio communications tower in the AO. Take it out quickly or else they will use it to call in air strikes.  Here is a picture someone managed to take of one of those radiotowers: <br/><br/><img image='Media\Briefing\radioTower.jpg' width='300' height='150'/>",
"Radio Tower","radioMarker"],(getMarkerPos "radioMarker"),"Created",0,true,"destroy",true] call BIS_fnc_taskCreate;

[]spawn {
    sleep (30 + (random 120));
    while {(alive radioTower)} do {
        if (jetCounter < 3) then {
            [] call AW_fnc_airfieldJet;
        };
       sleep (720 + (random 480));
    };
};
waitUntil {sleep 5; !alive radioTower};

["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
sleep 5;
["SubAoTask",west] call bis_fnc_deleteTask;
[_flatPos, _spawnedObjects]spawn {
	sleep 120;
	deleteVehicle nearestObject[(_this select 0), "Land_TTowerBig_2_ruins_F"];
	{
		if (!(isNull _x) && {alive _x}) then {
			deleteVehicle _x;
		};
	} foreach (_this select 1);
};

    
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];