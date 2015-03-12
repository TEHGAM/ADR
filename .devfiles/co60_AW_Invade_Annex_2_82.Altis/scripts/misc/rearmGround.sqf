/*
      ::: ::: :::             ::: :::             ::: 
     :+: :+:   :+:           :+:   :+:           :+:  
    +:+ +:+     +:+         +:+     +:+         +:+   
   +#+ +#+       +#+       +#+       +#+       +#+    
  +#+ +#+         +#+     +#+         +#+     +#+     
 #+# #+#           #+#   #+#           #+#   #+#      
### ###             ### ###             ### ###      

| AHOY WORLD | ARMA 3 ALPHA | STRATIS DOMI VER 2.7 |

Creating working missions of this complexity from
scratch is difficult and time consuming, please
credit http://www.ahoyworld.co.uk for creating and
distibuting this mission when hosting!

This version of Domination was lovingly crafted by
Jack Williams (Rarek) for Ahoy World!
*/


private ["_damage","_percentage","_veh","_vehType","_fuelLevel"];
_veh = _this select 0;
_vehType = getText(configFile>>"CfgVehicles">>typeOf _veh>>"DisplayName");

//if (_veh isKindOf "LandVehicle") exitWith { _veh vehicleChat "This pad is for vehicle service only, soldier!"; };

_fuelLevel = fuel _veh;
_damage = getDammage _veh;
_veh setFuel 0;

_veh vehicleChat format ["Repairing and refuelling %1. Stand by...", _vehType];

while {_damage > 0} do
{
	sleep 0.5;
	_percentage = 100 - (_damage * 100);
	_veh vehicleChat format ["Repairing (%1%)...", floor _percentage];
	if ((_damage - 0.01) <= 0) then
	{
		_veh setDamage 0;
		_damage = 0;
	} else {
		_veh setDamage (_damage - 0.01);
		_damage = _damage - 0.01;
	};
};

_veh vehicleChat "Repaired (100%).";

while {_fuelLevel < 1} do
{
	sleep 0.5;
	_percentage = (_fuelLevel * 100);
	_veh vehicleChat format["Refuelling (%1%)...", floor _percentage];
	if ((_fuelLevel + 0.01) >= 1) then
	{
		_veh setFuel 1;
		_fuelLevel = 1;
	} else {
		_fuelLevel = _fuelLevel + 0.01;
	};
};

_veh vehicleChat "Refuelled (100%).";

sleep 2;

_magazines = getArray(configFile >> "CfgVehicles" >> _vehType >> "magazines");

if (count _magazines > 0) then {
	_removed = [];
	{
		if (!(_x in _removed)) then {
			_veh removeMagazines _x;
			_removed = _removed + [_x];
		};
	} forEach _magazines;
	{
		_veh vehicleChat format ["Reloading %1", _x];
		sleep 0.05;
		_veh addMagazine _x;
	} forEach _magazines;
};

_count = count (configFile >> "CfgVehicles" >> _vehType >> "Turrets");

if (_count > 0) then {
	for "_i" from 0 to (_count - 1) do {
		scopeName "xx_reload2_xx";
		_config = (configFile >> "CfgVehicles" >> _vehType >> "Turrets") select _i;
		_magazines = getArray(_config >> "magazines");
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_veh removeMagazines _x;
				_removed = _removed + [_x];
			};
		} forEach _magazines;
		{
			_veh vehicleChat format ["Reloading %1", _x];
			sleep 0.05;
			_veh addMagazine _x;
			sleep 0.05;
		} forEach _magazines;
		_count_other = count (_config >> "Turrets");
		if (_count_other > 0) then {
			for "_i" from 0 to (_count_other - 1) do {
				_config2 = (_config >> "Turrets") select _i;
				_magazines = getArray(_config2 >> "magazines");
				_removed = [];
				{
					if (!(_x in _removed)) then {
						_veh removeMagazines _x;
						_removed = _removed + [_x];
					};
				} forEach _magazines;
				{
					_veh vehicleChat format ["Reloading %1", _x]; 
					sleep 0.05;
					_veh addMagazine _x;
					sleep 0.05;
				} forEach _magazines;
			};
		};
	};
};
_veh setVehicleAmmo 1;	// Reload turrets / drivers magazine

_veh vehicleChat format ["%1 successfully repaired and refuelled.", _vehType];

_fuelVeh = ["B_APC_Tracked_01_CRV_F","B_Truck_01_fuel_F"];
_repairVeh = ["B_APC_Tracked_01_CRV_F","B_Truck_01_Repair_F","C_Offroad_01_repair_F"];
_ammoVeh = ["B_APC_Tracked_01_CRV_F","B_Truck_01_ammo_F"];
if (({_veh isKindOf _x} count _repairVeh) > 0) then {
    _veh setRepairCargo 1;
};
if (({_veh isKindOf _x} count _ammoVeh) > 0) then {
	if (PARAMS_VehicleAmmoCargo == 1) then {
		_veh setAmmoCargo 1;
	};
};
if (({_veh isKindOf _x} count _fuelVeh) > 0) then {
    _veh setFuelCargo 1;
};