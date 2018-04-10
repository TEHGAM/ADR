/*
Author:	Quiksilver (credit Rarek [AW] for initial design)

Description:
	Secure explosives crate on coastal HQ.
	Destroying the HQ first yields failure.
	Securing the weapons first yields success.
*/
private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2500;

//-------------------- FIND SAFE POSITION FOR MISSION
	private _flatPos = [];
	private _accepted = false;
	while {!_accepted} do {
		while {(count _flatPos) < 2} do {
			private _position = [nil,["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [2,-1,0.3,1,0,true];
		};

		_accepted = true;
		{
			_NearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
		} forEach _noSpawning;
	};

//------------------------------------------- SPAWN OBJECTIVE AND AMBIENCE
	private _randomDir = (random 360);
	sideObj = "Land_Cargo_HQ_V1_F" createVehicle _flatPos;
	waitUntil {alive sideObj};
	sideObj animate ["door_1_rot", 1];
	sideObj setDir _randomDir;
	sideObj setVectorUp [0,0,1];

	private _objectType = selectRandom ["Box_NATO_AmmoVeh_F","Box_East_AmmoVeh_F","O_supplyCrate_F","B_CargoNet_01_ammo_F","CargoNet_01_box_F"];
    private _object = _objectType createVehicle _flatPos;

    [sideObj,_object,[0,0,0.7]] call BIS_fnc_relPosObject;

    [_object,"Plant charges",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\destroy_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
    "_target distance _this <= 5","_target distance _this <= 5",
    {   hint "Planting charges ...";
         params ["","_hero"];
        if ( currentWeapon _hero != "" ) then
        {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
        _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
    },{},{execVM "missions\side\actions\sabotage.sqf"},
    {   hint "You stopped planting charges.";
        private _unit = _this select 1;
        _unit playMoveNow "";
    },[], 8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

	//--------- BOAT POSITIONS
	private _boatPos = [_flatPos, 50, 150, 10, 2, 1, 0] call BIS_fnc_findSafePos;
	private _trawlerPos = [_flatPos, 200, 300, 10, 2, 1, 0] call BIS_fnc_findSafePos;

	//--------- ENEMY HMG BOAT (SEEMS RIGHT SINCE ITS BY THE COAST)
	private _smuggleGroup = createGroup east;
	
	private _boat = "O_Boat_Armed_01_hmg_F" createVehicle _boatPos;
	sleep 0.3; 
	waitUntil {alive _boat};
	"O_diver_TL_F" createUnit [_boatPos,_smuggleGroup]; 
	"O_diver_F" createUnit [_boatPos,_smuggleGroup]; 
	"O_diver_F" createUnit [_boatPos,_smuggleGroup]; 
	"O_diver_F" createUnit [_boatPos,_smuggleGroup]; 
	"O_diver_F" createUnit [_boatPos,_smuggleGroup];
	((units _smuggleGroup) select 0) assignAsCommander _boat;
	((units _smuggleGroup) select 0) moveInCommander _boat;
	((units _smuggleGroup) select 1) assignAsDriver _boat;
	((units _smuggleGroup) select 1) moveInDriver _boat;
	((units _smuggleGroup) select 2) assignAsGunner _boat;
	((units _smuggleGroup) select 2) moveInGunner _boat;
	((units _smuggleGroup) select 3) assignAsCargo _boat;
	((units _smuggleGroup) select 3) moveInCargo _boat;
	((units _smuggleGroup) select 4) assignAsCargo _boat;
	((units _smuggleGroup) select 4) moveInCargo _boat;
	[(units _smuggleGroup)] call AW_fnc_setSkill2;

	_boat lock 3;
		
	[_smuggleGroup, getPos sideObj, 150] call BIS_fnc_taskPatrol;
	
	{_x addCuratorEditableObjects [units _smuggleGroup + [_boat], false];} forEach allCurators;
	_smuggleGroup setGroupIdGlobal [format ['Side-AssaultBoat']];
	private _unitsArray = (units _smuggleGroup);

	//---------- SHIPPING TRAWLER FOR AMBIENCE
	private _trawler = "C_Boat_Civil_04_F" createVehicle _trawlerPos;
	_trawler setDir random 360;
	_trawler allowDamage false;

//-------------------- SPAWN FORCE PROTECTION
	private _enemiesArray = [sideObj] call AW_fnc_SMenemyEAST;

//-------------------- BRIEFING
	private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Secure Smuggled Explosives";
	"sideMarker" setMarkerText "Side Mission: Secure Smuggled Explosives";
    [west,["hqCoastTask"],[
    "OPFOR have been smuggling explosives onto the island and hiding them in a Mobile HQ on the coastline.We've marked the building on your map; head over there and secure the current shipment. Keep well back when you blow it, there's a lot of stuff in that building.  Aerial surveillance suggests the building will look like this: <br/><br/><img image='Media\Briefing\hqCoast.jpg' width='300' height='150'/>"
    ,"Side Mission: Secure Smuggled Explosives","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;
	sideMissionSpawnComplete = true;
	publicVariableServer "sideMissionSpawnComplete";


//-------------------- [ CORE LOOPS ]----------------------- [CORE LOOPS]
	sideMissionUp = true;
	SM_SUCCESS = false;
	private _objPos = getPos _object;

waitUntil {sleep 5; !sideMissionUp || SM_SUCCESS|| !alive _object};

	if (!sideMissionUp) then {
        deleteVehicle _object;
		//-------------------- DE-BRIEFING
		sideMissionUp = false;
		SM_SUCCESS = false;
        ["hqCoastTask", "Failed",true] call BIS_fnc_taskSetState;
	};

	if (SM_SUCCESS) then {
        sleep 30;
        "Bo_GBU12_LGB" createVehicle _objPos; 		
        deleteVehicle _object;
		
		//-------------------- DE-BRIEFING
		sideMissionUp = false;
		[] call AW_fnc_SMhintSUCCESS;
        ["hqCoastTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
		
        sleep 4 + (random 3);
        "SmallSecondary" createVehicle (_objPos getPos [random 2, random 360]);
        sleep 0.2;
        "SmallSecondary" createVehicle (_objPos getPos [random 2, random 360]);
        sleep 2 + (random 2);
        "SmallSecondary" createVehicle (_objPos getPos [random 3, random 360]);
        sleep 1 + (random 2);
        "SmallSecondary" createVehicle (_objPos getPos [random 3, random 360]);
        sleep 0.2;
        "SmallSecondary" createVehicle (_objPos getPos [random 4, random 360]);
	};

	if (!alive _object && !SM_SUCCESS) then {
        //-------------------- DE-BRIEFING
        sideMissionUp = false;
        [] call AW_fnc_SMhintSUCCESS;
        deleteVehicle _object;
        ["hqCoastTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
     };

	sleep 5;
	["hqCoastTask",west] call bis_fnc_deleteTask;
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];

	//cleanup
	sleep 120;
	{ deleteVehicle _x } forEach [_boat,_trawler];
	if (!alive sideObj)then {
        deleteVehicle nearestObject [_flatPos,"Land_Cargo_HQ_V1_ruins_F"];
    } else {
        deleteVehicle sideObj
    };
	{ [_x] spawn AW_fnc_SMdelete } forEach [_unitsArray,_enemiesArray];