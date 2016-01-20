private ["_heli", "_reloadtime"];

if (!(BACO_ammoSuppAvail)) exitWith {
	hint "Модуль в данный момент не доступен!"
};

BACO_ammoSuppAvail = FALSE; publicVariable "BACO_ammoSuppAvail";

_crateType =  "B_supplyCrate_F";
_reloadtime = 30;
_smokeType =  "SmokeShellPurple";
_lightType =  "Chemlight_blue";

Supply_Ammo = _crateType createVehicle (getMarkerPos "Ammo_Supply_drop");; publicVariable "Supply_Ammo"; 
Supply_Ammo allowDamage false;

clearWeaponCargoGlobal Supply_Ammo;
clearMagazineCargoGlobal Supply_Ammo;
clearItemCargoGlobal Supply_Ammo;

Supply_Ammo addItemCargoGlobal ["FirstAidKit", 20]; 
Supply_Ammo addItemCargoGlobal ["Medikit", 1]; 
Supply_Ammo addItemCargoGlobal ["ToolKit", 1]; 
Supply_Ammo addMagazineCargoGlobal ["Laserbatteries", 5];
Supply_Ammo addMagazineCargoGlobal ["5Rnd_127x108_Mag", 15]; 
Supply_Ammo addMagazineCargoGlobal ["7Rnd_408_Mag", 15]; 
Supply_Ammo addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["10Rnd_127x54_Mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["10Rnd_338_Mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 10]; 
Supply_Ammo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 20]; 
Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 20]; 
Supply_Ammo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag", 10]; 
Supply_Ammo addMagazineCargoGlobal ["150Rnd_762x51_Box", 10]; 
Supply_Ammo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10]; 
Supply_Ammo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2]; 
Supply_Ammo addMagazineCargoGlobal ["HandGrenade", 6]; 
Supply_Ammo addMagazineCargoGlobal ["SmokeShell", 6]; 
Supply_Ammo addMagazineCargoGlobal ["SmokeShellGreen", 6]; 
Supply_Ammo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 16]; 
Supply_Ammo addMagazineCargoGlobal ["RPG32_HE_F", 5]; 
Supply_Ammo addMagazineCargoGlobal ["RPG32_F", 7]; 
Supply_Ammo addMagazineCargoGlobal ["NLAW_F", 5]; 
Supply_Ammo addMagazineCargoGlobal ["Titan_AT", 3]; 
Supply_Ammo addMagazineCargoGlobal ["Titan_AA", 3];

waitUntil{(getPos Supply_Ammo select 2)>=300};
hint "Парашют активирован, не опускайтесь ниже 150";
sleep 1;
waitUntil{(getPos Supply_Ammo select 2)<=80};
_light1 = createVehicle [_lightType, position Supply_Ammo, [], 0, 'NONE'];
_light2 = createVehicle [_lightType, position Supply_Ammo, [], 0, 'NONE'];
_light3 = createVehicle [_lightType, position Supply_Ammo, [], 0, 'NONE'];
_light1 attachTo [Supply_Ammo, [0, 0.3, 0]];
_light2 attachTo [Supply_Ammo, [0, 0.3, 0]];
_light3 attachTo [Supply_Ammo, [5, 0, 0]];

[Supply_Ammo, 0, 0] call BIS_fnc_setPitchBank;
_chute = createVehicle ["I_Parachute_02_F", [position Supply_Ammo select 0, position Supply_Ammo select 1, position Supply_Ammo select 2], [], 0, "FLY"];
_chute attachTo [Supply_Ammo, [0, 0, 0]];
waitUntil {getPos Supply_Ammo select 2 < 4 || isNull _chute};
detach _chute;
sleep 3;
_Signal = _smokeType createVehicle [getPos Supply_Ammo select 0, getPos Supply_Ammo select 1,5];