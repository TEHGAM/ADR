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


if(_ammoType == "5000Rnd_762x51_Belt") then {
	
	//_newPos = _unit modelToWorld [0,8,0]; //Where to spawn the new projectile,this is to prevent spawning inside vic model
	_newPos = getPos _bullet;
    _veh = createVehicle ["B_127x108_APDS",_newPos,[],2,"CAN_COLLIDE"]; //Creates new bullet,see cfgMagazine for diffrent ammo types.
    _veh setDir getDir _bullet; //Sets dir of new bullet in the same direction the vic is moving,havent made one for turrents yet.
    _veh setVelocity velocity _bullet; //Sets velocity of new projectile to match the old bullet.
    deleteVehicle _bullet;//Deletes original bullet
	
	};

if(_ammoType == "500Rnd_127x99_mag_Tracer_Red") then {
	
	//_newPos = _unit modelToWorld [0,8,0]; //Where to spawn the new projectile,this is to prevent spawning inside vic model
	_newPos = getPos _bullet;
    _veh = createVehicle ["B_127x99_Ball_Tracer_Red",_newPos,[],2,"CAN_COLLIDE"]; //Creates new bullet,see cfgMagazine for diffrent ammo types.
    _veh setDir getDir _bullet; //Sets dir of new bullet in the same direction the vic is moving,havent made one for turrents yet.
    _veh setVelocity velocity _bullet; //Sets velocity of new projectile to match the old bullet.
    deleteVehicle _bullet;//Deletes original bullet
	
	};
	
	