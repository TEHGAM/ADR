/*--------------------------------------------------------------------*/
/*
/* Spread script for ah-9 and other vehicles by Kenny Christiansen.
/*
/* Created 04.10.2014
/*
/*
/*
/*---------------------------------------------------------------------*/
_unit = _this select 0; //Selects unit fireing,in this case the AH-9
_ammoType = _this select 5; //Gets ammo type being fires,this is to prevent the script from being applied on all weapons
_bullet = _this select 6;  //Gets the projectile thats leaving the weapon


if(_ammoType == "1000Rnd_20mm_shells") then {
	
	//_newPos = _unit modelToWorld [0,0,0]; //Where to spawn the new projectile,this is to prevent spawning inside vic model
	_newPos = getPos _bullet;
    _veh = createVehicle ["B_20mm_Tracer_Red",_newPos,[],4,"CAN_COLLIDE"]; //Creates new bullet,see cfgMagazine for diffrent ammo types.
    _veh setDir getDir _bullet; //Sets dir of new bullet in the same direction of the bullet-
    _veh setVelocity velocity _bullet; //Sets velocity of new projectile to match the old bullet.
    deleteVehicle _bullet;//Deletes original bullet
	
	};
	
if(_ammoType == "2000Rnd_65x39_Belt_Tracer_Red") then {
	
	//_newPos = _unit modelToWorld [0,0,0]; //Where to spawn the new projectile,this is to prevent spawning inside vic model
	_newPos = getPos _bullet;
    _veh = createVehicle ["B_65x39_Minigun_Caseless",_newPos,[],1,"CAN_COLLIDE"]; //Creates new bullet,see cfgMagazine for diffrent ammo types.
    _veh setDir getDir _bullet; //Sets dir of new bullet in the same direction of the bullet-
    _veh setVelocity velocity _bullet; //Sets velocity of new projectile to match the old bullet.
    deleteVehicle _bullet;//Deletes original bullet
	
	};
	