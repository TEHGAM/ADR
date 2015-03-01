/*
Author:

	Jester [AW]
	
Edited by:
 
	Quiksilver 
 
Note:
 
	Should be fixedd now.
 
______________________________________________________________*/

private ["_heli", "_reloadtime"];

if (!(AW_ammoDropAvail)) exitWith {
	hint "Ammo drop is not currently available"
};
AW_ammoDropAvail = FALSE; publicVariable "AW_ammoDropAvail";

//------------------------------------------------------- CONFIG

_heli = _this select 0;
_chuteType = "B_Parachute_02_F";			//parachute for blufor, for opfor and greenfor replace the 'B' with 'O' or 'G' respectively
_crateType =  "B_supplyCrate_F";			//ammocrate class for blufor, feel free to change to whichever box you desire
_smokeType =  "SmokeShellPurple";  			//smoke shell color you want to use
_lightType =  "Chemlight_blue";  			//chemlightcolor you want used
_reloadtime = 600;  							// time before next ammo drop is available to use, default 600 or 480
_minheight = 39;  							// the height you have to be before you can actually drop the crate

//--------------------------------------------------------- MEAT AND POTATOES

_chute = createVehicle [_chuteType, [100, 100, 200], [], 0, 'FLY'];
_chute setPos [getPosASL _heli select 0, getPosASL _heli select 1, (getPosASL _heli select 2) - 50];
ammoDropCrate = createVehicle [_crateType, position _chute, [], 0, 'NONE']; publicVariable "ammoDropCrate"; 
ammoDropCrate attachTo [_chute, [0, 0, -1.3]];
ammoDropCrate allowdamage false;
_light = createVehicle [_lightType, position _chute, [], 0, 'NONE'];
_light attachTo [_chute, [0, 0, 0]];

//---------------------------------------------------- CLEAR CRATE

clearWeaponCargoGlobal ammoDropCrate;
clearMagazineCargoGlobal ammoDropCrate;

//---------------------------------------------------- CRATE CONTENTS

ammoDropCrate addMagazineCargoGlobal ["5Rnd_127x108_Mag", 10];
ammoDropCrate addMagazineCargoGlobal ["7Rnd_408_Mag", 15];
ammoDropCrate addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 40];
ammoDropCrate addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 40];
ammoDropCrate addMagazineCargoGlobal ["20Rnd_762x51_Mag", 30];
ammoDropCrate addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10];
ammoDropCrate addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 40];
ammoDropCrate addMagazineCargoGlobal ["150Rnd_762x51_Box", 10];
ammoDropCrate addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 40];
ammoDropCrate addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2];
ammoDropCrate addMagazineCargoGlobal ["HandGrenade", 6];
ammoDropCrate addMagazineCargoGlobal ["SmokeShell", 6];
ammoDropCrate addMagazineCargoGlobal ["SmokeShellGreen", 6];
ammoDropCrate addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 6];
ammoDropCrate addMagazineCargoGlobal ["RPG32_HE_F", 2];
ammoDropCrate addMagazineCargoGlobal ["RPG32_F", 2];
ammoDropCrate addMagazineCargoGlobal ["NLAW_F", 3];
ammoDropCrate addMagazineCargoGlobal ["Titan_AT", 2];
ammoDropCrate addMagazineCargoGlobal ["Titan_AA", 2];

//--------------------------------------------------- BRIEF

pvBroadcast = [WEST,"AirBase"] sideChat "UH-80 Supply Drop has been deployed!"; publicVariable "pvBroadcast";

//--------------------------------------------------- CRATE LANDING

waitUntil {
	position ammoDropCrate select 2 < 2 || isNull _chute
};

detach ammoDropCrate;
ammoDropCrate setPos [position ammoDropCrate select 0, position ammoDropCrate select 1, 0];
ammoDropCrate setVectorUp [0,0,1];
ammoDropCrate enableSimulationGlobal TRUE;
_smoke = _smokeType createVehicle [getPos ammoDropCrate select 0, getPos ammoDropCrate select 1,5];
