/*
Author: stanhope, AW-community member,
bassed off of existing side missions created by and for AW.

Description: Players have to rescue IDAP people that have been captured by enemy forces.  If more than 1 of the 4 IDAP people die the mission fails.

Last modified: 26/09/2017 by stanhope
	
modified: fixed some stuff with the help of Ryko
*/

//config
civsFreed = 0;
publicVariable "civsFreed";
civsKilled = 0;
publicVariable "civsKilled";

private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2500;

private _spawnedUnits = [];
private _groupsArray = [];  

private _unittypes = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F","I_C_Soldier_Bandit_2_F"];
private _hostageTypes = ["C_IDAP_Man_AidWorker_01_F","C_IDAP_Man_AidWorker_02_F","C_IDAP_Man_AidWorker_07_F","C_IDAP_Man_AidWorker_08_F","C_IDAP_Man_AidWorker_09_F","C_IDAP_Man_AidWorker_04_F","C_IDAP_Man_Paramedic_01_F"];

//mission pos finder
private ["_flatPos","_accepted","_position","_NearBaseLoc"];
	
	_flatPos = [];
	_accepted = false;
	while {!_accepted} do {

		while {(count _flatPos) < 2} do {
			_position = [] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [5,0,0.2,sizeOf "Land_MedicalTent_01_white_IDAP_open_F",0,false];
		};

		_accepted = true;
		{
			_NearBaseLoc = _flatPos distance (getMarkerPos _x);
			if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
		} forEach _noSpawning;
	};

//create IDAP tent
private ["_sideObjPos","_sideObjPosX","_sideObjPosY"];

sideObj = "Land_MedicalTent_01_white_IDAP_open_F" createVehicle _flatPos;
_spawnedUnits = _spawnedUnits + [sideObj];
sideObj setDir 0;
sideObj setVectorUp surfaceNormal position sideObj;
sideObj allowDamage false;
_sideObjPos = getPos sideObj;
_sideObjPosX = _sideObjPos select 0;
_sideObjPosY = _sideObjPos select 1;

//create hostages
private ["_hostage1","_hostage2","_hostage3","_hostage4"];

private _hostageGroup = createGroup Civilian;

_hostage1 = _hostageGroup createUnit [(selectRandom _hostageTypes), [_sideObjPosX - 2.4 , _sideObjPosY + 3], [], 0, "CAN_COLLIDE"];
_hostage2 = _hostageGroup createUnit [(selectRandom _hostageTypes), [_sideObjPosX - 2.4 , _sideObjPosY + 1], [], 0, "CAN_COLLIDE"];
_hostage3 = _hostageGroup createUnit [(selectRandom _hostageTypes), [_sideObjPosX - 2.4 , _sideObjPosY - 1], [], 0, "CAN_COLLIDE"];
_hostage4 = _hostageGroup createUnit [(selectRandom _hostageTypes), [_sideObjPosX - 2.4 , _sideObjPosY - 3], [], 0, "CAN_COLLIDE"];

//play the captured animation + add an adaction to be able to free the civs + killed event handler
{
	_x disableAI "PATH";
	_x disableAI "FSM";
	_x disableAI "AUTOCOMBAT";
	_x disableAI "autoTarget";
	[_x, "Acts_ExecutionVictim_Loop"] remoteExec ["switchMove", 0, true];


	[_x,"Save hostage",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\help_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
    "_target distance _this <= 4","_target distance _this <= 4",
    {hint "Freeing hostage";
    params ["","_hero"];
    if ( currentWeapon _hero != "" ) then
    {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
    _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
    },{},{
        params ["_hostage",""];
        [_hostage, 'Acts_ExecutionVictim_Unbow'] remoteExec ['switchMove', 0, true];
        civsFreed = civsFreed + 1;
         publicVariable 'civsFreed';
        _name = name (_this select 1);
        _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 freed a hostage.  Good job everyone, now free the rest of them.</t>",_name];
        [_sidecompleted] remoteExec ["AW_fnc_globalHint",0,false];
        [_hostage]spawn { sleep 10; deleteVehicle (_this select 0);};

    },
    {hint "You stopped unzipping the hostage";
    private _unit = _this select 1;
    _unit playMoveNow "";
    },[],8, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

	_x addEventHandler ["Killed",{
		params ["_unit","","_killer"];
		[_unit, 'Acts_ExecutionVictim_Kill_End'] remoteExec ['switchMove', 0, true];
		civsKilled = civsKilled + 1;
		publicVariable "civsKilled";
		_name = name _killer;
		if !(_name == "Error: No vehicle") then{
			_civkilled = format["<t align='center'><t size='2.2'>%1 killed an IDAP guy!</t><br/>____________________<br/>3 IDAP guys need to survive for us to call this mission a success!</t>",_name];
			[_civkilled] remoteExec ["AW_fnc_globalHint",0,false];
		};
		removeAllActions _unit;
	}];
	
	_spawnedUnits = _spawnedUnits + [_x];
	
} forEach (units _hostageGroup);

_groupsArray = _groupsArray + [_hostageGroup];
_hostageGroup setGroupIdGlobal [format ['Side-Hostages']];

//create Hostile forces:
private ["_hostageTaker1","_sid_hostageTaker2eObjPosX","_hostageTaker3","_hostageTaker4","_hostageTaker5","_hostageTaker6"];

private _hostageTakerGroup = createGroup resistance;

_hostageTaker1 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_sideObjPosX + 2.4 , _sideObjPosY + 3], [], 0, "CAN_COLLIDE"];
_hostageTaker1 doWatch getPos _hostage1;
_hostageTaker2 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_sideObjPosX + 2.4 , _sideObjPosY + 1], [], 0, "CAN_COLLIDE"];
_hostageTaker2 doWatch getPos _hostage2;
_hostageTaker3 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_sideObjPosX + 2.4 , _sideObjPosY - 1], [], 0, "CAN_COLLIDE"];
_hostageTaker3 doWatch getPos _hostage3;
_hostageTaker4 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_sideObjPosX + 2.4 , _sideObjPosY - 3], [], 0, "CAN_COLLIDE"];
_hostageTaker4 doWatch getPos _hostage4;
_hostageTaker5 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_sideObjPosX , _sideObjPosY + 6], [], 0, "CAN_COLLIDE"];
_hostageTaker5 setDir 0;
_hostageTaker6 = _hostageTakerGroup createUnit [(selectRandom _unittypes), [_sideObjPosX , _sideObjPosY - 6], [], 0, "CAN_COLLIDE"];
_hostageTaker6 setDir 180;
{	_x disableAI "PATH";
	_spawnedUnits = _spawnedUnits + [_x];
} forEach (units _hostageTakerGroup);
_groupsArray = _groupsArray + [_hostageTakerGroup];
_hostageTakerGroup setGroupIdGlobal [format ['Side-HostageTakers']];

{_x addCuratorEditableObjects [units _hostageGroup + units _hostageTakerGroup, false];} foreach allCurators;

//Spawn force protection
private _unittypes = ["I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"];
private _vehicletypes = ["I_G_Offroad_01_armed_F","I_static_AA_F","I_static_AA_F","I_static_AT_F","I_HMG_01_high_F","I_G_Offroad_01_armed_F"];

//infantry
private _MainInfAmount = 0;
for "_x" from 1 to 5 do {
	private _squadPos = [_flatPos, 5, 350, 2, 0, 20, 0] call BIS_fnc_findSafePos;
	private _infantryGroup = createGroup resistance;
	_MainInfAmount = _MainInfAmount + 1;
	_infantryGroup setGroupIdGlobal [format ['Side-MainInf-%1', _MainInfAmount]];

	for "_x" from 1 to 8 do {
		private _unit = selectRandom _unittypes;
		private _grpMember = _infantryGroup createUnit [_unit, _squadPos, [], 0, "NONE"];
	};
	[_infantryGroup, _flatPos, 275] call BIS_fnc_taskPatrol;
	_spawnedUnits = _spawnedUnits + units _infantryGroup;
	_groupsArray = _groupsArray + [_infantryGroup];	
	{_x addCuratorEditableObjects [units _infantryGroup, false];} foreach allCurators;
};

//vehicles
private _RandomVicAmount = 0;
for "_x" from 1 to 5 do {
	private _randomPos = [[[_flatPos, 350], []], ["water", "out"]] call BIS_fnc_randomPos;
	private _grp1 = createGroup resistance;
	_RandomVicAmount = _RandomVicAmount + 1;
	_grp1 setGroupIdGlobal [format ['Side-RandVic-%1', _RandomVicAmount]];
	private _vehicletype = selectRandom _vehicletypes;
	private _vehc =  _vehicletype createVehicle _randompos;
	_vehc allowCrewInImmobile true;
	_vehc lock 2;
	
	if (_vehicletype == "I_G_Offroad_01_armed_F") then {
	createVehicleCrew _vehc;
		(crew _vehc) join _grp1;
		[_grp1, _flatPos, 275] call BIS_fnc_taskPatrol;
		_grp1 setSpeedMode "LIMITED";
	}else{
	private _grpMember = _grp1 createUnit ["I_C_Soldier_Para_8_F", _flatpos, [], 0, "FORM"];
		_grpMember assignAsGunner _vehc;
		_grpMember moveInGunner _vehc;
		_vehc setDir (random 360);
	};

	_groupsArray = _groupsArray + [_grp1];
	_spawnedUnits = _spawnedUnits + units _grp1 + [_vehc];
	{_x addCuratorEditableObjects [(crew _vehc)+ [_vehc], false];} forEach allCurators;
};

//----------------task/circle/....
private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
sideMarkerText = "Free IDAP ";
"sideMarker" setMarkerText "Side Mission: Free IDAP";
[west,["FreeCivsTask"],[
"Hostile guerilla forces have taken local IDAP workers prisoner.  Find those IDAP guys and set them free.  According to intell hostile forces only have access to light vehicles and static weapons.  A deflector has given us these images of the site where the IDAP guys are being held:  <br/><br/><img image='Media\Briefing\IDAP.jpg' width='300' height='150'/>"
,"Side Mission:  Free IDAP","sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"search",true] call BIS_fnc_taskCreate;

	sideMissionSpawnComplete = true;
	publicVariableServer "sideMissionSpawnComplete";
	sideMissionUp = true;

	waitUntil {sleep 5; !sideMissionUp || civsFreed >= 3 || civsKilled >= 2 };

	if ( civsKilled >= 2 || !sideMissionUp ) then {
		//mission failed
		["FreeCivsTask", "Failed",true] call BIS_fnc_taskSetState;
	};

	if (civsFreed >= 3) then {
		//mission success
		 ["FreeCivsTask", "Succeeded",true] call BIS_fnc_taskSetState;
		 [] spawn AW_fnc_SMhintSUCCESS;	 
	};

	sideMissionUp = false;
	sleep 5;
	["FreeCivsTask",west] call bis_fnc_deleteTask;
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];
	sleep 120;
	{ deleteVehicle _x; sleep 0.1;} forEach _spawnedUnits;
	[_groupsArray] spawn AW_fnc_SMdelete;