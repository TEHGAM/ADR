/*
author: Unknown

description: spawn an ammo cache as subobjective

Last modified: 12/12/2017 by stanhope

Modified: made more sturdy, hopefully preventing it from buging out again
*/
private ["_cacheBuilding"];
private _aoLoaction = getMarkerPos currentAO;
publicVariable "currentAO";
private _cacheBuildingArray = nearestObjects [_aoLoaction, ["house", "building"], 700];
private _cacheBuildingArrayCount = count _cacheBuildingArray;
private _accepted = false;
private _i = 0;
private _cacheBuildingLocationFinal = [0,0,0];
ammoCrate = objNull;

if (_cacheBuildingArrayCount > 0) then {
	while {!_accepted} do {
		_cacheBuilding = selectRandom _cacheBuildingArray;
		if ((count (_cacheBuilding buildingPos -1)) > 0) then {
			_cacheBuildingLocationFinal = selectRandom (_cacheBuilding buildingPos -1);
			if !(_cacheBuildingLocationFinal isEqualTo [0,0,0]) then {
				ammoCrate = createVehicle ["O_supplyCrate_F", _cacheBuildingLocationFinal, [], 0, "CAN_COLLIDE"];
				_accepted = true;
			};
		};
		_i = _i + 1;
		if (_i > 1000) exitWith {_accepted = false; subObjComplete = 1;}
	};
} else {
	subObjComplete = 1;
};

if (_accepted) then {

	private _fuzzyPos = [(((getPos ammoCrate) select 0) - 200) + (random 400),(((getPos ammoCrate) select 1) - 200) + (random 400),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["radioMarker","radioCircle"];
	"radioMarker" setMarkerText "Sub-Objective: Cache";
	if ((getMarkerPos "radioMarker") isEqualTo [0,0,0]) exitWith {subObjComplete = 1;};

	private _defenders = [_cacheBuilding] call AW_fnc_buildingDefenders;
	private _targetStartText = format[
	"<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Supply Cache</t><br/>____________________
	<br/>We have received intel from local resistance fighters that OPFOR have hidden a weapons cache in the area. Take it out and expect it to be guarded.<br/><br/>"];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
	[west,["SubAoTask","MainAoTask"],["We have received intel from local resistance fighters that OPFOR have hidden a weapons cache in the area. Take it out and expect it to be guarded."
	,"Ammo Cache","radioCircle"],(getMarkerPos "radioCircle"),"Created",0,true,"destroy",true] call BIS_fnc_taskCreate;

	ammoCrate addEventHandler ["Killed",{
		params ["_unit","","_killer"];
		_name = name _killer;
		if (_name == "Error: No vehicle") then{
			_name = "Someone";
		};
		_aoName = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "name") call BIS_fnc_getCfgData;
		_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Cache Destroyed</t><br/>____________________<br/>%2 destroyed the cache in %1, good job everyone!",_aoName,_name];
		[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
	}];

	[ammoCrate,"Plant charges",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\destroy_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
    "_target distance _this <= 5","_target distance _this <= 5",
    {   hint "Planting charges ...";
         params ["","_hero"];
        if ( currentWeapon _hero != "" ) then
        {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
        _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
    },{},{

	_aoName = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "name") call BIS_fnc_getCfgData;
	_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Charges planted</t><br/>____________________<br/>%Charges have been planted on the cache in %1.  Get clear it will blow in 30 seconds!",_aoName];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
	private _ammoCrate = _this select 0;
	[_ammoCrate] spawn {
		sleep 30;
		if (alive (_this select 0)) then {
			_pos = getPos (_this select 0);
			"Bo_GBU12_LGB" createVehicle _pos;
			sleep 4 + (random 3);
			"SmallSecondary" createVehicle (_pos getPos [random 1, random 360]);
			sleep 0.2;
			"SmallSecondary" createVehicle (_pos getPos [random 1, random 360]);
			sleep 2 + (random 2);
			"SmallSecondary" createVehicle (_pos getPos [random 2, random 360]);
			sleep 1 + (random 2);
			"SmallSecondary" createVehicle (_pos getPos [random 2, random 360]);
			sleep 0.5;
			"SmallSecondary" createVehicle (_pos getPos [random 2, random 360]);
		};

	}},
    {   hint "You stopped planting charges.";
        private _unit = _this select 1;
        _unit playMoveNow "";
    },[], 8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];


	waitUntil {sleep 5; !alive ammoCrate || !missionActive};

	["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
	sleep 5;
	["SubAoTask",west] call bis_fnc_deleteTask;
	{ [_x] spawn AW_fnc_SMdelete } forEach [_defenders];
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];

} else {
	subObjComplete = 1;
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];
};
