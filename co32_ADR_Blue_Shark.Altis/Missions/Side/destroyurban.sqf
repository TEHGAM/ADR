/*
@file: destroyUrban.sqf
Initial authors:
	Quiksilver,	Jester [AW], chucky [allFPS], BangaBob [EOS] for EOS
Rewritten for I&A 3.2 by stanhope
	
Last modified: 5/09/2017
	
Modified: intel mechanic
	
Description:
	Objective appears in urban area, with random OPFOR/INDEP enemies and civilians.
	Inf spawn in foot patrols and randomly placed in and around buildings.
*/
private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2500;

//==================== PREPARE MISSION =======================
//----Pick town
private _towns = nearestLocations [(getMarkerPos "Base"), ["NameCity","NameCityCapital"], 25000];

private _accepted = false;
private ["_RandomTownPosition"];
while {!_accepted} do {
	_RandomTownPosition = position (selectRandom _towns);	
	_accepted = true;
	{
		private _NearBaseLoc = _RandomTownPosition distance (getMarkerPos _x);
		if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
	} forEach _noSpawning;
};
	
//----Spawn obj
private _objective = selectRandom ["Box_NATO_AmmoVeh_F","Box_East_AmmoVeh_F"];

private _cacheBuildingArray = nearestObjects [_RandomTownPosition, ["house","building"], 300];
private _cacheBuildingArrayAmount = count _cacheBuildingArray;

private _cacheBuildingLocationFinal = [0,0,0];

if (_cacheBuildingArrayAmount > 0) then {
_accepted = false;
	while {!_accepted} do {
		private _cacheBuilding = selectRandom _cacheBuildingArray;
		_cacheBuildingLocationFinal = selectRandom (_cacheBuilding buildingPos -1);
		
		if !(_cacheBuildingLocationFinal isEqualTo [0,0,0]) then {
			sideObj = createVehicle [_objective, _cacheBuildingLocationFinal, [], 0, "CAN_COLLIDE"];
			sideObj allowDamage false;
			_accepted = true;
		};
	};
};
/*Todo: error handeling for no building found, and no final pos found*/

[sideObj,"Plant charges",
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

sideObj addEventHandler ["Killed",{
	params ["","","_killer"];
	_name = name _killer;
	if !(_name == "Error: No vehicle") then{
   private _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 has destroyed the cache, good job everyone!</t>",_name];
   [_sidecompleted] remoteExec ["AW_fnc_globalHint",0,false];
	};
}];
sleep 0.1;

//-------- SPAWN GUARDS and CIVILIANS
	private _enemiesArray = [objNull];

	//======selecting side & faction:======
	private ["_faction","_groupSide"];
	_side = selectrandom [East,Independent,Independent,Independent];
	if (_side ==East) then{ _faction = "OPF_F"; _groupSide = "East"; };
	if (_side ==Independent) then{ _faction = selectrandom ["IND_C_F","IND_C_F","IND_F"]; _groupSide = "Indep"; };

	//=============civs==============
	_civs = ["C_man_1","C_man_polo_1_F_euro","C_man_polo_2_F_euro","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_6_F","C_man_shorts_4_F_asia"];

	//=====defining inf groups=======
	private ["_infteams"];
	if (_faction =="OPF_F") then{ _infteams = ["OI_reconPatrol","OI_reconTeam","OIA_InfAssault","OIA_InfSquad","OIA_InfSquad_Weapons","OIA_InfTeam","OIA_InfTeam_AT","OIA_InfTeam_AA"]; };
	if (_faction =="IND_C_F") then{ _infteams = ["BanditCombatGroup","BanditFireTeam","BanditShockTeam","ParaCombatGroup","ParaFireTeam","ParaShockTeam"]; };
	if (_faction =="IND_F") then{ _infteams = ["HAF_InfSquad","HAF_InfSquad_Weapons","HAF_InfTeam","HAF_InfTeam_AA","HAF_InfTeam_AT"]; };

	//=====defining vehicles=========
	_Randomvehicle = ["I_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F"];	

	//=====defining inf units=======
	private ["_infunits"];
	if (_faction =="OPF_F") then{ _infunits = ["O_Soldier_F","O_officer_F","O_Soldier_lite_F","O_Soldier_GL_F","O_Soldier_AR_F","O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_engineer_F"]; };
	if (_faction =="IND_C_F") then{ _infunits = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_3_F"]; };
	if (_faction =="IND_F") then{ _infunits = ["I_soldier_F","I_officer_F","I_Soldier_lite_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_M_F","I_medic_F","I_Soldier_repair_F","I_Soldier_exp_F","I_engineer_F"]; };

	//---------- INFANTRY RANDOM
	private _patrolgroupamount = 0;

	for "_i" from 0 to (2 + (random 2)) do {
		_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
		_infteamPatrol = createGroup _side;
		_infteamPatrol = [_randomPos, _side, (configfile >> "CfgGroups" >> _groupSide >> _faction >> "Infantry" >> selectRandom _infteams )] call BIS_fnc_spawnGroup;
		_patrolgroupamount = _patrolgroupamount + 1;
		_infteamPatrol setGroupIdGlobal [format ['Side-Patrolinf-%1', _patrolgroupamount]];
		[_infteamPatrol, _cacheBuildingLocationFinal, 50 + (random 100)] call AW_fnc_taskCircPatrol;
		_enemiesArray = _enemiesArray + (units _infteamPatrol);
		{_x addCuratorEditableObjects [units _infteamPatrol, false];} foreach allCurators;
	};
	sleep 0.1;
		
	//---------- RANDOM VEHICLE 
	private _vehpatrolgroupamount = 0;

	_randomPos = [[[_cacheBuildingLocationFinal, 300],[]],["water","out"]] call BIS_fnc_randomPos;
	_Vehiclegroup1 = createGroup _side;
	_vehicletype = selectRandom _Randomvehicle;
	_vehicle1 = _vehicletype createVehicle _randomPos;
	createvehiclecrew _vehicle1;
	(crew _vehicle1) join _Vehiclegroup1;
	_vehpatrolgroupamount = _vehpatrolgroupamount + 1;
	_Vehiclegroup1 setGroupIdGlobal [format ['Side-VehPatrol-%1', _vehpatrolgroupamount]];
	_vehicle1 lock 3;
	[_Vehiclegroup1, _cacheBuildingLocationFinal, 50 + (random 100)] call AW_fnc_taskCircPatrol;
	{_x addCuratorEditableObjects [[_vehicle1] + units _Vehiclegroup1, false];} foreach allCurators;
	_enemiesArray = _enemiesArray + (units _Vehiclegroup1) + [_vehicle1];
	sleep 0.1;

	//-----------enemies in buildings
	private _garrisongroupamount = 0;

	_infBuildingArray = nearestObjects [sideObj, ["house","building"], 200];
	_infBuildingAmount = count _infBuildingArray;

	if (_infBuildingAmount > 0) then {
		private _GarrisonedBuildings = _infBuildingAmount;
		if (_infBuildingAmount > 20 ) then {_GarrisonedBuildings = _infBuildingAmount*3/4;};
		if (_infBuildingAmount > 40 ) then {_GarrisonedBuildings = _infBuildingAmount/2;};
		if (_infBuildingAmount > 60 ) then {_GarrisonedBuildings = 30;};

		for "_i" from 0 to _GarrisonedBuildings do {
			_garrisongroup = createGroup _side;
			_garrisongroupamount = _garrisongroupamount + 1;
			_garrisongroup setGroupIdGlobal [format ['Side-GarrisonGroup-%1', _garrisongroupamount]];
			_infBuilding = selectRandom _infBuildingArray;
			_infBuildingArray = _infBuildingArray - [_infBuilding];
			_infbuildingpos = _infBuilding buildingPos -1;
			
			_buildingposcount = count _infbuildingpos;
			_Garrisonpos = _buildingposcount/2;
			
			for "_i" from 1 to _Garrisonpos do {
				_unitpos = selectRandom _infbuildingpos;
				_infbuildingpos = _infbuildingpos - _unitpos;
				_unittype = selectRandom _infunits;
				_unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
				_unit disableAI "PATH";
			};
			_enemiesArray = _enemiesArray + (units _garrisongroup);
			{_x addCuratorEditableObjects [units _garrisongroup, false];} foreach allCurators;
			sleep 0.1;
		};
	};
	
	//---------intel action
	private _leaderTypes = [
		"O_G_officer_F","O_officer_F","O_T_Officer_F","O_Soldier_SL_F","O_SoldierU_SL_F","O_T_Soldier_SL_F","O_G_Soldier_SL_F",
		"I_G_officer_F","I_officer_F","I_Soldier_SL_F","I_G_Soldier_SL_F"
	];
	{
		if ( (typeOf _x) in _leaderTypes) then {
			[_x,"Search for intel",
			"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
			"(_target distance _this <= 4) && !(alive _target)","(_target distance _this <= 4) && !(alive _target)",
			{
				hint "Searching for intel...";
				params ["","_hero"];
				if ( currentWeapon _hero != "" ) then
				{	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
				_hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
			},{},{
				if (random 1 >= 0.4) then {
					_codeToExec = {
						private _currentSize = markerSize "sideMissionHintCircle";
						private _markerSide = (_currentSize select 0) * 0.8;
						"sideMissionHintCircle" setMarkerSize [_markerSide, _markerSide];
						private _objectivepos = getPos sideObj;
						private _fuzzyPos = [((_objectivepos select 0) - _markerSide) + (random (_markerSide*2)),((_objectivepos select 1) - _markerSide) + (random (_markerSide*2)),0];
						"sideMissionHintCircle" setMarkerPos _fuzzyPos;
					};
					[[], _codeToExec] remoteExecCall ["call", 2];
					hint "You found some intel, updating map now";
				} else {
					hint "You didn't find any intel";
				};
			},
			{
				hint "You stop searching for intel.";
				private _unit = _this select 1;
				_unit playMoveNow "";
			},[], 8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];
		};
	} forEach _enemiesArray;

	//-------------civs
	private _civgroupamount = 0;

	for "_i" from 1 to 4 do {
		_randomPos = [[[getPos sideObj, 250],[]],["water","out"]] call BIS_fnc_randomPos;
		_unittype = selectRandom _civs;
		_civgroup = createGroup Civilian;
		_civgroupamount = _civgroupamount + 1;
		_civgroup setGroupIdGlobal [format ['Side-CivGroup-%1', _civgroupamount]];
		
		for "_i" from 1 to (2+ random 2) do {
			_unit = _civgroup createUnit [_unittype, _randomPos, [], 0, "CAN_COLLIDE"];
			_unit addEventHandler ["Killed",{
				params ["_unit","","_killer"];
				_name = name _killer;
				if !(_name == "Error: No vehicle") then{
				_civkilled = format["<t align='center'><t size='2.2'>%1 killed a civilian!</t><br/>____________________<br/>High command doesn't like civilian casualties.  DO NOT kill civilians</t>",_name];
				[_civkilled] remoteExec ["AW_fnc_globalHint",0,false];
				};
			}];
			[_unit,"Search for intel",
			"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
			"(_target distance _this <= 4) && (alive _target)","(_target distance _this <= 4) && (alive _target)",
			{
				hint "Searching for intel...";
			},{},{
				if (random 1 > 0.5) then {
					hint "You found some intel, updating map now";
					_codeToExec = {
						private _currentSize = markerSize "sideMissionHintCircle";
						private _markerSide = (_currentSize select 0) * 0.8;
						"sideMissionHintCircle" setMarkerSize [_markerSide, _markerSide];
						private _objectivepos = getPos sideObj;
						private _fuzzyPos = [((_objectivepos select 0) - _markerSide) + (random (_markerSide*2)),((_objectivepos select 1) - _markerSide) + (random (_markerSide*2)),0];
						"sideMissionHintCircle" setMarkerPos _fuzzyPos;
					};
					[[], _codeToExec] remoteExecCall ["call", 2];
				} else {
					hint "You didn't find any intel";
				};
			},{
				hint "You stop searching for intel.";
			},[], 2, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];
		};
		[_civgroup, getPos sideObj, 150] call BIS_fnc_taskPatrol;
		_enemiesArray = _enemiesArray + (units _civgroup);
		{_x addCuratorEditableObjects [units _civgroup, false];} foreach allCurators;
		sleep 0.1;
	};
	
//-------------------- BRIEFING
	//smaller cirle to make it a tad easier
	private _objectivepos = getPos sideObj;
	private _fuzzyPos = [((_objectivepos select 0) - 50) + (random 100),((_objectivepos select 1) - 50) + (random 100),0];
	private _sideMissionHintCircle = createMarker ["sideMissionHintCircle",_fuzzyPos];
	"sideMissionHintCircle" setMarkerShape "RECTANGLE";
	"sideMissionHintCircle" setMarkerBrush "BDiagonal";
	"sideMissionHintCircle" setMarkerSize [100, 100];

	{ _x setMarkerPos _RandomTownPosition; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Destroy Weapons Shipment";
	"sideMarker" setMarkerText "Side Mission: Destroy Weapons Shipment";
    [west,["urbancacheTask"],[
    "Enemy forces have moved a cache with advanced weapons into a town and are planning on handing those out to hostile guerrilla forces.  Find the cache and destroy it.  The cache will be in the village marked on the map, and is in all likelihood in the square marked with diagonal lines.  The cache will look similar to this one: <br/><br/><img image='Media\Briefing\urbanCache.jpg' width='300' height='150'/>"
    ,"Side Mission: Destroy Weapons Shipment","sideCircle"],(getMarkerPos "sideCircle"),
    "Created",0,true,"search",true] call BIS_fnc_taskCreate;
	
	sideMissionSpawnComplete = true;
	publicVariableServer "sideMissionSpawnComplete";

//--------------------- WAIT UNTIL OBJECTIVE COMPLETE: Sent to sabotage.sqf to wait for SM_SUCCESS var.
	sideMissionUp = true;
	SM_SUCCESS = false;
	sideObj allowDamage true;
	
	waitUntil { sleep 5; SM_SUCCESS || !sideMissionUp || !alive sideObj };

//--------------------- BOOM
if (alive sideObj) then {
    sleep 30;			// ghetto bomb timer
    deleteVehicle sideObj;
    "Bo_GBU12_LGB" createVehicle _cacheBuildingLocationFinal; 		// default "Bo_Mk82"
    sleep 4 + (random 3);
    "SmallSecondary" createVehicle (_cacheBuildingLocationFinal getPos [random 1, random 360]);
    sleep 0.2;
    "SmallSecondary" createVehicle (_cacheBuildingLocationFinal getPos [random 1, random 360]);
    sleep 2 + (random 2);
    "SmallSecondary" createVehicle (_cacheBuildingLocationFinal getPos [random 2, random 360]);
    sleep 1 + (random 2);
    "SmallSecondary" createVehicle (_cacheBuildingLocationFinal getPos [random 2, random 360]);
    sleep 0.2;
    "SmallSecondary" createVehicle (_cacheBuildingLocationFinal getPos [random 2, random 360]);
};

//-------------------- DE-BRIEFING
	sideMissionUp = false;
	[] call AW_fnc_SMhintSUCCESS;
	deleteMarker "sideMissionHintCircle";
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
	["urbancacheTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
	sleep 5;
	["urbancacheTask",west] call bis_fnc_deleteTask;
	
//--------------------- DELETE, DESPAWN, HIDE and RESET
	sleep 120;
	{ [_x] spawn AW_fnc_SMdelete } forEach [_enemiesArray];