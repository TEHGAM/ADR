/*
@file: easterEggs.sqf
Author:

	Quiksilver
	
Description:

	A hastily-written script, to spawn some vehicles around the island.
	Players seem to like it.
	Re-code at a later date.
	
	Runs when mission starts, if PARAMS_EasterEggs == 1
_______________________________________________________________________*/

private ["_flatPos","_easterEgg","_position","_accepted","_airEgg1","_airEgg2","_airEgg3","_airEgg4"];

#define AIR_EGGS "I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","B_Plane_CAS_01_F","O_Plane_CAS_02_F","C_Hatchback_01_F","C_SUV_01_F","C_Kart_01_F"
_airEgg1 = getMarkerPos "airfield1";
_airEgg2 = getMarkerPos "airfield2";
_airEgg3 = getMarkerPos "airfield3";
_airEgg4 = getMarkerPos "airfield4";

{
	_flatPos = [0,0,0];
	_accepted = false;
	while {!_accepted} do {
		_position = [[[] call BIS_fnc_worldArea],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty [2,0,0.2,3,1,false];

		while {(count _flatPos) < 2} do {
			_position = [[[] call BIS_fnc_worldArea],["water","out"]] call BIS_fnc_randomPos;
			_flatPos = _position isFlatEmpty [2,0,0.2,3,1,false];
		};

		if (_position distance (getMarkerPos "respawn_west") > 800) then {
			_accepted = true;
		};
	};
	_easterEgg = _x createVehicle _flatPos;
	waitUntil {!isNull _easterEgg};
	_easterEgg setVariable ["slingable",TRUE,TRUE];
	_easterEgg setDir (random 360);
} forEach ["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F","B_APC_Tracked_01_AA_F","B_MBT_01_cannon_F","I_MBT_03_cannon_F","I_MBT_03_cannon_F"];

sleep 1;

air1 = [AIR_EGGS] call BIS_fnc_selectRandom createVehicle _airEgg1;
sleep 0.1;
air2 = [AIR_EGGS] call BIS_fnc_selectRandom createVehicle _airEgg2;
sleep 0.1;
air3 = [AIR_EGGS] call BIS_fnc_selectRandom createVehicle _airEgg3;
sleep 0.1;
air4 = [AIR_EGGS] call BIS_fnc_selectRandom createVehicle _airEgg4;

{ _x setDir (random 360) } forEach [air1,air2,air3,air4];
