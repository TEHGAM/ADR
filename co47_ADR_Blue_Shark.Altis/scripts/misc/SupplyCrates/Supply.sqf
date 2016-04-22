private ["_cargoType", "_smokeType", "_lightType", "_cargo_pos", "_cargo", "_velocity", "_light1", "_light2", "_light3", "_Signal2", "_chute", "_Signal", "_modules", "_objects"];

//---- Checking created modules and remove them
_modules = ["B_Slingload_01_Fuel_F", "B_Slingload_01_Medevac_F", "B_Slingload_01_Repair_F", "B_Slingload_01_Ammo_F", "Land_Pod_Heli_Transport_04_fuel_F", "Land_Pod_Heli_Transport_04_medevac_F", "Land_Pod_Heli_Transport_04_repair_F", "Land_Pod_Heli_Transport_04_ammo_F", "Land_Pod_Heli_Transport_04_bench_F", "Land_Pod_Heli_Transport_04_covered_F", "B_Slingload_01_Cargo_F", "B_supplyCrate_F"];
_objects = nearestObjects [(getMarkerPos "Ammo_Supply_drop"), _modules, 30];
{
    deleteVehicle _x;
} forEach _objects;
sleep 0.5;

//----- Variables
_cargoType =  _this select 3;
_smokeType =  "SmokeShellPurple";
_lightType =  "Chemlight_blue";
_cargo_pos = [0,0,0];

if (_cargoType == 11) then {

	//----- Creating cargo
	_cargo = "B_supplyCrate_F" createVehicle (getMarkerPos "Ammo_Supply_drop");
	_cargo allowDamage false;

	//----- Clearing cargo
	clearWeaponCargoGlobal _cargo;
	clearMagazineCargoGlobal _cargo;
	clearItemCargoGlobal _cargo;
	clearBackpackCargoGlobal _cargo;
	sleep 0.1;

	//----- Loading cargo
	_cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 7];
	_cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Green", 7];
	_cargo addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 7];
	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 7]; 
	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 7]; 
	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer", 7]; 
	_cargo addMagazineCargoGlobal ["5Rnd_127x108_Mag", 10]; 
	_cargo addMagazineCargoGlobal ["7Rnd_408_Mag", 10]; 
	_cargo addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 7]; 
	_cargo addMagazineCargoGlobal ["10Rnd_127x54_Mag", 7]; 
	_cargo addMagazineCargoGlobal ["10Rnd_338_Mag", 7]; 
	_cargo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 7]; 
	_cargo addMagazineCargoGlobal ["10Rnd_762x54_Mag", 7]; 
	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 14]; 
	_cargo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer", 5]; 
	_cargo addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer", 5]; 
	_cargo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 5]; 
	_cargo addMagazineCargoGlobal ["150Rnd_93x64_Mag", 5]; 
	_cargo addMagazineCargoGlobal ["130Rnd_338_Mag", 5]; 
	_cargo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2]; 
	_cargo addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 2];
	_cargo addMagazineCargoGlobal ["HandGrenade", 12]; 
	_cargo addMagazineCargoGlobal ["MiniGrenade", 12]; 
	_cargo addMagazineCargoGlobal ["SmokeShell", 12]; 
	_cargo addMagazineCargoGlobal ["SmokeShellGreen", 12]; 
	_cargo addMagazineCargoGlobal ["SmokeShellBlue", 12]; 
	_cargo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 12]; 
	_cargo addMagazineCargoGlobal ["3Rnd_HE_Grenade_shell", 4];
	_cargo addMagazineCargoGlobal ["RPG32_HE_F", 5]; 
	_cargo addMagazineCargoGlobal ["RPG32_F", 5]; 
	_cargo addMagazineCargoGlobal ["NLAW_F", 3]; 
	_cargo addMagazineCargoGlobal ["Titan_AT", 3]; 
	_cargo addMagazineCargoGlobal ["Titan_AA", 3];
	_cargo addMagazineCargoGlobal ["Laserbatteries", 5];
	_cargo addItemCargoGlobal ["FirstAidKit", 20]; 
	_cargo addItemCargoGlobal ["Medikit", 1]; 
	_cargo addItemCargoGlobal ["ToolKit", 1]; 
	_cargo addBackpackCargoGlobal ["B_AssaultPack_rgr", 2];
	_cargo addBackpackCargoGlobal ["B_Kitbag_mcamo", 2];
};

if (_cargoType == 12) then {

	//----- Creating cargo
	_cargo = "B_Slingload_01_Cargo_F" createVehicle (getMarkerPos "Ammo_Supply_drop");

	//----- Clearing cargo
	clearWeaponCargoGlobal _cargo;
	clearMagazineCargoGlobal _cargo;
	clearItemCargoGlobal _cargo;
	clearBackpackCargoGlobal _cargo;
	sleep 0.1;

	//----- Loading cargo
	_cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 14];
	_cargo addMagazineCargoGlobal ["30Rnd_556x45_Stanag_Tracer_Green", 14];
	_cargo addMagazineCargoGlobal ["20Rnd_556x45_UW_mag", 14];
	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 14]; 
	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 14]; 
	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green_mag_Tracer", 14]; 
	_cargo addMagazineCargoGlobal ["5Rnd_127x108_Mag", 20]; 
	_cargo addMagazineCargoGlobal ["7Rnd_408_Mag", 20]; 
	_cargo addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 14]; 
	_cargo addMagazineCargoGlobal ["10Rnd_127x54_Mag", 14]; 
	_cargo addMagazineCargoGlobal ["10Rnd_338_Mag", 14]; 
	_cargo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 14]; 
	_cargo addMagazineCargoGlobal ["10Rnd_762x54_Mag", 14]; 
	_cargo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 21]; 
	_cargo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer", 15]; 
	_cargo addMagazineCargoGlobal ["150Rnd_762x54_Box_Tracer", 15]; 
	_cargo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 15]; 
	_cargo addMagazineCargoGlobal ["150Rnd_93x64_Mag", 15]; 
	_cargo addMagazineCargoGlobal ["130Rnd_338_Mag", 15]; 
	_cargo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 5]; 
	_cargo addMagazineCargoGlobal ["DemoCharge_Remote_Mag", 5];
	_cargo addMagazineCargoGlobal ["HandGrenade", 24]; 
	_cargo addMagazineCargoGlobal ["MiniGrenade", 24]; 
	_cargo addMagazineCargoGlobal ["SmokeShell", 24]; 
	_cargo addMagazineCargoGlobal ["SmokeShellGreen", 24]; 
	_cargo addMagazineCargoGlobal ["SmokeShellBlue", 24]; 
	_cargo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 24]; 
	_cargo addMagazineCargoGlobal ["3Rnd_HE_Grenade_shell", 8];
	_cargo addMagazineCargoGlobal ["RPG32_HE_F", 10]; 
	_cargo addMagazineCargoGlobal ["RPG32_F", 10]; 
	_cargo addMagazineCargoGlobal ["NLAW_F", 10]; 
	_cargo addMagazineCargoGlobal ["Titan_AT", 7]; 
	_cargo addMagazineCargoGlobal ["Titan_AA", 7];
	_cargo addMagazineCargoGlobal ["Laserbatteries", 10];
	_cargo addItemCargoGlobal ["FirstAidKit", 20]; 
	_cargo addItemCargoGlobal ["Medikit", 2]; 
	_cargo addItemCargoGlobal ["ToolKit", 2]; 
	_cargo addItemCargoGlobal ["NVGoggles", 5];
	_cargo addItemCargoGlobal ["Laserdesignator", 2];
	_cargo addItemCargoGlobal ["optic_Hamr", 5];
	_cargo addBackpackCargoGlobal ["B_AssaultPack_rgr", 2];
	_cargo addBackpackCargoGlobal ["B_Kitbag_mcamo", 2];
	_cargo addBackpackCargoGlobal ["B_UAV_01_backpack_F", 2];
	};
sleep 0.5;
waitUntil{sleep 3; !isNull (ropeAttachedTo _cargo)};
sleep 0.5;
waitUntil{sleep 0.5; isNull (ropeAttachedTo _cargo)};
if (getPos _cargo select 2 < 50) then {hint "Модуль сброшен без парашюта    (малая высота)"} else 
	{
		sleep 2;
		waitUntil{sleep 0.5; (getPos _cargo select 2)<=200};
		_velocity = velocity _cargo;
		_light1 = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
		_light2 = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
		_light3 = createVehicle [_lightType, position _cargo, [], 0, 'NONE'];
		_light1 attachTo [_cargo, [-0.7, 0, 0.15]];
		_light2 attachTo [_cargo, [0, 0.5, 0.15]];
		_light3 attachTo [_cargo, [0.7, 0, 0.15]];
		_Signal2 = createVehicle [_smokeType, position _cargo, [], 0, 'NONE'];
		_Signal2 attachTo [_cargo, _cargo_pos];

		_chute = createVehicle ["B_Parachute_02_F", position _cargo, [], 0, "CAN_COLLIDE"];
		_cargo attachTo [_chute, _cargo_pos];
		_chute setVelocity _velocity;
		sleep 0.1;
		waitUntil {sleep 0.5; (getPos _cargo select 2) < 20};
		detach _cargo;
		sleep 10;
		_Signal = _smokeType createVehicle [getPos _cargo select 0, getPos _cargo select 1,5];
	};