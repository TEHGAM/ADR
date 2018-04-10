/*@file: secureRadar.sqf
Author:	Quiksilver

Description: Get radar telemetry from enemy radar site, then destroy it.

Last modified:	10/12/2017 by stanhope
	
modified: unlocked the obj-building
*/

private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2500;
private _enemiesArray = [];

//-------------------- FIND SAFE POSITION FOR OBJECTIVE
private _flatPos = [];
private _accepted = false;

while {!_accepted} do {
	while {(count _flatPos) < 2} do {
		private _position = [] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5,0,0.1,sizeOf "Land_Radar_Small_F",0,false];
	};

	_accepted = true;
	{
		_NearBaseLoc = _flatPos distance (getMarkerPos _x);
		if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
	} forEach _noSpawning;
};
private _objPos = [_flatPos, 15, 30, 10, 0, 0.5, 0] call BIS_fnc_findSafePos;

//-------------------- SPAWN OBJECTIVE

    //define the objective
	sideObj = "Land_Radar_Small_F" createVehicle _flatPos;
	waitUntil {!isNull sideObj};
	sideObj setDir random 360;

    //create house, laptop, table
	private _dummyType = selectRandom["Land_Ammobox_rounds_F","Box_NATO_AmmoOrd_F","Box_NATO_Ammo_F","Box_IED_Exp_F"];
	private _laptopType = selectRandom ["Land_Laptop_unfolded_F","Land_Laptop_device_F","Land_Document_01_F","Land_File_research_F"];

    private _house = "Land_Cargo_House_V3_F" createVehicle _objPos;
    _house setDir 0;
    _house animate ["door_1_rot", 1];
    private _laptop = _laptopType createVehicle _objPos;
    _laptop setDir 0;
	private _table = "Land_CampingTable_small_F" createVehicle _objPos;
	_table setDir 180;
    {_x allowDamage false;} forEach [_laptop,_table];
	sleep 0.3;

    //Move everything to the right place.
    [_house,_table,[0,2.5,0.8]] call BIS_fnc_relPosObject;
	[_table,_laptop,[0,0,0.8]] call BIS_fnc_relPosObject;

    //put holdaction on laptop
	[_laptop,"Secure intel",
	"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
	"_target distance _this <= 4","_target distance _this <= 4",
	{
		hint "Downloading radar codes...";
		params ["","_hero"];
		if ( currentWeapon _hero != "" ) then
		{	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
		_hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
	},{},{execVM "missions\side\actions\recover.sqf";},
	{
		hint "You stop downloading the codes.";
		private _unit = _this select 1;
		_unit playMoveNow "";
	},[],
	8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

    //spawn ambient towers
	private _tower1Pos = sideObj getPos [50, 0];
	private _tower2Pos = sideObj getPos [50, 120];
	private _tower3Pos = sideObj getPos [50, 240];
	
	private _tower1 = "Land_Cargo_Patrol_V3_F" createVehicle _tower1Pos;
	private _tower2 = "Land_Cargo_Patrol_V3_F" createVehicle _tower2Pos;
	private _tower3 = "Land_Cargo_Patrol_V3_F" createVehicle _tower3Pos;
	
	_tower1 setDir 180;
	_tower2 setDir 300;
	_tower3 setDir 60;

    private _towerGarrisonPos = [];
	{
	    _x allowDamage false;
	     private _towerXGarrison = _x buildingPos -1; /*To get garrison positions for later use*/
	     _towerGarrisonPos = _towerGarrisonPos + _towerXGarrison;
	} forEach [_tower1,_tower2,_tower3];
	sleep 0.3;

	//garrison the towers
	private _garrisongroup = createGroup east;
    private _Garrisonpos = count _towerGarrisonPos;
    for "_i" from 1 to (_Garrisonpos) do {
        _unitpos = selectRandom _towerGarrisonPos;
        _towerGarrisonPos = _towerGarrisonPos - [_unitpos];
        _unittype = selectRandom ["O_Soldier_F","O_Soldier_AR_F","O_soldier_M_F","O_Soldier_LAT_F","O_HeavyGunner_F","O_Sharpshooter_F"];
        _unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
        _unit disableAI "PATH";
        sleep 0.1;
    };
    _garrisongroup setGroupIdGlobal [format ['Side-towerGarrison']];
    _enemiesArray = units _garrisongroup;
    {_x addCuratorEditableObjects [units _garrisongroup, false];} forEach allCurators;

//-------------------- SPAWN FORCE PROTECTION
_enemiesArray = _enemiesArray + [sideObj] call AW_fnc_SMenemyEAST;

//-------------------- BRIEF
private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
sideMarkerText = "Secure Radar";
publicVariable "sideMarkerText";
"sideMarker" setMarkerText "Side Mission: Secure Radar";
[west,["secureRadarTask"],["OPFOR have captured a small radar on the island to support their aircraft. We've marked the position on your map; head over there and secure the site. First take the data and then destroy it.","Side Mission: Secure Radar","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;

//====== MISSION CORE=======
    sideMissionSpawnComplete = true;
	publicVariableServer "sideMissionSpawnComplete";
    sideMissionUp = true;
    SM_SUCCESS = false;

waitUntil {sleep 5; !sideMissionUp || SM_SUCCESS || !alive sideObj};

if (!alive sideObj) then {

    //-------------------- DE-BRIEFING
    ["secureRadarTask", "Failed",true] call BIS_fnc_taskSetState;
    sideMissionUp = false;
    SM_SUCCESS = false;
    deleteVehicle _laptop;
};

if (SM_SUCCESS) then {

    //-------------------- BOOM!
    deleteVehicle _laptop;
    sleep 30;	    										// ghetto bomb timer
    "Bo_Mk82" createVehicle _flatPos; 				    // default "Bo_Mk82","Bo_GBU12_LGB"
    [] call AW_fnc_SMhintSUCCESS;
	sideMissionUp = false;
	sleep 4 + (random 3);
	"SmallSecondary" createVehicle (_objPos getPos [random 2, random 360]);
	["secureRadarTask", "Succeded",true] call BIS_fnc_taskSetState;
	sleep 0.2;
	"SmallSecondary" createVehicle (_objPos getPos [random 2, random 360]);
	sleep 2 + (random 2);
	"SmallSecondary" createVehicle (_objPos getPos [random 3, random 360]);
	sleep 1 + (random 2);
	"SmallSecondary" createVehicle (_objPos getPos [random 3, random 360]);
	sleep 0.2;
	"SmallSecondary" createVehicle (_objPos getPos [random 4, random 360]);
   
};

 sleep 5;
["secureRadarTask",west] call bis_fnc_deleteTask;
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"]; publicVariable "sideMarker";
sideMissionUp = false; publicVariable "sideMissionUp";

//--------------------- DELETE
sleep 120;
{ deleteVehicle _x } forEach [_house,_tower1,_tower2,_tower3, _table];

if (!alive sideObj)then {
    deleteVehicle nearestObject [_flatPos,"Land_Radar_Small_ruins_F"];
} else {
    deleteVehicle sideObj
};
[_enemiesArray] spawn AW_fnc_SMdelete;