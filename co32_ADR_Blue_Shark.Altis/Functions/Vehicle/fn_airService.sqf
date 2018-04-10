/*
Description: script that services ground vehicles.
[(thisList select 0)] remoteExec ["AW_fnc_airService", driver (thisList select 0), false];

This are 2 scripts brought together and altered a bit by stanhope.  Original I&A service script written by Rarek, original Stilleto script written by Ryko.

last edited: 3/11/17 by stanhope

edited: initial rewrite
*/

//define private
private ["_ammo","_currentAmmo","_maxAmmo","_reloaded","_fuelSleepTimer","_ammoSleepTimer","_repairSleepTimer"];

//get vehicle
params ["_toServiceVehicle"];

if (driver _toServiceVehicle == _toServiceVehicle) exitWith {};
if (_toServiceVehicle isKindOf "LandVehicle") exitWith { _toServiceVehicle vehicleChat "This pad is for air-vehicles only, soldier!"; };

private _vehicleType = typeOf _toServiceVehicle;

private _transportChoppers = [
    "B_Heli_Light_01_F",
    "B_Heli_Light_01_stripped_F",
    "B_Heli_Transport_01_F",
    "B_Heli_Transport_01_camo_F",
    "B_Heli_Transport_03_F",
    "B_Heli_Transport_03_unarmed_F",
    "B_Heli_Transport_03_black_F",
    "B_Heli_Transport_03_unarmed_green_F",
    "B_CTRG_Heli_Transport_01_sand_F",
    "B_CTRG_Heli_Transport_01_tropic_F",
    "I_Heli_Transport_02_F",
    "I_Heli_light_03_unarmed_F",
    "I_C_Heli_Light_01_civil_F",
    "O_Heli_Light_02_unarmed_F",
    "O_Heli_Transport_04_F",
    "O_Heli_Transport_04_ammo_F",
    "O_Heli_Transport_04_bench_F",
    "O_Heli_Transport_04_box_F",
    "O_Heli_Transport_04_covered_F",
    "O_Heli_Transport_04_fuel_F",
    "O_Heli_Transport_04_medevac_F",
    "O_Heli_Transport_04_repair_F",
    "O_Heli_Transport_04_black_F",
    "O_Heli_Transport_04_ammo_black_F",
    "O_Heli_Transport_04_bench_black_F",
    "O_Heli_Transport_04_box_black_F",
    "O_Heli_Transport_04_covered_black_F",
    "O_Heli_Transport_04_fuel_black_F",
    "O_Heli_Transport_04_medevac_black_F",
    "O_Heli_Transport_04_repair_black_F"
 ];
private _heavyAttackChoppers = [
    "B_Heli_Attack_01_F",
    "B_Heli_Attack_01_dynamicLoadout_F",
    "O_Heli_Attack_02_F",
    "O_Heli_Attack_02_black_F",
    "O_Heli_Attack_02_dynamicLoadout_F",
    "O_Heli_Attack_02_dynamicLoadout_black_F"
];

private _lightAttackChoppers = [
    "O_Heli_Light_02_dynamicLoadout_F",
    "O_Heli_Light_02_F",
    "O_Heli_Light_02_v2_F",
    "B_Heli_Light_01_armed_F",
    "B_Heli_Light_01_dynamicLoadout_F",
    "I_Heli_light_03_F",
    "I_Heli_light_03_dynamicLoadout_F"
];

private _transportAircraft = [
    "B_T_VTOL_01_infantry_F",
    "B_T_VTOL_01_vehicle_F",
    "B_T_VTOL_01_infantry_blue_F",
    "B_T_VTOL_01_infantry_olive_F",
    "B_T_VTOL_01_vehicle_blue_F",
    "B_T_VTOL_01_vehicle_olive_F",
    "O_T_VTOL_02_infantry_F",
    "O_T_VTOL_02_vehicle_F",
    "O_T_VTOL_02_infantry_dynamicLoadout_F",
    "O_T_VTOL_02_vehicle_dynamicLoadout_F",
    "O_T_VTOL_02_infantry_hex_F",
    "O_T_VTOL_02_infantry_ghex_F",
    "O_T_VTOL_02_infantry_grey_F",
    "O_T_VTOL_02_vehicle_hex_F",
    "O_T_VTOL_02_vehicle_ghex_F",
    "O_T_VTOL_02_vehicle_grey_F"
];
private _attackAircraft = [
    "B_T_VTOL_01_armed_F",
    "B_T_VTOL_01_armed_blue_F",
    "B_T_VTOL_01_armed_olive_F",
    "B_Plane_CAS_01_F",
    "B_Plane_CAS_01_dynamicLoadout_F",
    "B_Plane_CAS_01_Cluster_F",
    "B_Plane_Fighter_01_Cluster_F",
    "B_Plane_Fighter_01_F",
    "B_Plane_Fighter_01_Stealth_F",
    "O_Plane_Fighter_02_F",
    "O_Plane_Fighter_02_Stealth_F",
    "O_Plane_Fighter_02_Cluster_F",
    "O_Plane_CAS_02_Cluster_F",
    "O_Plane_CAS_02_F",
    "O_Plane_CAS_02_dynamicLoadout_F",
    "I_Plane_Fighter_03_CAS_F",
    "I_Plane_Fighter_03_AA_F",
    "I_Plane_Fighter_03_dynamicLoadout_F",
    "I_Plane_Fighter_04_F",
    "I_Plane_Fighter_03_Cluster_F",
    "I_Plane_Fighter_04_Cluster_F"
];

private _UAVs = [
    "B_UAV_01_F",
    "B_UAV_02_F",
    "B_UAV_02_CAS_F",
    "B_UAV_02_dynamicLoadout_F",
    "B_T_UAV_03_F",
    "B_T_UAV_03_dynamicLoadout_F",
    "B_UAV_05_F",
    "B_UAV_06_F",
    "B_UAV_06_medical_F"
];

if( !(_vehicleType in _attackAircraft ) && !(_vehicleType in _transportAircraft ) &&
    !(_vehicleType in _lightAttackChoppers ) && !(_vehicleType in _heavyAttackChoppers ) &&
    !(_vehicleType in _transportChoppers ) && !(_vehicleType in _UAVs ))
then {
    _repairSleepTimer = 1;
    _ammoSleepTimer = 1;
    _fuelSleepTimer = 1;
};
if (_vehicleType in _UAVs ) then {
    _repairSleepTimer = 2;
    _ammoSleepTimer = 2;
    _fuelSleepTimer = 2;
};
if (_vehicleType in _attackAircraft ) then {
    _repairSleepTimer = 8;
    _ammoSleepTimer = 8;
    _fuelSleepTimer = 4;
};
if (_vehicleType in _transportAircraft ) then {
    _repairSleepTimer = 2;
    _ammoSleepTimer = 2;
    _fuelSleepTimer = 2;
};
if (_vehicleType in _lightAttackChoppers ) then {
    _repairSleepTimer = 2;
    _ammoSleepTimer = 1;
    _fuelSleepTimer = 2;
};
if (_vehicleType in _heavyAttackChoppers ) then {
    _repairSleepTimer = 4;
    _ammoSleepTimer = 6;
    _fuelSleepTimer = 2;
};
if (_vehicleType in _transportChoppers ) then {
    _repairSleepTimer = 1;
    _ammoSleepTimer = 1;
    _fuelSleepTimer = 2;
};

//other general stuff:
private _toServiceVehicleName = getText( configFile >> "CfgVehicles" >> typeOf _toServiceVehicle >> "DisplayName" );
private _serviceAborted = false;

if !( alive _toServiceVehicle ) exitWith{
	hint parseText format ["<t font='puristaBold' size='1.4' align='center'>SERVICE ABORTED<br /></t><t font='puristaLight' align='center'>%1<br />This vehicle is beyond repair. Scrapping vehicle...</t>", _toServiceVehicleName];
	sleep 5;
	deleteVehicle _toServiceVehicle;
	sleep 3;
	hint "";
};

//cut the engine:
private _fuelLevel = fuel _toServiceVehicle;
sleep 0.5;
_toServiceVehicle setFuel 0;
sleep 2;
_toServiceVehicle setFuel _fuelLevel;

//==================================actual script starts========================
hint parseText format [
	"<t font='puristaBold' size='1.4' align='center'>SERVICING COMMENCING</t>
	<br /><t font='puristaLight' align='center'>%1
	<br />Do not turn the engine on while the vehicle is servicing</t>"
, _toServiceVehicleName];

//====================Repair===================
private _damage = getDammage _toServiceVehicle;

while {(_damage > 0) && !_serviceAborted} do {

	_damage = getDammage _toServiceVehicle;
	_toServiceVehicle setDamage (_damage - 0.01);

	if (_damage <= 0 ) exitWith {
		hint parseText format ["<t font='puristaBold' size='1.4' align='center'>SERVICING VEHICLE<br /></t><t font='puristaLight' align='center'>%1<br />Repaired</t>", _toServiceVehicleName];
		_toServiceVehicle setDamage 0;
		sleep 2;
	};

	if (isEngineOn _toServiceVehicle) exitWith {
	_serviceAborted = true;
	};

	_percent = 100 - (_damage *100);
	hint parseText format ["<t font='puristaBold' size='1.4' align='center'>SERVICING VEHICLE<br /></t><t font='puristaLight' align='center'>%1<br />Repairing (%2%3)</t>", _toServiceVehicleName, floor (_percent),"%"];
	sleep _repairSleepTimer;
};

//==================rearm======================
While {!_serviceAborted} do {

	_totalAmmo = 0;
	_maxAmmo = 0;
	_getVehicleAmmo = 1;
	{
	 _totalAmmo = _totalAmmo + (_x select 2);
	 _maxAmmo = _maxAmmo + (getNumber(configFile >> "CfgMagazines" >> (_x select 0) >> "count"));
	} forEach (magazinesAllTurrets _toServiceVehicle);
	
	if !(_maxAmmo == 0 || _totalAmmo == _maxAmmo) then {
		_getVehicleAmmo = _totalAmmo/_maxAmmo; 
	};
	
	if (isEngineOn _toServiceVehicle) exitWith {
		_serviceAborted = true;
	};
	
	if (_getVehicleAmmo >= 1) exitWith{
		hint parseText format ["<t font='puristaBold' size='1.4' align='center'>VEHICLE SERVICE<br /></t><t font='puristaLight' align='center'>%1<br />Vehicle Rearmed.</t>", _toServiceVehicleName];
		[_toServiceVehicle, 1] remoteExecCall ["setVehicleAmmo", 0, true];
		sleep 2;
	};
	
	hint str _getVehicleAmmo;
	_toServiceVehicle setVehicleAmmo (_getVehicleAmmo + 0.01);
	hint parseText format ["<t font='puristaBold' size='1.4' align='center'>VEHICLE SERVICE<br /></t><t font='puristaLight' align='center'>%3<br />Rearming (%1%2)...</t>", floor ((_getVehicleAmmo + 0.01) * 100), "%", _toServiceVehicleName];
	sleep _ammoSleepTimer;
};


//==========refuel==========
_toServiceVehicle setFuel _fuelLevel;
while {(_fuelLevel < 1) && !_serviceAborted} do {

	_fuelLevel = fuel _toServiceVehicle;
	_toServiceVehicle setFuel (_fuelLevel + 0.01);

	if (isEngineOn _toServiceVehicle) exitWith {
	_serviceAborted = true;
	};

	if (_fuelLevel >= 1 ) exitWith {
		hint parseText format ["<t font='puristaBold' size='1.4' align='center'>SERVICING VEHICLE<br /></t><t font='puristaLight' align='center'>%1<br />Refueled</t>", _toServiceVehicleName];
		_toServiceVehicle setFuel 1;
		sleep 2;
	};

	_percent = _fuelLevel *100;
	hint parseText format ["<t font='puristaBold' size='1.4' align='center'>SERVICING VEHICLE<br /></t><t font='puristaLight' align='center'>%1<br />Refueling (%2%3)</t>", _toServiceVehicleName,floor (_percent),"%"];
	sleep _fuelSleepTimer;
	
};

if (_serviceAborted) exitWith {
	hint parseText format ["<t font='puristaBold' size='1.4' align='center'>SERVICE ABORTED<br /></t><t font='puristaLight' align='center'>%1<br />Engine was turned on, service aborted</t>", _toServiceVehicleName];
};

_toServiceVehicle setFuel 1;
_toServiceVehicle setDamage 0;
_toServiceVehicle setVehicleAmmo 1;
hint parseText format ["<t font='puristaBold' size='1.4' align='center'>SERVICE COMPLETED<br /></t><t font='puristaLight' align='center'>%1</t>", _toServiceVehicleName];
sleep 10;

