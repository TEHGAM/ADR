/*
  Author: BACONMOP
  Spawns CSAT JET to CAS strike
 	O_Plane_CAS_02_F
  LaserTargetE
 
  _laser = "LaserTargetE" createVehicle (getPos player);
  _laser attachTo [player,[0,0,0]];
 
 plane doTarget Player;
 
 Last modified:
	19/08/2017 by stanhope, AW-member
	
 Modified:
updated some code, added a name to the jet group
 */
jetCounter = jetCounter + 1;
publicVariableServer "jetCounter";

private _jettype = selectRandom [
"O_Plane_CAS_02_dynamicLoadout_F","O_Plane_CAS_02_dynamicLoadout_F","O_Plane_CAS_02_Cluster_F",
"O_Plane_Fighter_02_F","O_Plane_Fighter_02_Cluster_F","O_Plane_Fighter_02_Stealth_F",
"I_Plane_Fighter_04_F","I_Plane_Fighter_04_Cluster_F","I_Plane_Fighter_03_dynamicLoadout_F"];

//Select an airfield
private ["_jet"];
private _airField = [
	"AAC_CAS_Spawn",
	"Airbase_CAS_Spawn",
	"SaltLake_CAS_Spawn",
	"Molos_CAS_Spawn"
];
if ("AAC_Airfield" in controlledZones) then {
	_airField = _airField - ["AAC_CAS_Spawn"];
};
if ("Terminal" in controlledZones) then {
	_airField = _airField - ["Airbase_CAS_Spawn"];
};
if ("Salt_Flats_North" in controlledZones) then {
	_airField = _airField - ["SaltLake_CAS_Spawn"];
};
if ("Molos_Airfield" in controlledZones) then {
	_airField = _airField - ["Molos_CAS_Spawn"];
};

//create the jet + dummy unit to keep group OPFOR
_jetGrp = createGroup east;
_jetGrp setGroupIdGlobal [format ['RT-Jet-%1', jetCounter]];
_dummyUnit = "O_Soldier_VR_F" createVehicle [0,0,0];

if ((count _airField) > 0) then {
	_jetSpawn = selectRandom _airField;
	_jet = _jettype createVehicle (getMarkerPos _jetSpawn);
	_jet setDir markerDir _jetSpawn;	
} else {
	_spawnPos = [(random 1000),(random 1000),2000];
	_jet = _jettype createVehicle _spawnPos;
};

waitUntil {!isNull _jet};
//Spawn the pilot and set some other thigns
[_jet,_jetGrp] call BIS_fnc_spawnCrew;
_jet engineOn true;
_jet lock 2;
_jet allowCrewInImmobile true;
//Delete dummy and add everything to zeus
deleteVehicle _dummyUnit;
{_x addCuratorEditableObjects [[_jet]+ (units _jetGrp), true];} forEach allCurators;

//Send him to the AO
_jetWp = _jetGrp addWaypoint [getMarkerPos currentAO,0];
_jetWp setWaypointType "LOITER";
_jetWp setWaypointLoiterRadius (PARAMS_AOSize*1.5);
_jet flyInHeight (250 + random 250);
_jet limitSpeed 375;
//Wait 2 minutes for him to get there
sleep 120;

//Start main loop
private ["_target"];
while {alive _jet} do {

	//Find someone or something to attack
	private _accepted = false;
	while {!_accepted} do {
		_target = objNull;
		_TargetList = (getMarkerPos currentAO) nearEntities [["Man", "Air", "Car", "Tank"], (PARAMS_AOSize*2.5)];
		sleep 0.1;
		if ( (count _TargetList) > 0) then {
			_target = selectRandom _TargetList;
			if ( !(_target isEqualTo objNull) && ((side _target) == west) && ( ((east knowsAbout _target) > 1.9) || ((independent knowsAbout _target) > 1.9) ) ) then {
				_accepted = true;
				_jetGrp reveal [_target,4];
			};
		} else {
			_accepted = false;
			sleep 3;
		};
		if (!alive _jet) exitWith {};
	};
	if (!alive _jet) exitWith {};
	
	//delete the current waipoints of the jet:
	while {(count (waypoints _jetGrp)) > 0} do{
		deleteWaypoint ((waypoints _jetGrp) select 0);
	};
	
	//Attack the target:
	_laser = "LaserTargetW" createVehicle (getPos _target);
	_laser attachTo [_target,[0,0,0]];
	_jet doTarget _target;
	_jet doFire _target;
	[_jetGrp,(getPos _target)] call BIS_fnc_taskAttack;
	[_jetGrp, 0] waypointAttachObject _target;
	
	//Let him continiue attackint for 2 minutes or until the target is dead
	_i = 0;
	while {alive _target && _i < 48} do {
		sleep 5;
		_i = _i + 1;
		if (!alive _jet) exitWith {};
	};
	
	//delete the current waipoints of the jet and the laser:
	deleteVehicle _laser;
	while {(count (waypoints _jetGrp)) > 0} do{
		deleteWaypoint ((waypoints _jetGrp) select 0);
	};
	if (!alive _jet) exitWith {};
	//let him loiter for 2 minutes then attack the next thing
	_jetWp = _jetGrp addWaypoint [getMarkerPos currentAO,0];
	_jetWp setWaypointType "LOITER";
	_jetWp setWaypointLoiterRadius (PARAMS_AOSize*1.5);
	_jet flyInHeight (250 + random 250);
	_jet limitSpeed 375;
	sleep 120;
};

jetCounter = jetCounter - 1;
publicVariableServer "jetCounter";