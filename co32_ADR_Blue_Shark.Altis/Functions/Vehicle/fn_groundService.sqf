/*
Description: script that services ground vehicles.
[(thisList select 0)] remoteExec ["AW_fnc_grondService", driver (thisList select 0), false];

This are 2 scripts brought together and altered a bit by stanhope.  Original I&A service script written by Rarek, original Stilleto script written by Ryko.

last edited: 3/11/17 by stanhope

edited: initial rewrite
*/

//define private
private ["_ammo","_currentAmmo","_maxAmmo","_reloaded","_fuelSleepTimer","_ammoSleepTimer","_repairSleepTimer"];

//get vehicle
params ["_toServiceVehicle"];

if (driver _toServiceVehicle == _toServiceVehicle) exitWith {};
if !(_toServiceVehicle isKindOf "LandVehicle") exitWith { _toServiceVehicle vehicleChat "This pad is for ground-vehicles only, soldier!"; };

private _vehicleType = typeOf _toServiceVehicle;

private _unarmedCar = [
    "I_G_Offroad_01_repair_F",
    "I_G_Offroad_01_F",
    "I_Quadbike_01_F",
    "I_G_Quadbike_01_F",
    "I_MRAP_03_F",
    "I_Truck_02_covered_F",
    "I_Truck_02_transport_F",
    "I_Truck_02_ammo_F",
    "I_Truck_02_box_F",
    "I_Truck_02_medical_F",
    "I_Truck_02_fuel_F",
    "I_G_Van_01_transport_F",
    "I_G_Van_01_fuel_F",
    "I_UGV_01_F",
    "I_C_Offroad_02_unarmed_F",
    "I_C_Offroad_02_unarmed_brown_F",
    "I_C_Offroad_02_unarmed_olive_F",
    "I_C_Van_01_transport_F",
    "I_C_Van_01_transport_brown_F",
    "I_C_Van_01_transport_olive_F",
    "I_G_Van_02_transport_F",
    "I_C_Van_02_transport_F",
    "I_G_Van_02_vehicle_F",
    "I_C_Van_02_vehicle_F",
    "B_MRAP_01_F",
    "B_G_Offroad_01_repair_F",
    "B_G_Offroad_01_F",
    "B_Quadbike_01_F",
    "B_G_Quadbike_01_F",
    "B_Truck_01_transport_F",
    "B_Truck_01_covered_F",
    "B_Truck_01_mover_F",
    "B_Truck_01_box_F",
    "B_Truck_01_Repair_F",
    "B_Truck_01_ammo_F",
    "B_Truck_01_fuel_F",
    "B_Truck_01_medical_F",
    "B_G_Van_01_transport_F",
    "B_G_Van_01_fuel_F",
    "B_UGV_01_F",
    "B_T_LSV_01_unarmed_F",
    "B_T_LSV_01_unarmed_CTRG_F",
    "B_LSV_01_unarmed_F",
    "B_CTRG_LSV_01_light_F",
    "B_LSV_01_unarmed_black_F",
    "B_LSV_01_unarmed_olive_F",
    "B_LSV_01_unarmed_sand_F",
    "B_T_LSV_01_unarmed_black_F",
    "B_T_LSV_01_unarmed_olive_F",
    "B_T_LSV_01_unarmed_sand_F",
    "B_T_MRAP_01_F",
    "B_GEN_Offroad_01_gen_F",
    "B_T_Quadbike_01_F",
    "B_T_Truck_01_mover_F",
    "B_T_Truck_01_ammo_F",
    "B_T_Truck_01_box_F",
    "B_T_Truck_01_fuel_F",
    "B_T_Truck_01_medical_F",
    "B_T_Truck_01_Repair_F",
    "B_T_Truck_01_transport_F",
    "B_T_Truck_01_covered_F",
    "B_G_Van_02_transport_F",
    "B_G_Van_02_vehicle_F",
    "O_MRAP_02_F",
    "O_G_Offroad_01_repair_F",
    "O_G_Offroad_01_F",
    "O_Quadbike_01_F",
    "O_G_Quadbike_01_F",
    "O_Truck_02_covered_F",
    "O_Truck_02_transport_F",
    "O_Truck_02_box_F",
    "O_Truck_02_medical_F",
    "O_Truck_02_Ammo_F",
    "O_Truck_02_fuel_F",
    "O_G_Van_01_transport_F",
    "O_G_Van_01_fuel_F",
    "O_UGV_01_F",
    "O_Truck_03_transport_F",
    "O_Truck_03_covered_F",
    "O_Truck_03_repair_F",
    "O_Truck_03_ammo_F",
    "O_Truck_03_fuel_F",
    "O_Truck_03_medical_F",
    "O_Truck_03_device_F",
    "O_T_LSV_02_unarmed_F",
    "O_T_LSV_02_unarmed_viper_F",
    "O_LSV_02_unarmed_F",
    "O_LSV_02_unarmed_viper_F",
    "O_T_LSV_02_unarmed_black_F",
    "O_T_LSV_02_unarmed_ghex_F",
    "O_T_LSV_02_unarmed_arid_F",
    "O_LSV_02_unarmed_black_F",
    "O_LSV_02_unarmed_ghex_F",
    "O_LSV_02_unarmed_arid_F",
    "O_T_MRAP_02_ghex_F",
    "O_G_Van_02_transport_F",
    "O_G_Van_02_vehicle_F"
];
private _armedCar = [
    "I_G_Offroad_01_armed_F",
    "I_MRAP_03_hmg_F",
    "I_MRAP_03_gmg_F",
    "I_UGV_01_rcws_F",
    "B_MRAP_01_gmg_F",
    "B_MRAP_01_hmg_F",
    "B_G_Offroad_01_armed_F",
    "B_UGV_01_rcws_F",
    "B_T_LSV_01_armed_F",
    "B_T_LSV_01_armed_CTRG_F",
    "B_LSV_01_armed_F",
    "B_LSV_01_armed_black_F",
    "B_LSV_01_armed_olive_F",
    "B_LSV_01_armed_sand_F",
    "B_T_LSV_01_armed_black_F",
    "B_T_LSV_01_armed_olive_F",
    "B_T_LSV_01_armed_sand_F",
    "B_T_MRAP_01_gmg_F",
    "B_T_MRAP_01_hmg_F",
    "O_MRAP_02_hmg_F",
    "O_MRAP_02_gmg_F",
    "O_G_Offroad_01_armed_F",
    "O_UGV_01_rcws_F",
    "O_T_LSV_02_armed_F",
    "O_T_LSV_02_armed_viper_F",
    "O_LSV_02_armed_F",
    "O_LSV_02_armed_viper_F",
    "O_T_LSV_02_armed_black_F",
    "O_T_LSV_02_armed_ghex_F",
    "O_T_LSV_02_armed_arid_F",
    "O_LSV_02_armed_black_F",
    "O_LSV_02_armed_ghex_F",
    "O_LSV_02_armed_arid_F",
    "O_T_MRAP_02_hmg_ghex_F",
    "O_T_MRAP_02_gmg_ghex_F",
    "O_T_Quadbike_01_ghex_F",
    "O_T_Truck_03_transport_ghex_F",
    "O_T_Truck_03_covered_ghex_F",
    "O_T_Truck_03_repair_ghex_F",
    "O_T_Truck_03_ammo_ghex_F",
    "O_T_Truck_03_fuel_ghex_F",
    "O_T_Truck_03_medical_ghex_F",
    "O_T_Truck_03_device_ghex_F",
    "O_T_UGV_01_ghex_F"
];
private _APC = [
    "B_APC_Tracked_01_rcws_F",
    "B_APC_Tracked_01_CRV_F",
    "B_T_APC_Tracked_01_CRV_F",
    "B_T_APC_Tracked_01_rcws_F",
    "O_APC_Wheeled_02_rcws_F",
    "O_T_UGV_01_rcws_ghex_F",
    "O_T_APC_Wheeled_02_rcws_ghex_F"
];
private _IFV = [
    "I_APC_tracked_03_cannon_F",
    "I_APC_Wheeled_03_cannon_F",
    "B_APC_Tracked_01_AA_F",
    "B_APC_Wheeled_01_cannon_F",
    "B_T_APC_Tracked_01_AA_F",
    "B_T_APC_Wheeled_01_cannon_F",
    "O_APC_Tracked_02_cannon_F",
    "O_APC_Tracked_02_AA_F",
    "O_T_APC_Tracked_02_cannon_ghex_F",
    "O_T_APC_Tracked_02_AA_ghex_F"
];
private _MBT = [
    "I_MBT_03_cannon_F",
    "B_MBT_01_cannon_F",
    "B_MBT_01_arty_F",
    "B_MBT_01_mlrs_F",
    "B_MBT_01_TUSK_F",
    "B_T_MBT_01_arty_F",
    "B_T_MBT_01_mlrs_F",
    "B_T_MBT_01_cannon_F",
    "B_T_MBT_01_TUSK_F",
    "O_MBT_02_cannon_F",
    "O_MBT_02_arty_F",
    "O_T_MBT_02_cannon_ghex_F",
    "O_T_MBT_02_arty_ghex_F"
];

if (_vehicleType in _unarmedCar) then {
    _repairSleepTimer = 0.5;
    _ammoSleepTimer = 0;
    _fuelSleepTimer = 0.5;
};
if (_vehicleType in _armedCar) then {
    _repairSleepTimer = 0.5;
    _ammoSleepTimer = 0.5;
    _fuelSleepTimer = 0.5;
};
if (_vehicleType in _APC) then {
    _repairSleepTimer = 2;
    _ammoSleepTimer = 1.5;
    _fuelSleepTimer = 1.5;
};
if (_vehicleType in _IFV) then {
    _repairSleepTimer = 4;
    _ammoSleepTimer = 3;
    _fuelSleepTimer = 3;
};
if (_vehicleType in _MBT) then {
    _repairSleepTimer = 6;
    _ammoSleepTimer = 6;
    _fuelSleepTimer = 4;
};

if ( !(_vehicleType in _MBT) && !(_vehicleType in _IFV) && !(_vehicleType in _APC)
    && !(_vehicleType in _armedCar) && !(_vehicleType in _unarmedCar) )
then {
    _repairSleepTimer = 1;
    _ammoSleepTimer = 1;
    _fuelSleepTimer = 1;
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