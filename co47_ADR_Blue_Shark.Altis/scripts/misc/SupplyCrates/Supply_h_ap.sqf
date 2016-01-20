private ["_crateType", "_smokeType", "_lightType", "_Supply_Ammo", "_chute"];

if (!(BACO_ammoSuppAvail2)) exitWith {
	hint "Модуль в данный момент не доступен!"
};

BACO_ammoSuppAvail2 = FALSE; publicVariable "BACO_ammoSuppAvail2";

_crateType =  "B_supplyCrate_F";
_smokeType =  "SmokeShellPurple";
_lightType =  "Chemlight_blue";
_timedel = 300;

_Supply_Ammo = _crateType createVehicle (getMarkerPos "Ammo_Supply_drop"); publicVariable "_Supply_Ammo"; 
_Supply_Ammo allowDamage false;

clearWeaponCargoGlobal _Supply_Ammo;
clearMagazineCargoGlobal _Supply_Ammo;
clearItemCargoGlobal _Supply_Ammo;

_Supply_Ammo addItemCargoGlobal ["FirstAidKit", 20]; 
_Supply_Ammo addItemCargoGlobal ["Medikit", 1]; 
_Supply_Ammo addItemCargoGlobal ["ToolKit", 1]; 
_Supply_Ammo addMagazineCargoGlobal ["Laserbatteries", 5];
_Supply_Ammo addMagazineCargoGlobal ["5Rnd_127x108_Mag", 15]; 
_Supply_Ammo addMagazineCargoGlobal ["7Rnd_408_Mag", 15]; 
_Supply_Ammo addMagazineCargoGlobal ["10Rnd_93x64_DMR_05_Mag", 20]; 
_Supply_Ammo addMagazineCargoGlobal ["10Rnd_127x54_Mag", 20]; 
_Supply_Ammo addMagazineCargoGlobal ["10Rnd_338_Mag", 20]; 
_Supply_Ammo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 20]; 
_Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 20]; 
_Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 10]; 
_Supply_Ammo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 20]; 
_Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 20]; 
_Supply_Ammo addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag", 10]; 
_Supply_Ammo addMagazineCargoGlobal ["150Rnd_762x51_Box", 10]; 
_Supply_Ammo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10]; 
_Supply_Ammo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2]; 
_Supply_Ammo addMagazineCargoGlobal ["HandGrenade", 6]; 
_Supply_Ammo addMagazineCargoGlobal ["SmokeShell", 6]; 
_Supply_Ammo addMagazineCargoGlobal ["SmokeShellGreen", 6]; 
_Supply_Ammo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 16]; 
_Supply_Ammo addMagazineCargoGlobal ["RPG32_HE_F", 5]; 
_Supply_Ammo addMagazineCargoGlobal ["RPG32_F", 7]; 
_Supply_Ammo addMagazineCargoGlobal ["NLAW_F", 5]; 
_Supply_Ammo addMagazineCargoGlobal ["Titan_AT", 3]; 
_Supply_Ammo addMagazineCargoGlobal ["Titan_AA", 3];

sleep 1;
waitUntil{!isNull (ropeAttachedTo _Supply_Ammo)};
sleep 1;
waitUntil{isNull (ropeAttachedTo _Supply_Ammo)};
sleep 3;
waitUntil{(getPos _Supply_Ammo select 2)<=200};

_light1 = createVehicle [_lightType, position _Supply_Ammo, [], 0, 'NONE'];
_light2 = createVehicle [_lightType, position _Supply_Ammo, [], 0, 'NONE'];
_light3 = createVehicle [_lightType, position _Supply_Ammo, [], 0, 'NONE'];
_light1 attachTo [_Supply_Ammo, [-0.7, 0, 0.15]];
_light2 attachTo [_Supply_Ammo, [0, 0.5, 0.15]];
_light3 attachTo [_Supply_Ammo, [0.7, 0, 0.15]];
_Signa2 = createVehicle [_smokeType, position _Supply_Ammo, [], 0, 'NONE'];
_Signa2 attachTo [_Supply_Ammo, [0, 0, -1]];


_chute = createVehicle ["B_Parachute_02_F", [position _Supply_Ammo select 0, position _Supply_Ammo select 1, position _Supply_Ammo select 2], [], 0, "CAN COLLIDE"];
_Supply_Ammo attachTo [_chute, [0, 0, -1]];
waitUntil {getPos _Supply_Ammo select 2 < 4 || isNull _chute};
detach _Supply_Ammo;
sleep 10;
_Signal = _smokeType createVehicle [getPos _Supply_Ammo select 0, getPos _Supply_Ammo select 1,5];
sleep _timedel;
BACO_ammoSuppAvail2 = TRUE; publicVariable "BACO_ammoSuppAvail2";
sleep 600;
deleteVehicle _Supply_Ammo;