/*
author: McKillen

description: spawns an HQ sub-obj

Last modified: 16/11/2017 by stanhope

Modified: /
*/
private _aoLoaction = getMarkerPos currentAO;
private _flatPos = [];
while {(count _flatPos) < 1} do {
    _position = [[[_aoLoaction, PARAMS_AOSize]],["water","out"]] call BIS_fnc_randomPos;
    _flatPos = _position isFlatEmpty [10,1,0.2,sizeOf "Land_Cargo_HQ_V1_F",0,false];
};
_roughPos =[((_flatPos select 0) - 200) + (random 400),((_flatPos select 1) - 200) + (random 400),0];

//adds in a HQ building and adds an event handler to the officer inside it
HQBuilding = "Land_Cargo_HQ_V1_F" createVehicle _flatPos;
private _HQpos = HQBuilding buildingPos -1;
private _garrisongroup = createGroup east;
_garrisongroup setGroupIdGlobal [format ['AO-subobjgroup']];
private _officerPos = _HQpos select 0;
_HQpos = _HQpos - [_officerPos];
private _unitsarray = [];
officerTarget = _garrisongroup createUnit ["O_officer_F", _officerPos, [], 0, "CAN_COLLIDE"];
_unitsarray = _unitsarray + [officerTarget];
officerTarget disableAI "PATH";
removeAllWeapons officerTarget;
officerTarget addMagazine "6Rnd_45ACP_Cylinder";
officerTarget addWeapon "hgun_Pistol_heavy_02_F";
officerTarget addMagazine "6Rnd_45ACP_Cylinder";
officerTarget addMagazine "6Rnd_45ACP_Cylinder";

officerTarget addEventHandler ["Killed",
    {
        params ["_unit","","_killer"];
        _name = name _killer;
		if (_name == "Error: No vehicle") then{
			_name = "someone";
		};
		_aoName = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "name") call BIS_fnc_getCfgData;
        _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job everyone, %2 neutralised the officer. OPFOR should find it harder to co-ordinate their attacks in %1.",_aoName,_name];
        [_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
    }
];

{ _x setMarkerPos _roughPos; } forEach ["radioMarker","radioCircle"];
"radioMarker" setMarkerText "Sub-Objective: HQ Building";
_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>HQ Building</t><br/>____________________<br/>OPFOR have set up an HQ building in the AO. Inside is an officer, neutralise him using any force necessary<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

[west,["SubAoTask","MainAoTask"],["OPFOR have set up an HQ building in the AO. Inside is an officer, neutralise him using any force necessary","HQ Building","radioMarker"],(getMarkerPos "radioMarker"),"Created",0,true,"destroy",true] call BIS_fnc_taskCreate;
private _infunits = ["O_Soldier_LAT_F", "O_soldier_M_F", "O_Soldier_TL_F", "O_Soldier_AR_F", "O_Soldier_GL_F", "O_Soldier_F", "O_Soldier_F", "O_Soldier_F"];

private _Garrisonpos = count _HQpos;
for "_i" from 1 to _Garrisonpos do {
    _unitpos = selectRandom _HQpos ;
    _HQpos = _HQpos - [_unitpos];
    _unittype = selectRandom _infunits;
    _unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
    _unit disableAI "PATH";
    _unitsarray = _unitsarray + [_unit];
    sleep 0.1;
};
{_x addCuratorEditableObjects [units _garrisongroup, false];} forEach allCurators;

[]spawn {
    sleep (30 + (random 120));
    while {(alive officerTarget)} do {
        if (jetCounter < 3) then {
            [] call AW_fnc_airfieldJet;
        };
       sleep (720 + (random 480));
    };
};

waitUntil {sleep 3; !alive officerTarget};
["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
sleep 5;
["SubAoTask",west] call bis_fnc_deleteTask;
sleep 15;
{deleteVehicle _x}forEach _unitsarray;
if (isNil "HQBuilding") then {
    deleteVehicle (nearestObject [_roughPos, "Land_Cargo_HQ_V1_ruins_F"]);
} else {
    deleteVehicle HQBuilding;
};

{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];