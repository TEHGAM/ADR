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

												// lets set some local variables
	_heli = _this select 0;
    _chuteType = "B_Parachute_02_F";			//parachute for blufor, for opfor and greenfor replace the 'B' with 'O' or 'G' respectively
    _crateType =  "B_supplyCrate_F";			//ammocrate class for blufor, feel free to change to whichever box you desire
    _smokeType =  "SmokeShellPurple";  			//smoke shell color you want to use
    _lightType =  "Chemlight_blue";  			//chemlightcolor you want used
    _reloadtime = 600;  						// time before next ammo drop is available to use
    _minheight = 50;  							// the height you have to be before you can actually drop the crate
    _HQ = [West,"HQ"];  						// do not touch this!
    _toLow = format
    	[
    	"<t align='center'><t size='2.2' color='#ed3b00'>НАБЕРИ ВЫСОТУ</t><br/><t size='1.2' color='#9ef680'>Вы должны быть выше</t><br/><t size='1.5' color='#ed3b00'>%1 метров</t><br/><t size='1.2' color='#9ef680'>для сброса боезапасов.</t></t>",
    		_minheight
    	];  //text to display when not high enough to drop

	if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};

	// Wait until player is initialized
	if (!isDedicated) then
	{
		waitUntil {!isNull player && isPlayer player};
	};
	// meat and potatoes
	if ( !(isNil "AW_ammoDrop") ) exitWith {hint "Возможность сброса боеприпасов пока отсутствует."};
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

		// clear crate - leaves medkits in place. add clearItemCargoGlobal _crate; to remove medkits
		clearWeaponCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;

		// fill crate with our junk
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

		// lets people know stuff happened
		_HQ sideChat "Оперативный боезапас сброшен.";
		hint format ["Оперативный боезапас сброшен, следующий будет готов к сбросу через %1 с",_reloadtime];
		waitUntil {position _crate select 2 < 1 || isNull _chute};
		detach _crate;
		_crate setPos [position _crate select 0, position _crate select 1, 0];
		_smoke = _smokeType createVehicle [getPos _crate select 0, getPos _crate select 1,5];

		// let ground forces know they can resupply
		_HQ sideChat "Оперативный боезапас коснулся земли!";
		sleep 3;
		_HQ sideChat "Повторяю, оперативный боезапас коснулся земли!";

		// time to reload a new ammo crate
		sleep _reloadtime;

		// we are back in action
		vehicle player vehicleChat "Возможность сброса боезапасов вновь доступна.";
		AW_ammoDrop = nil;
		publicVariable "AW_ammoDrop";
	};
