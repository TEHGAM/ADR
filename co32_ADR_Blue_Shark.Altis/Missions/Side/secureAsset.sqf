/*
author: stanhope, AW community member.

description:    Reworked version of securechopper.sqf made by Quiksilver,
                expanded to be more than just choopers and to have more rencent coding.

Last modified: 23/10/2017 by stanhope

Modified: initial release
*/

private _missionType = selectRandom[
    ['an MI-48 Kajman', 'O_Heli_Attack_02_black_F'],
    ['an AH-99 Blackfoot', 'B_Heli_Attack_01_F'],
    ['a PO-30 Orca', 'O_Heli_Light_02_F'],
    ['a T-100 Varsuk', 'O_MBT_02_cannon_F'],
    ['an MBT-52 Kuma', 'I_MBT_03_cannon_F'],
    ['an M2A4 Slammer (Urban Purpose)', 'B_MBT_01_TUSK_F'],
    ['an AFV-4 Gorgon', 'I_APC_Wheeled_03_cannon_F'],
    ['an AMV-7 Marshall', 'B_APC_Wheeled_01_cannon_F'],
    ['an IFV-6a Cheetah', 'B_APC_Tracked_01_AA_F'],
    ['a CRV-6e Bobcat', 'B_APC_Tracked_01_CRV_F']
];

private _description = _missionType select 0;
private _assetType = _missionType select 1;

private _noSpawning =  BaseArray + [currentAO];
private _noSpawningRange = 2500;

//-------------------- FIND SAFE POSITION FOR OBJECTIVE

private _flatPos = [];
private _accepted = false;
while {!_accepted} do {
       while {(count _flatPos) < 2} do {
        _position = [] call BIS_fnc_randomPos;
        _flatPos = _position isFlatEmpty [5,0,0.2,sizeOf "Land_TentHangar_V1_F",0,false];
    };

    _accepted = true;
    {
        _NearBaseLoc = _flatPos distance (getMarkerPos _x);
        if (_NearBaseLoc < _noSpawningRange) then {_accepted = false;};
    } forEach _noSpawning;
};
  
//----------------spawn objective

private _tentDirection = random 360;

private _hangar = "Land_TentHangar_V1_F" createVehicle _flatPos;
sideObj = _assetType createVehicle _flatPos;
waitUntil {!isNull sideObj};
sideObj lock 3;
{
    _x setVectorUp surfaceNormal position _x;
    _x setDir _tentDirection;
}forEach[_hangar, sideObj];

//-----add actions and eventhandler

[sideObj,"Secure asset",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\documents_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\download_ca.paa",
"_target distance _this <= 4","_target distance _this <= 4",
{	hint "Securing asset..."; 
	params ["","_hero"];
    if ( currentWeapon _hero != "" ) then
    {	_hero action ["SwitchWeapon", _hero, _hero, 99]; };
    _hero playMoveNow "AinvPknlMstpSnonWnonDnon_medic3";
},{},{
    _name = name (_this select 1);
    _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 secured the asset.  Friendly forces have moved it to main base.</t>",_name];
    [_sidecompleted] remoteExec ["AW_fnc_globalHint",0,false];
    sleep 4;
    SM_SUCCESS = true;
	publicVariableServer "SM_SUCCESS";
    sideMissionUp = false;
	publicVariableServer "sideMissionUp";
},{
	hint "You stopped securing the asset"; 
	private _unit = _this select 1;
    _unit playMoveNow "";
},[],5, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

sideObj addEventHandler ["Killed",{
	params ["_unit","","_killer"];
	_name = name _killer;
	if (_name == "Error: No vehicle") then{
	    _name = "Someone";
	};
	_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Aset destroyed</t><br/>____________________<br/>%1 destroyed the asset, mission failed.",_name];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
	SM_SUCCESS = false;
	publicVariableServer "SM_SUCCESS";
    sideMissionUp = false;
	publicVariableServer "sideMissionUp";
}];

//-------------------- SPAWN FORCE PROTECTION
private _enemiesArray = [sideObj] call AW_fnc_SMenemyEAST;

//-------------------- BRIEF
	private _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];

	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = format["Side Mission: Secure %1", _description];
	"sideMarker" setMarkerText sideMarkerText;
	private _briefingText = format["OPFOR forces have stached %1 in a hangar somewhere on the island. We've marked the suspected location on your map; head to the hangar and secure that asset.", _description];
    [west,["secureAssetTask"],[_briefingText,sideMarkerText,"sideCircle"],(getMarkerPos "sideCircle"),"Created",0,true,"interact",true] call BIS_fnc_taskCreate;

//----------Mission core--------------
sideMissionUp = true;
SM_SUCCESS = false;
sideMissionSpawnComplete = true;
publicVariableServer "sideMissionSpawnComplete";

waitUntil{sleep 5; !sideMissionUp};

//-------------------- DE-BRIEFING
    if (!alive sideObj) then {
        ["secureAssetTask", "Failed",true] call BIS_fnc_taskSetState;
        SM_SUCCESS = false;
        deleteVehicle sideObj;
	};

    if (SM_SUCCESS) then {
          [_missionType] call AW_fnc_SMhintSUCCESS;
          ["secureAssetTask", "SUCCEEDED",true] call BIS_fnc_taskSetState;
          deleteVehicle sideObj;
     };

//=========Cleanup===========
    sleep 5;
    ["secureAssetTask",west] call bis_fnc_deleteTask;
    { _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];

    //--------------------- DELETE
	
	sleep 120;
	 [_enemiesArray] spawn AW_fnc_SMdelete;
    if (alive sideObj) then{
        deleteVehicle sideObj;
    };
    if (alive _hanger ) then{
        deleteVehicle _hanger;
    }else{
        deleteVehicle nearestObject [_flatPos,"Land_TentHangar_V1_ruins_F"];
    };
   