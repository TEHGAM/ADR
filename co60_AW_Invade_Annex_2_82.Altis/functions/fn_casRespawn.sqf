/*
@filename: fn_casRespawn.sqf
Author: 

	Quiksilver
	
Last modified:

	10/08/2014 ArmA 1.24 by Quiksilver

Description: 

	Respawn CAS vehicle at base, if it is dead. Currently configured as AO-completion reward.

___________________________________________________________________________*/

if (PARAMS_CasFixedWingSupport == 0) exitWith {};
if (alive casJet) exitWith {};

private ["_newCas","_casTypes","_pos","_dir","_obstructions","_obstructionArray"];

_casTypes = ["I_Plane_Fighter_03_CAS_F","O_Plane_CAS_02_F","B_Plane_CAS_01_F","I_Plane_Fighter_03_AA_F"];

if (PARAMS_CasFixedWingSupport == 1) then {
	_newCas = "B_Plane_CAS_01_F";
};
if (PARAMS_CasFixedWingSupport == 2) then {
	_newCas = "I_Plane_Fighter_03_AA_F";
};
if (PARAMS_CasFixedWingSupport == 3) then {
	_newCas = "I_Plane_Fighter_03_CAS_F";
};
if (PARAMS_CasFixedWingSupport == 4) then {
	_newCas = "O_Plane_CAS_02_F";
};
if (PARAMS_CasFixedWingSupport == 5) then {
	_newCas = _casTypes select (floor (random (count _casTypes))); 
};
	
_pos = [14453.3,16279.6,-0.207581];
_dir = 207.882;

[_pos,15,20,50] call QS_fnc_clearPosition;

[_pos,_dir,_newCas] spawn {
	private ["_pos","_dir","_newCas"];
	_pos = _this select 0;
	_dir = _this select 1;
	_newCas = _this select 2;

	sleep 3;

	casJet = createVehicle [_newCas,[0,0,30000],[],0,"NONE"];
	casJet setDir _dir;
	casJet setPos _pos;
	casJet lock 0;
		
	if (PARAMS_CasATGM == 0) then {
		if (casJet isKindOf "I_Plane_Fighter_03_CAS_F") then {
			casJet removeWeapon "missiles_SCALPEL";
		};
		if (casJet isKindOf "B_Plane_CAS_01_F") then {
			casJet removeWeapon "Missile_AGM_02_Plane_CAS_01_F";
		};
		if (casJet isKindOf "O_Plane_CAS_02_F") then {
			casJet removeWeapon "Missile_AGM_01_Plane_CAS_02_F";
		};
		if (casJet isKindOf "B_UAV_02_F") then {
			casJet removeWeapon "missiles_SCALPEL";
		};
	};
};