/*
      ::: ::: :::             ::: :::             :::
     :+: :+:   :+:           :+:   :+:           :+:
    +:+ +:+     +:+         +:+     +:+         +:+
   +#+ +#+       +#+       +#+       +#+       +#+
  +#+ +#+         +#+     +#+         +#+     +#+
 #+# #+#           #+#   #+#           #+#   #+#
### ###             ### ###             ### ###

 Helicopter ammo box drop script (aw_drop.sqf) was written by Jester [AW] of AhoyWorld.co.uk
 You may add or alter this code to your liking as long as you leave the authors name in place.
 set _reloadtime = 30 to however many seconds you want before it is available to use again.
 place "this addAction ["<t color='#0000f6'>Сбросить боеприпасы</t>", "aw_drop.sqf",[1],0,false,true,""," driver  _target == _this"];", "aw_drop.sqf"];" in the helicopter/plane init field.
 change the loadouts to the crate to your likings.
*/

private ["_heli", "_reloadtime"];

//Lets set some local variables
_heli = _this select 0;
_chuteType = "B_Parachute_02_F";  //Replace the 'B' (BLUFOR) with O/G for OPFOR/GUER
_crateType =  "B_supplyCrate_F";  //Crate for BLUFOR, feel free to change to desired type
_smokeType =  "SmokeShellPurple"; //Smoke shell color you want to use
_lightType =  "Chemlight_blue";   //Chemlightcolor you want used
_reloadtime = 600;                //Time before next ammo drop is available to use
_minheight = 50;                  //The height you have to be to drop the crate
_HQ = [West,"HQ"];                //Do not touch this!
_toLow = format
  [
    "<t align='center'><t size='2.2' color='#ed3b00'>НАБЕРИ ВЫСОТУ</t><br/>Боезапас можно сбросить только на высоте не менее<br/><t size='1.5' color='#ed3b00'>%1 метров</t></t>",
    _minheight
  ];  //Text to display when not at the drop height

if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};

//Wait until player is initialized
if (!isDedicated) then
{
  waitUntil {!isNull player && isPlayer player};
};

//Meat and potatoes
if ( !(isNil "AW_ammoDrop") ) exitWith {hint "Нет возможности для сброса."};
if ((getPos player) select 2 < _minheight) exitWith {hint parseText _toLow};
if ((getPos player) select 2 > _minheight) then
{
  AW_ammoDrop = false;
  publicVariable "AW_ammoDrop";

  _chute = createVehicle [_chuteType, [100, 100, 200], [], 0, 'FLY'];
  _chute setPos [getPosASL _heli select 0, getPosASL _heli select 1, (getPosASL _heli select 2) - 50];
  _crate = createVehicle [_crateType, position _chute, [], 0, 'NONE'];
  _crate attachTo [_chute, [0, 0, -1.3]];
  _crate allowdamage false;
  _light = createVehicle [_lightType, position _chute, [], 0, 'NONE'];
  _light attachTo [_chute, [0, 0, 0]];

  //Clear crate - leaves medkits in place. add clearItemCargoGlobal _crate; to remove medkits
  clearWeaponCargoGlobal _crate;
  clearMagazineCargoGlobal _crate;

  //Fill crate with our junk
  _crate addMagazineCargoGlobal ["5Rnd_127x108_Mag", 10];
  _crate addMagazineCargoGlobal ["7Rnd_408_Mag", 15];
  _crate addMagazineCargoGlobal ["30Rnd_556x45_Stanag", 40];
  _crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 40];
  _crate addMagazineCargoGlobal ["20Rnd_762x51_Mag", 30];
  _crate addMagazineCargoGlobal ["200Rnd_65x39_cased_Box_Tracer", 10];
  _crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_green", 40];
  _crate addMagazineCargoGlobal ["150Rnd_762x51_Box", 10];
  _crate addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag", 40];
  _crate addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 2];
  _crate addMagazineCargoGlobal ["HandGrenade", 6];
  _crate addMagazineCargoGlobal ["SmokeShell", 6];
  _crate addMagazineCargoGlobal ["SmokeShellGreen", 6];
  _crate addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 6];
  _crate addMagazineCargoGlobal ["RPG32_HE_F", 2];
  _crate addMagazineCargoGlobal ["RPG32_F", 2];
  _crate addMagazineCargoGlobal ["NLAW_F", 3];
  _crate addMagazineCargoGlobal ["Titan_AT", 2];
  _crate addMagazineCargoGlobal ["Titan_AA", 2];

  //Lets people know stuff happened
  _HQ sideChat "Боезапас сброшен.";
  hint format ["Боезапас сброшен, следующий будет готов к сбросу через %1 с",_reloadtime];
  waitUntil {position _crate select 2 < 1 || isNull _chute};
  detach _crate;
  _crate setPos [position _crate select 0, position _crate select 1, 0];
  _smoke = _smokeType createVehicle [getPos _crate select 0, getPos _crate select 1,5];

  //Let ground forces know they can resupply
  _HQ sideChat "Боезапас коснулся земли!";
  sleep 3;
  _HQ sideChat "Повторяю, боезапас коснулся земли!";

  //Time to reload a new ammo crate
  sleep _reloadtime;

  //We are back in action
  vehicle player vehicleChat "Возможность сброса боезапасов вновь доступна.";
  AW_ammoDrop = nil;
  publicVariable "AW_ammoDrop";
};
