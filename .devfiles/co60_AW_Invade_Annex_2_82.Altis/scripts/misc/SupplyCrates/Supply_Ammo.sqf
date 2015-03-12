private ["_heli", "_reloadtime"];

if (!(BACO_ammoSuppAvail)) exitWith {
	hint "Supply Crate is not currently available"
};

BACO_ammoSuppAvail = FALSE; publicVariable "BACO_ammoSuppAvail";

//------------------------------------------------------- CONFIG

_heli = _this select 0;
_crateType =  "B_CargoNet_01_ammo_F";		//ammocrate class for blufor, feel free to change to whichever box you desire
_reloadtime = 960;  						// time before next ammo drop is available to use, default 600 or 480

//--------------------------------------------------------- MEAT AND POTATOES

Supply_Ammo = _crateType createVehicle (getMarkerPos "Ammo_Supply_drop");; publicVariable "Supply_Ammo"; 

//---------------------------------------------------- CLEAR CRATE

clearWeaponCargoGlobal Supply_Ammo;
clearMagazineCargoGlobal Supply_Ammo;

//---------------------------------------------------- CRATE CONTENTS

Supply_Ammo addMagazineCargoGlobal ["5Rnd_127x108_Mag", 10];
Supply_Ammo addMagazineCargoGlobal ["7Rnd_408_Mag", 15];
Supply_Ammo addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 40];
Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 40];
Supply_Ammo addMagazineCargoGlobal ["20Rnd_762x51_Mag", 30];
Supply_Ammo addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10];
Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 40];
Supply_Ammo addMagazineCargoGlobal ["150Rnd_762x51_Box", 10];
Supply_Ammo addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 40];
Supply_Ammo addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2];
Supply_Ammo addMagazineCargoGlobal ["HandGrenade", 6];
Supply_Ammo addMagazineCargoGlobal ["SmokeShell", 6];
Supply_Ammo addMagazineCargoGlobal ["SmokeShellGreen", 6];
Supply_Ammo addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 6];
Supply_Ammo addMagazineCargoGlobal ["RPG32_HE_F", 2];
Supply_Ammo addMagazineCargoGlobal ["RPG32_F", 2];
Supply_Ammo addMagazineCargoGlobal ["NLAW_F", 3];
Supply_Ammo addMagazineCargoGlobal ["Titan_AT", 2];
Supply_Ammo addMagazineCargoGlobal ["Titan_AA", 2];

sleep _reloadtime; BACO_ammoSuppAvail = TRUE; publicVariable "BACO_ammoSuppAvail";