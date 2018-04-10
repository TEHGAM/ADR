/*
Author: stanhope, AW-community member
bassed off of existing AW created side missions
Description: mission in which players have to find and heal a crashed helipilot before he dies.
Bleedouttimer starts running when player get's within 3.5km of the obj.

Last modified:  23/02/18 by stanhope
modified: tweaks for perf
*/

private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2500;

private _bleedOutTimer = 900; //time before the pilot dies
private _triggerRange = 3500; //if players get within this radius the bleedouttimer starts running

//-------------------- FIND SAFE POSITION FOR heliwreck
	private _flatPos = [];
	private _accepted = false;
	while {!_accepted} do {
		while {(count _flatPos) < 2} do {
			private _position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [5,0,0.2,sizeOf "Land_Wreck_Heli_Attack_01_F",0,false];
		};
		_accepted = true;
		{
			_nearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_nearBaseLoc < _noSpawningRange) then {_accepted = false;};
		} forEach _noSpawning;
	};

// Heli-wreck Creation -----------------------
	sideObj = "Land_Wreck_Heli_Attack_01_F" createVehicle _flatPos;
	waitUntil {sleep 0.1; alive sideObj};
	sideObj setDir 88.370;
	sideObj setVectorUp surfaceNormal position sideObj;
	
//Pilot Creation -----------------------

private _pilot = "C_man_pilot_F" createVehicle [(getPos sideObj select 0)+4, (getPos sideObj select 1)-4, ((getPos sideObj select 2))];
_pilot setVectorUp surfaceNormal position _pilot;
_pilot setDir 88.370;

removeAllWeapons _pilot;
removeAllItems _pilot;
removeAllAssignedItems _pilot;
removeUniform _pilot;
removeVest _pilot;
removeBackpack _pilot;
removeHeadgear _pilot;
removeGoggles _pilot;
_pilot forceAddUniform "U_B_HeliPilotCoveralls";
_pilot addVest "V_PlateCarrier1_blk";
_pilot addHeadgear "H_PilotHelmetHeli_B";
_pilot allowDamage false;
[_pilot, "Acts_LyingWounded_loop"] remoteExec ["switchMove", 0, true];

[_pilot,"Rescue pilot",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\heal_ca.paa",
"_target distance _this <= 4","_target distance _this <= 4",
{hint "Performing first aid ...";
private _unit = _this select 1;
if ( currentWeapon _unit != "" ) then
{	_unit action ["SwitchWeapon", _unit, _unit, 99]; };
_unit playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";

},{},{

    _name = name (_this select 1);
    _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 healed the pilot.  Good job everyone.</t>",_name];
    [_sidecompleted] remoteExec ["AW_fnc_globalHint",0,false];
    sleep 4;
    SM_SUCCESS = true;
	publicVariableServer "SM_SUCCESS";

},
{hint "You stopped performing first aid";
private _unit = _this select 1;
_unit playMoveNow "";
},[],10, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

// Spawn enemy forces--------------------------------------
private _enemiesArray = [sideObj] call AW_fnc_SMenemyEASTrescuepilot;
	
// Briefing ------------------------------------------------
private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
sideMarkerText = "search and rescue";
"sideMarker" setMarkerText "Side Mission: search and rescue";
[west,["rescueTask"],[
"We received a distress call from a blackfoot pilot but the call was cut short. We believe the enemy has shot his heli down, your job is to find and rescue the pilots.  We have reasons to believe that at least 1 pilot survived. Be careful when approaching the search area we expect heavy AA.  The wreck will most likely look like this: <br/><br/><img image='Media\Briefing\heliWreck.jpg' width='300' height='150'/>"
,"Side Mission: search and rescue","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"heal",true] call BIS_fnc_taskCreate;

//mission core
sideMissionUp = true;
SM_SUCCESS = false;
sideMissionSpawnComplete = true;
publicVariableServer "sideMissionSpawnComplete";

//First wait till there are enough players near
while {sideMissionUp} do {	

	private _numPlayersnear = 0;
    {	if ((_x distance _flatPos) < _triggerRange) then {
            _numPlayersnear = _numPlayersnear + 1;
			sleep 0.1;
        };
    } forEach allPlayers;

	if (_numPlayersnear > 0) exitWith{};
    if (!alive _pilot) exitWith{};
	sleep 10;
};
sleep 1;

while {sideMissionUp} do {

	if (SM_SUCCESS) exitWith {

		//-------------------- DE-BRIEFING
		[] call AW_fnc_SMhintSUCCESS;
        ["rescueTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
		sideMissionUp = false;
	};
	
	if ((_bleedOutTimer <= 0) || (!alive _pilot) || !sideMissionUp) exitWith {
		//-------------------- DE-BRIEFING
        ["rescueTask", "Failed",true] call BIS_fnc_taskSetState;
		sideMissionUp = false;
	};
	
	_bleedOutTimer = _bleedOutTimer -5;
    sleep 5;
};

deleteVehicle _pilot;
sleep 5;
["rescueTask",west] call bis_fnc_deleteTask;
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];

//-------------------- DELETE
sleep 120;
deleteVehicle sideObj;
[_enemiesArray] spawn AW_fnc_SMdelete;