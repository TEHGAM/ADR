/*
author: stanhope
description: adds a supply crate to the nearest helicoter + addaction to drop it.

Quartermaster_5 addAction ["Add supplyCrate to heli", {execVM "scripts\vehicle\supplyCrate.sqf"}, [], 0, false, true, "",  
"(_this isKindOf 'B_Helipilot_F') || (_this getVariable 'isZeus')", 5];
*/

spawnCrateCode = {
	_spawnPos = _this select 0;
	_heli = _this select 1;
	_heli setVariable ["HasSupplyCrate", nil, true];
	
	_chute = createVehicle ["B_Parachute_02_F", [_spawnPos select 0, _spawnPos select 1, ((_spawnPos select 2) - 5 )], [], 0, 'FLY'];
	_crate = createVehicle ["B_supplyCrate_F", position _chute, [], 0, 'NONE'];
	_crate attachTo [_chute, [0, 0, 0]];
	_crate allowdamage false;
	_smoke = createVehicle ["SmokeShellOrange", position _crate, [], 0, 'NONE'];
	_smoke attachTo [_crate, [0, 0, 0.5]];

	_light = "#lightpoint" createVehicle position player; 
	_light setLightBrightness 0.01; 
	_light setLightAmbient [255.0,165.0,0.0]; 
	_light setLightColor [255.0,165.0,0.0];
	_light lightAttachObject [_crate, [0,0,0.5]];
	[_light] spawn {sleep 120; deleteVehicle (_this select 0);};

	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;

	_crate addMagazineCargoGlobal ["7Rnd_408_Mag", 6];
	_crate addMagazineCargoGlobal ["5Rnd_127x108_Mag", 6];

	_crate addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 40];
	_crate addMagazineCargoGlobal ["30Rnd_556x45_Stanag_red", 20];
	_crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 40];
	_crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 20];

	_crate addMagazineCargoGlobal ["20Rnd_762x51_Mag", 30];
	_crate addMagazineCargoGlobal ["150Rnd_762x51_Box", 10];
	_crate addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10];

	_crate addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 2];
	_crate addMagazineCargoGlobal ["HandGrenade", 6];
	_crate addMagazineCargoGlobal ["SmokeShell", 6];
	_crate addMagazineCargoGlobal ["SmokeShellGreen", 6];
	_crate addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 6];

	_crate addMagazineCargoGlobal ["RPG32_HE_F", 2];
	_crate addMagazineCargoGlobal ["RPG32_F", 4];
	_crate addMagazineCargoGlobal ["RPG7_F", 2];
	_crate addMagazineCargoGlobal ["NLAW_F", 2];
	_crate addMagazineCargoGlobal ["Titan_AT", 4];
	_crate addMagazineCargoGlobal ["Titan_AA", 2];

	_crate addMagazineCargoGlobal ["Laserbatteries", 4];

	waitUntil {( ((getposATL _crate) select 2) < 2 ) || !(alive _chute)};
	detach _crate;
	_crate setPosATL [(getposATL _crate) select 0, (getposATL _crate) select 1, 1]; 
	if (alive _smoke) then {deleteVehicle _smoke;};
	_smoke = createVehicle ["SmokeShellOrange", position _crate, [], 0, 'NONE'];
	_smoke attachTo [_crate, [0, 0, 0]];
	_crate allowDamage true;   
};
publicVariable "spawnCrateCode";

_helis = nearestObjects [liftZonePad, ["Air"], 20, true];
if (count _helis < 1) exitWith {hint "No heli/plane found.  Make sure your heli/plane is close enough.";};
{
	if ((_x isKindOf 'B_Heli_Light_01_armed_F') || (_x isKindOf 'B_Heli_Light_01_dynamicLoadout_F') || (_x isKindOf 'B_Heli_Light_01_F')) then {
		_helis = _helis - [_x];
	}
} forEach _helis;
if (count _helis < 1) exitWith {hint "No heli/plane found.  (Pawnees and hummingbirds are too small)";};

_heli = _helis select 0;
if (_heli getVariable ["HasSupplyCrate", false]) exitWith {hint "Your heli/plane already has a supplycrate, cannot add another one.";};

_heli setVariable ["HasSupplyCrate", true, true];
[_heli,"Paradrop crate",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\use_ca.paa",
"((getPosATL (vehicle _this)) select 2 > 60) && (_this == driver (vehicle _this)) && (vehicle _this != _this)",
"((getPosATL (vehicle _this)) select 2 > 60) && (_this == driver (vehicle _this)) && (vehicle _this != _this)",
{ hint "Preparing to drop crate";},{},{
	_heli = _this select 0;
	_pos = getPos _heli;
	[_pos, _heli] spawn spawnCrateCode; 
	hint "Crate dropped";
},{hint "You stopped preparing to drop the crate";},[], 4, 0,true,false] remoteExecCall ["BIS_fnc_holdActionAdd", 0, true];

hint "Supply crate added to your helicopter.  You need to be above 60m to deploy it.";
