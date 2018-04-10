/*
Author:

	Lost Bullet

Last modified: 6/09/2017 by stanhope

modified:	general tweaks

Description:

	Every X seconds that the "Factory" is not destroyed, current AO is reinforced with enemies

_________________________________________________________________ */

private ["_loopVar","_NearBaseLoc","_unitsArray","_i","_flatPos","_accepted","_position","_enemiesArray","_targetList","_fuzzyPos","_x","_briefing",
"_groupsArray","_objectiveUnit","_unitpos","_unit","_unittype","_garrisonpos","_buildingposcount","_priorityGroup","_nospawning","_engenieerpos","_unittypes",
"_numPlayersinAO","_randomPlayer", "_totalspawnUnits","_addspawnUnits","_spawnedunits","_firstloop","_radiusCheck","_playerClose","_typeFactory","_reinforceGroup",
"_randomspawnPosition","_unitArray","_grpMember","_timetosleep","_veh","_infTeams","_vehicleTypes","_attackheliTypes","_jetTypes","_jet","_jetWp","_heliReinf"];

_infTeams = ["OIA_InfTeam","OIA_InfTeam_AT","OIA_InfTeam_AA","OI_reconPatrol","OIA_GuardTeam"];
_vehicleTypes = ["O_MBT_02_cannon_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_APC_Tracked_02_AA_F"];
_attackheliTypes = ["O_Heli_Light_02_dynamicLoadout_F","O_Heli_Attack_02_dynamicLoadout_F","I_Heli_light_03_dynamicLoadout_F"];
_jetTypes = ["O_Plane_CAS_02_F","O_Plane_CAS_02_F","O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F","I_Plane_Fighter_04_F","I_Plane_Fighter_04_F"];

_enemiesArray = [];
factoryDisabled = false;
PrioHeliCount = 0;

private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2000;

/* --- 1. FIND POSITION FOR OBJECTIVE --- */

	_flatPos = [0,0,0];
	_accepted = false;
	
	while {!_accepted} do {
		_position = [[[getMarkerPos currentAO,2500]],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
		while {(count _flatPos) < 2} do {
				_position = [[[getMarkerPos currentAO,2500]],["water","out"]] call BIS_fnc_randomPos;
				_flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
		};
	    _accepted = true;
		{
			_NearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
		} forEach _noSpawning;
	};

/* --- 2. SPAWN OBJECTIVE --- */

	Factory = "Land_i_Shed_Ind_F" createVehicle _flatPos;
	waitUntil {!isNull Factory};
	Factory setDir random 360;
	Factory allowDamage false; //no CAS bombing it until the Engineer inside is killed.

	//Place engineers team/objectives inside Factory
	_priorityGroup = createGroup east;
	_priorityGroup setGroupIdGlobal [format ['Prio-FactoryUnits']];
	
	//where should he be?
	_garrisonpos = Factory buildingPos -1;
	_engenieerpos =  selectRandom _garrisonpos;
	_garrisonpos = _garrisonpos - [_engenieerpos];
	_objectiveUnit = "O_V_Soldier_Exp_hex_F" createUnit [_engenieerpos, _priorityGroup];
	((units _priorityGroup) select 0) disableAI "PATH";
	
	((units _priorityGroup) select 0) addEventHandler ["Killed",{
	
		params ["_unit","","_killer"];
		Factory allowDamage true;
		_name = name _killer;
		if (_name == "Error: No vehicle") then{
		_name = "some genius jarhead who thought it'd be a good idea to run an enemy over with his jacked up monster truck";
		};
		_engineerkilled = format["<t align='center'><t size='2.2'>Prio Mission update</t><br/>____________________<br/>Fantastic job, lads! The OPFOR engineer has been killed by %1.  Now move in and demo that building</t>",_name];
		[_engineerkilled] remoteExec ["AW_fnc_globalHint",0,false];
	
	}];
	
	//fill the rest of the building
	_buildingposcount = count _garrisonpos;
	_buildingposcount = floor(_buildingposcount*3/4);
	_unittypes = ["O_recon_F","O_Soldier_SL_F","O_Soldier_lite_F","O_Soldier_AR_F","O_soldierU_exp_F","O_Soldier_F","O_HeavyGunner_F","O_Urban_HeavyGunner_F",
	"O_soldierU_F","O_Urban_Sharpshooter_F","O_Sharpshooter_F"];

	for "_i" from 1 to _buildingposcount do {
        _unittype = selectRandom _unittypes;
        _unitpos = selectRandom _garrisonpos;
        _unit = _unittype createUnit [_unitpos, _priorityGroup];
        _garrisonpos = _garrisonpos - [_unitpos];
        ((units _priorityGroup) select _i) disableAI "PATH";
        sleep 0.1;
	};
	
	_enemiesArray = _enemiesArray + (units _priorityGroup);
    {_x addCuratorEditableObjects [(units _priorityGroup), true];} forEach allCurators;


/* --- 3. SPAWN FORCE PROTECTION --- */

	//----infantry----
	private _infteamPatrolamount = 0;

	for "_i" from 0 to (3 + (random 2)) do {
		_infteamPatrol = createGroup east;
		_randomPos = [[[getPos Factory, 300],[]],["water","out"]] call BIS_fnc_randomPos;
		_infteamPatrol = [_randomPos, east, (configFile >> "CfgGroups" >> "East" >>"OPF_F" >> "Infantry" >> selectRandom _infTeams )] call BIS_fnc_spawnGroup;
		_infteamPatrolamount = _infteamPatrolamount + 1;
		_infteamPatrol setGroupIdGlobal [format ['Prio-Protection-inf-%1', _infteamPatrolamount]];
		[_infteamPatrol, getPos Factory, 100] call BIS_fnc_taskPatrol;
		_enemiesArray = _enemiesArray + (units _infteamPatrol);
		[(units _infteamPatrol)] call AW_fnc_setSkill2;	
		{_x addCuratorEditableObjects [units _infteamPatrol, false];} forEach allCurators;
		sleep 0.1;
	};
	//-----vehicles------
	
	_Randomvehicle = ["O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F"];	
	
	//===================vehicle 1======================
	private _Vehiclegroupamount = 0;
	
	for "_i" from 1 to 2 do {
		
		_randomPos = [[[getPos Factory, 300],[]],["water","out"]] call BIS_fnc_randomPos;
		_vehicletype = selectRandom _Randomvehicle;
		_Randomvehicle = _Randomvehicle - [_vehicletype];
		_vehicle = _vehicletype createVehicle _randomPos;
		
		_Vehiclegroup = createGroup East;
		createVehicleCrew _vehicle;
		(crew _vehicle) join _Vehiclegroup;
		
		_vehicle lock 3;
		_vehicle allowCrewInImmobile true;
		_vehicle setVehicleReportRemoteTargets false;
		_Vehiclegroupamount = _Vehiclegroupamount + 1;
		_Vehiclegroup setGroupIdGlobal [format ['Prio-Protection-veh-%1', _Vehiclegroupamount]];
		
		[_Vehiclegroup, getPos Factory, 100] call BIS_fnc_taskPatrol;
		{_x addCuratorEditableObjects [units _Vehiclegroup + [_vehicle], false];} forEach allCurators;
		_enemiesArray = _enemiesArray + (units _Vehiclegroup) + [_vehicle];
		sleep 0.1;
	};

	
/* --- 5. GET RANDOM TYPE OF FACTORY MISSION --- */

_typeFactory = selectRandom["inf","inf","inf","veh","veh","helicas","helicas",/*"paradrop","paradrop",*/"jet"];

/* --- 6. BRIEF --- */
    _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
    { _x setMarkerPos _fuzzyPos; } forEach ["priorityMarker", "priorityCircle"];
    priorityTargetText = "Support Factory";
    "priorityMarker" setMarkerText "Priority Target: Factory";
    _typeFactoryText = format["The enemies have set up a factory of the type %1.  Enemy reinforcements will keep coming to the AO untill this factory is taken out!  Intell suggest that the factory looks like a big industrial shed.  First kill the viper engineer inside then demo that building.  Previous sites looked like this: <br/><br/><img image='Media\Briefing\prioFactory.jpg' width='300' height='150'/>",_typeFactory];
    [west,["priorArtyTask"],[_typeFactoryText,"Priority Target: Factory","priorityCircle"],(getMarkerPos "priorityCircle"),"Created",0,true,"NewPriorityTarget",true] call BIS_fnc_taskCreate;
    ["priorArtyTask", "Created",true] call BIS_fnc_taskSetState;

/* --- 7. core loop --- */
prioMissionSpawnComplete = true;
publicVariableServer "prioMissionSpawnComplete";

_radiusCheck = derp_PARAM_AOSize;
private _reinforceGroupamount = 0;

while {!factoryDisabled && alive Factory} do{
	
	// ---- if its the first run or current AO doesn't have friendly's, don't spawn anything ----
	_numPlayersinAO = 0;
	_playerClose = [];
	{	
		if ((_x distance (getMarkerPos currentAO)) < _radiusCheck) then {
			_playerClose pushBack _x;
		};
	}forEach allPlayers;
	_numPlayersinAO = count _playerClose;
	sleep 0.1;
	
	if (_numPlayersinAO < 3) then{
	    //Wait 2 minutes then check if there are enough people in the AO.
		sleep 120;
		
	}else{

		//_typefactory = "inf"; //testing
		switch (_typefactory) do {
			case "inf": {
				//ground troop multiplier --> account for number of players on AO
				_totalspawnUnits = 3 + floor (_numPlayersinAO * 0.2);
				if (_totalspawnUnits > 16) then { _totalspawnUnits = 16;};
				
				_reinforceGroup = createGroup east;
				_reinforceGroupamount = _reinforceGroupamount + 1;
				_reinforceGroup setGroupIdGlobal [format ['Prio-reinforce-inf-%1', _reinforceGroupamount]];
				
				_unitArray = (missionConfigFile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
				_randomspawnPosition = [[[(position Factory), 300], []], ["water", "out"]] call BIS_fnc_randomPos;
				for "_i" from 1 to _totalspawnUnits do {
					_unit = selectRandom _unitArray;
					_grpMember = _reinforceGroup createUnit [_unit, _randomspawnPosition, [], 0, "FORM"];
					sleep 0.1;
    			};
				[_reinforceGroup, getMarkerPos currentAO, (_radiusCheck/2)] call BIS_fnc_taskPatrol;
				
				{_x addCuratorEditableObjects [units _reinforceGroup, false];} forEach allCurators;
				_enemiesArray = _enemiesArray + (units _reinforceGroup);
				
				sleep 240;
			};
			case "veh": {
				_randomspawnPosition = [[[(position Factory), 300], []], ["water", "out"]] call BIS_fnc_randomPos;
				_veh = (selectRandom _vehicleTypes) createVehicle _randomspawnPosition;
				waitUntil {sleep 0.5; !isNull _veh};
				_reinforceGroup = createGroup east;
				createVehicleCrew _veh;
				(crew _veh) join _reinforceGroup;
				_reinforceGroupamount = _reinforceGroupamount + 1;
				_reinforceGroup setGroupIdGlobal [format ['Prio-reinforce-veh-%1', _reinforceGroupamount]];
				[_reinforceGroup, getMarkerPos currentAO, (_radiusCheck/2)] call BIS_fnc_taskPatrol;
				_veh lock 3;
				_veh allowCrewInImmobile true;
				_reinforceGroup setBehaviour "COMBAT";
				_reinforceGroup setCombatMode "RED";
				_veh engineOn true;
				
				_enemiesArray = _enemiesArray + (units _reinforceGroup) + [_veh];
				{_x addCuratorEditableObjects [units _reinforceGroup + [_veh], false];} forEach allCurators;

				_timetosleep = 300 - floor (_numPlayersinAO * 2);
				sleep _timetosleep;
			};

			/*case "paradrop": {};*/
			
			case "helicas": {
			
				if (PrioHeliCount < 4) then {
					_randomspawnPosition = [[[(position Factory), 300], []], ["water", "out"]] call BIS_fnc_randomPos;
					_veh = (selectRandom _attackheliTypes) createVehicle _randomspawnPosition;
					waitUntil {sleep 0.5; !isNull _veh};
					_reinforceGroup = createGroup east;
					createVehicleCrew _veh;
					(crew _veh) join _reinforceGroup;
					_reinforceGroupamount = _reinforceGroupamount + 1;
					_reinforceGroup setGroupIdGlobal [format ['Prio-reinforce-heli-%1', _reinforceGroupamount]];
					[_reinforceGroup, getMarkerPos currentAO, (_radiusCheck/2)] call BIS_fnc_taskPatrol;
					_veh lock 3;
					_veh allowCrewInImmobile true;
					_reinforceGroup setBehaviour "COMBAT";
					_reinforceGroup setCombatMode "RED";
					_veh engineOn true;
					PrioHeliCount = PrioHeliCount + 1;
					_veh addEventHandler ["Killed",{PrioHeliCount = PrioHeliCount - 1;}];
					
					_enemiesArray = _enemiesArray + (units _reinforceGroup) + [_veh];
					{_x addCuratorEditableObjects [units _reinforceGroup + [_veh], false];} forEach allCurators;
				};

				_timetosleep = 480 - floor (_numPlayersinAO * 4);
				sleep _timetosleep;
			};
			case "jet": {
				if (PrioHeliCount < 3) then {
					//_jet = (selectRandom _jetTypes) createVehicle [10,10,3000];
					_jet = createVehicle [(selectRandom _jetTypes), [100,100,5000],[] , 100, "FLY"];
					_jet engineOn true;
					waitUntil {!isNull _jet};
					_reinforceGroup = createGroup east;
					createVehicleCrew _veh;
					(crew _veh) join _reinforceGroup;
					_reinforceGroupamount = _reinforceGroupamount + 1;
					_reinforceGroup setGroupIdGlobal [format ['Prio-reinforce-jet-%1', _reinforceGroupamount]];
					PrioHeliCount = PrioHeliCount + 1;
					_jet allowCrewInImmobile true;
					_jet flyInHeight 500;
					_jet lock 2;
					_jetWp = _reinforceGroup addWaypoint [getMarkerPos currentAO,0];
					_jetWp setWaypointType "LOITER";
					_jetWp setWaypointLoiterRadius 1500;
					_jetWp setWaypointCompletionRadius 1;
					_jet addEventHandler ["Killed",{PrioHeliCount = PrioHeliCount - 1;}];
					{_x addCuratorEditableObjects [[_jet]+ (units _reinforceGroup), false];} forEach allCurators;
					_enemiesArray = _enemiesArray + (units _reinforceGroup) + [_jet];
				};

				_timetosleep = 480 - floor (_numPlayersinAO * 4);
				sleep _timetosleep;
			};
		};         
	};
};

//debrief
["priorArtyTask", "Succeeded",true] call BIS_fnc_taskSetState;
sleep 5;
["priorArtyTask",west] call bis_fnc_deleteTask;
{ _x setMarkerPos [-10000,-10000,-10000] } forEach ["priorityMarker","priorityCircle"];

//cleanup
sleep 60;
[_enemiesArray] spawn AW_fnc_SMdelete;
