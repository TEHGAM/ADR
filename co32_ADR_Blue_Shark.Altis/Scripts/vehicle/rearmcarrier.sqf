/*
Description:  Script that will service planes, UAVs and helis.  Inted for use on the USS freedom.

Based off of existing service scripts from I&A 3.1.5

author:  unknown

Last edited: 26/06/2017

edited:  Combined rearmplane, rearmuav & rearmhelicopter into 1

To be called from a trigger like this:
activation: BLUFOR
Repeatable: yes

condition:
this and ((getPos (thisList select 0)) select 2 < 1)

on activation:
_handle = [(thisList select 0)] execVM "scripts\vehicle\rearmcarrier.sqf";

*/
private ["_veh","_uav"];
_veh = _this select 0;
//=====================================service helicopter================================
if (_veh isKindOf "Helicopter") exitWith {

if (!alive _veh) exitWith {};

_veh vehicleChat "Servicing aircraft, please wait ...";
_veh setFuel 0;

//---------- RE-ARMING
sleep 10;
_veh vehicleChat "Re-arming ...";

//---------- REPAIRING
sleep 10;
_veh vehicleChat "Repairing ...";

//---------- REFUELING
sleep 10;
_veh vehicleChat "Refueling ...";

//---------- FINISHED
sleep 10;
_veh setDamage 0;
_veh vehicleChat "Repaired (100%).";
_veh setVehicleAmmo 1;
_veh addWeapon "CMFlareLauncher";
_veh removeMagazines "300Rnd_CMFlare_Chaff_Magazine";
_veh addmagazine "300Rnd_CMFlare_Chaff_Magazine";
_veh addmagazine "300Rnd_CMFlare_Chaff_Magazine";
_veh vehicleChat "Re-armed (100%).";
_veh setFuel 1;
_veh vehicleChat "Refuelled (100%).";
sleep 1;
_veh vehicleChat "Service complete.";
};


//========================service UAVs=====================
if ((_veh isKindOf "UAV")) exitWith {

if (!alive _veh) exitWith {};

_veh vehicleChat "Servicing UAV, please wait ...";

_veh setFuel 0;
sleep 10;
//---------- RE-ARMING
_veh vehicleChat "Re-arming ...";
sleep 100;
//---------- REPAIRING
_veh vehicleChat "Repairing ...";
sleep 100;
//---------- REFUELING
_veh vehicleChat "Refueling ...";
sleep 50;
//---------- FINISHED

_veh setDamage 0;
_veh vehicleChat "Repaired (100%).";
_veh setVehicleAmmo 1;
_veh vehicleChat "Re-armed (100%).";
_veh setFuel 1;
_veh vehicleChat "Refuelled (100%).";

sleep 2;
_veh vehicleChat "Service complete.";
};



//=========================service planes====================
if ((_veh isKindOf "Plane")&& !(_veh isKindOf "UAV")) exitWith {

if (!alive _veh) exitWith {};

if (!(_veh isKindOf "plane")) exitWith { 
	_veh vehicleChat "This pad is for plane service only, soldier!"; 
};

_veh vehicleChat "Servicing airplane, this will take about 10 minutes";
_veh setFuel 0;

//---------- RE-ARMING
sleep 200;
_veh vehicleChat "Re-arming ...";

//---------- REPAIRING
sleep 200;
_veh vehicleChat "Repairing ...";

//---------- REFUELING
sleep 200;
_veh vehicleChat "Refueling ...";

//---------- FINISHED

sleep 10;
_veh setDamage 0;
_veh vehicleChat "Repaired (100%).";

_veh setVehicleAmmo 1;
_veh vehicleChat "Re-armed (100%).";

_veh setFuel 1;
_veh vehicleChat "Refuelled (100%).";

sleep 2;
_veh vehicleChat "Service complete.";
};

if (!(_veh isKindOf "Plane")|| !(_veh isKindOf "UAV")||!(_veh isKindOf "Helicopter")) exitWith {
_veh vehicleChat "Your vehicle cannot be serviced here soldier";
};


