/*
@filename: fn_vSetup02.sqf
Author:     ???
	
Last modified:  16/12/17 by McK
	
modified:   tweaked addactions flip
	
Description:    Apply code to vehicle
	            vSetup02 deals with code that is already applied where it should be.
*/

//============================================= CONFIG
private ["_camo","_innerpylon","_AMRAAMcount","_outerpylon","_wingtipAA","_middlepylon","_rocketpod","_missilepod","_bombs"];

private _vehicle = _this select 0;
private _vehicleType = typeOf _vehicle;
if (isNull _vehicle) exitWith {};

//============================================= ARRAYS
//===jets===
private _wipeout = ["B_Plane_CAS_01_dynamicLoadout_F"];
private _stealthwasp = ["B_Plane_Fighter_01_Stealth_F"];
private _wasp = ["B_Plane_Fighter_01_F"];
private _gryphon = ["I_Plane_Fighter_04_F"];
private _buzzard = ["I_Plane_Fighter_03_dynamicLoadout_F"];

//===helis===
private _ghosthawk = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"];
private _orca = ["O_Heli_Light_02_F","	O_Heli_Light_02_unarmed_F"];
private _hellcat = ["I_Heli_light_03_F"];
private _humming = ["B_Heli_Light_01_F","B_Heli_Light_01_armed_F"];
private _huron = ["B_Heli_Transport_03_unarmed_F","B_Heli_Transport_03_F","B_Heli_Transport_03_black_F","B_Heli_Transport_03_unarmed_green_F"];
private _kajmanDL = ["O_Heli_Attack_02_dynamicLoadout_F","O_Heli_Attack_02_dynamicLoadout_black_F"];

//===UAV/UGV===
private _uav = ["B_UAV_02_CAS_F","B_UAV_02_F","B_UGV_01_F","B_UGV_01_rcws_F","B_UAV_05_F"];

//===IFVs===
private _gorgon = ["I_APC_Wheeled_03_cannon_F"];
//===MRAPs===
private _strider = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];
//===cars===
private _qilin = ["O_T_LSV_02_armed_F"];

//==custom camo==
private _blackVehicles = [];															//black skin
private _natocamo = [];											                        //nato skin

//==other==
private _mobileArmory = ["B_Truck_01_ammo_F"];											// Mobile Armory
private _noAmmoCargo = ["B_APC_Tracked_01_CRV_F","B_Truck_01_ammo_F"];					// Bobcat CRV

private _slingHeli = ["I_Heli_Transport_02_F","B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"];				// sling capable
private _slingable = ["B_Heli_Light_01_F"];												// slingable
private _notSlingable = ["B_Heli_Light_01_armed_F", "B_Heli_Attack_01_F"];				// not slingable
private _dropHeli = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"]; 			// drop capable

private _allHelis = ["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_Heli_Transport_03_F","B_Heli_Transport_03_unarmed_F","B_Heli_Light_01_F","B_Heli_Transport_01_F","B_Heli_Transport_01_camo_F","B_CTRG_Heli_Transport_01_sand_F","B_CTRG_Heli_Transport_01_tropic_F","O_Heli_Transport_04_F","O_Heli_Transport_04_ammo_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_box_F","O_Heli_Transport_04_fuel_F","O_Heli_Transport_04_medevac_F","O_Heli_Transport_04_repair_F","O_Heli_Transport_04_covered_F","O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F","O_Heli_Light_02_v2_F","O_Heli_Light_02_unarmed_F","I_Heli_Transport_02_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F","I_C_Heli_Light_01_civil_F"];


//====================== Done defining stuff, let's start messing around===========================

//=============code for all vehicles=============
//=====fuel function
[   _vehicle,
    ["<t color='#1eff65'>Refuel vehicle</t>",{
    if (fuel (_this select 0) < 0.2) then {
        (_this select 0) setFuel 0.2; (_this select 0) vehicleChat "Engineer refuelled your vehicle";
    }else {
        (_this select 0) vehicleChat "Engineer tried to refuel but fuel is not required";
    };},"",0,true,true,"","(player isKindOf 'B_soldier_repair_F'|| player isKindOf 'B_engineer_F') &&(fuel _target <0.2) ",5]
] remoteExecCall ["addAction", 0, true];
//====flip function
	[   _vehicle,
		["<t color='#1eff65'>Flip vehicle</t>", {
		_targetVehicle = _this select 0;
		//_targetVehicle setPos (getPos _targetVehicle vectorAdd [0,0,1]);
		_targetVehicle setVectorUp surfaceNormal position _targetVehicle;
		_targetVehicle setPosATL [(getPosATL _targetVehicle) select 0,(getPosATL _targetVehicle) select 1,0.1];
		}, nil, -20, true, true, "", "
		((speed _target) < 1) && ( ((count (_target nearEntities ['Man', 15])) > 3) ||  ((count (_target nearEntities ['B_APC_Tracked_01_CRV_F', 15])) > 0) ) && ((count (crew _target)) < 2)", 7]
	] remoteExecCall ["addAction", 0, true];

//=========================Planes=============================
//=========wipeout
if (_vehicleType in _wipeout) then {
	//an A-164 Wipeout (CAS)
	_vehicle removeMagazine "120Rnd_CMFlare_Chaff_Magazine";
	_vehicle addMagazine "60Rnd_CMFlare_Chaff_Magazine";
	{_vehicle removeWeapon _x} forEach ["Missile_AA_04_Plane_CAS_01_F","Missile_AGM_02_Plane_CAS_01_F","Rocket_04_HE_Plane_CAS_01_F","Rocket_04_AP_Plane_CAS_01_F","Bomb_04_Plane_CAS_01_F"];

	//====select random loadout=====
	_rocketpod = selectRandom ["PylonRack_12Rnd_missiles","PylonRack_12Rnd_PG_missiles","Shrieker"];
	if (_rocketpod == "PylonRack_12Rnd_PG_missiles")
	then {_missilepod = selectRandom ["PylonRack_1Rnd_Missile_AGM_02_F","PylonRack_1Rnd_LG_scalpel"];}
	else {_missilepod = selectRandom ["PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_1Rnd_Missile_AGM_02_F","PylonRack_3Rnd_LG_scalpel","PylonRack_1Rnd_LG_scalpel"];};
	_bombs = selectRandom ["PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Mk82_F","2x2"];

	//=========defensive AA=========
	_vehicle setPylonLoadOut [1, "PylonRack_1Rnd_Missile_AA_04_F",false,[]];
	_vehicle setPylonLoadOut [10, "PylonRack_1Rnd_Missile_AA_04_F",false,[]];
	//=========rocket pod===========
	if (_rocketpod == "Shrieker") then {
	_vehicle setPylonLoadOut [2, "PylonRack_7Rnd_Rocket_04_HE_F",false,[]];
	_vehicle setPylonLoadOut [9, "PylonRack_7Rnd_Rocket_04_AP_F",false,[]];
	}else{
	_vehicle setPylonLoadOut [2, _rocketpod,false,[]];
	_vehicle setPylonLoadOut [9, _rocketpod,false,[]];
	};
	//==========missiles==========
	_vehicle setPylonLoadOut [3, _missilepod,false,[]];
	_vehicle setPylonLoadOut [8, _missilepod,false,[]];
	//==========bombs==============
	if (_bombs == "2x2") then {
	_vehicle setPylonLoadOut [4, "PylonMissile_1Rnd_Mk82_F",false,[]];
	_vehicle setPylonLoadOut [5, "PylonMissile_1Rnd_Bomb_04_F",false,[]];
	_vehicle setPylonLoadOut [6, "PylonMissile_1Rnd_Bomb_04_F",false,[]];
	_vehicle setPylonLoadOut [7, "PylonMissile_1Rnd_Mk82_F",false,[]];
	}else{
	for "_i" from 4 to 7 do{_vehicle setPylonLoadOut [_i, _bombs,false,[]];};
	};
};


//=====black wasp
if (_vehicleType in _wasp) then {
	//an F/A-181 Black Wasp II
	_waspcamo = selectRandom [
	['a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_01_co.paa','a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_02_co.paa'],
	['a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_01_camo_co.paa','a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_02_camo_co.paa']];
	_vehicle setObjectTextureGlobal[0, (_waspcamo select 0)];
	_vehicle setObjectTextureGlobal[1, (_waspcamo select 1)];
	_vehicle removeMagazine "240Rnd_CMFlare_Chaff_Magazine";
	_vehicle addMagazine "120Rnd_CMFlare_Chaff_Magazine";
	_vehicle removeWeapon "weapon_AGM_65Launcher";
	//====select random loadout=====
	_outerpylon = selectRandom ["PylonRack_Missile_AGM_02_x1","PylonMissile_Bomb_GBU12_x1","PylonRack_Missile_BIM9X_x1","PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x2","PylonRack_Missile_BIM9X_x2"];
	switch (_outerpylon) do {
		case "PylonMissile_Bomb_GBU12_x1":{
			_AMRAAMcount = selectRandom ["2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x2","PylonRack_Missile_BIM9X_x2","PylonRack_Missile_AMRAAM_D_x2"];
		};
		case "PylonRack_Missile_AGM_02_x1":{
			_AMRAAMcount = selectRandom ["2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonRack_Missile_BIM9X_x2","PylonRack_Missile_AMRAAM_D_x1"];
		};
		case "PylonRack_Missile_BIM9X_x1":{
			_AMRAAMcount = selectRandom ["2","2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
		};
		case "PylonRack_Missile_BIM9X_x2":{
			_AMRAAMcount = selectRandom ["2","2","2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
		};
		case "PylonRack_Missile_AMRAAM_D_x1":{
			_AMRAAMcount = selectRandom ["2","2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
		};
		case "PylonRack_Missile_AMRAAM_D_x2":{
			_AMRAAMcount = selectRandom ["2","2","2","4"];
			_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x1","PylonRack_Bomb_GBU12_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
		};
		default {
		_innerpylon = selectRandom ["PylonRack_Missile_AGM_02_x1","PylonRack_Missile_AGM_02_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1","PylonRack_Missile_BIM9X_x1","PylonRack_Missile_BIM9X_x2","PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x2"];
		};
	};
	//======outer pylons=========
	_vehicle setPylonLoadOut [1, _outerpylon,false,[]];
	_vehicle setPylonLoadOut [2, _outerpylon,false,[]];
	//========inner pylons=========
	_vehicle setPylonLoadOut [3, _innerpylon,false,[]];
	_vehicle setPylonLoadOut [4, _innerpylon,false,[]];
	//========outer AA bays=========
	_vehicle setPylonLoadOut [5, "PylonRack_Missile_BIM9X_x1",false,[]];
	_vehicle setPylonLoadOut [6, "PylonRack_Missile_BIM9X_x1",false,[]];
	//=====outer and middle inner bay
	if (_AMRAAMcount == "2")then {
	_vehicle setPylonLoadOut [7, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];
	_vehicle setPylonLoadOut [8, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];
	_vehicle setPylonLoadOut [9, "",false,[]];
	_vehicle setPylonLoadOut [10, "",false,[]];
	};
	if (_AMRAAMcount == "4")then {
	for "_i" from 7 to 10 do{_vehicle setPylonLoadOut [_i, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];};
	};
	//=====inner pylons inner bay====
	_vehicle setPylonLoadOut [11, "PylonMissile_Bomb_GBU12_x1",false,[]];
	_vehicle setPylonLoadOut [12, "PylonMissile_Bomb_GBU12_x1",false,[]];
};

//=====stealth wasp
if (_vehicleType in _stealthwasp) then {
	//an F/A-181 Black Wasp II (stealth)
	_waspcamo = selectRandom [
	['a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_01_co.paa','a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_02_co.paa'],
	['a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_01_camo_co.paa','a3\air_f_jets\plane_fighter_01\data\Fighter_01_fuselage_02_camo_co.paa']];
	_vehicle setObjectTextureGlobal[0, (_waspcamo select 0)];
	_vehicle setObjectTextureGlobal[1, (_waspcamo select 1)];
	_vehicle removeMagazine "240Rnd_CMFlare_Chaff_Magazine";
	_vehicle addMagazine "120Rnd_CMFlare_Chaff_Magazine";
	_vehicle removeWeapon "weapon_GBU12Launcher";

	//====select random loadout=====
	_AMRAAMcount = selectRandom ["2","2","2","2","2","2","2","4","4","6"];

	//========outer AA bays=========
	_vehicle setPylonLoadOut [5, "PylonRack_Missile_BIM9X_x1",false,[]];
	_vehicle setPylonLoadOut [6, "PylonRack_Missile_BIM9X_x1",false,[]];

	//=====outer and middle inner bay
	switch (_AMRAAMcount) do {
		case "2":{
			_vehicle setPylonLoadOut [7, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];
			_vehicle setPylonLoadOut [8, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];

			for "_i" from 9 to 12 do{_vehicle setPylonLoadOut [_i, "",false,[]];};
		};
		case "4":{
			for "_i" from 7 to 10 do{_vehicle setPylonLoadOut [_i, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];};
			_vehicle setPylonLoadOut [11, "",false,[]];
			_vehicle setPylonLoadOut [12, "",false,[]];
		};
		case "6":{
			for "_i" from 7 to 12 do{_vehicle setPylonLoadOut [_i, "PylonMissile_Missile_AMRAAM_D_INT_x1",false,[]];};
		};
	};
};

//====grypohn
if (_vehicleType in _gryphon) then {
	//an A-149 Gryphon
	_vehicle setObjectTextureGlobal[0, 'a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_01_co.paa'];
	_vehicle setObjectTextureGlobal[1, 'a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_02_co.paa'];
	_vehicle removeMagazine "240Rnd_CMFlare_Chaff_Magazine";
	_vehicle addMagazine "120Rnd_CMFlare_Chaff_Magazine";
	{_vehicle removeWeapon _x} forEach ["weapon_AGM_65Launcher","weapon_AMRAAMLauncher","weapon_GBU12Launcher","weapon_BIM9xLauncher"];
	//=======random loadout=========
	_innerpylon = selectRandom ["PylonRack_Missile_BIM9X_x2","PylonRack_Missile_AMRAAM_C_x2"];
	if (_innerpylon == "PylonRack_Missile_BIM9X_x2")then {
	_wingtipAA = selectRandom ["PylonMissile_Missile_BIM9X_x1","PylonRack_Missile_AMRAAM_C_x1"];
	_middlepylon = selectRandom ["PylonRack_Missile_AMRAAM_C_x1"/*,"PylonRack_Missile_BIM9X_x1"*/];
	};
	if (_innerpylon == "PylonRack_Missile_AMRAAM_C_x2")then {
	_wingtipAA = selectRandom ["PylonMissile_Missile_BIM9X_x1"/*,"PylonRack_Missile_AMRAAM_C_x1"*/];
	_middlepylon = selectRandom ["PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_BIM9X_x1"];
	};
	//=========wingtips===========
	_vehicle setPylonLoadOut [1, _wingtipAA,false,[]];
	_vehicle setPylonLoadOut [2, _wingtipAA,false,[]];
	//======middle pylons=========
	_vehicle setPylonLoadOut [3, _middlepylon,false,[]];
	_vehicle setPylonLoadOut [4, _middlepylon,false,[]];
	//======inner pylons===========
	_vehicle setPylonLoadOut [5, _innerpylon,false,[]];
	_vehicle setPylonLoadOut [6, _innerpylon,false,[]];
};
//====buzzard
if (_vehicleType in _buzzard) then {
	//a buzzard
	{_vehicle removeWeapon _x} forEach ["missiles_SCALPEL","missiles_ASRAAM","GBU12BombLauncher_Plane_Fighter_03_F","GBU12BombLauncher","weapon_GBU12Launcher"];
	//=======random loadout=========
	_maingun = "PylonWeapon_300Rnd_20mm_shells";
	_wingtipAA = selectRandom ["PylonRack_1Rnd_AAA_missiles","PylonRack_1Rnd_Missile_AA_04_F"];
	_middlepylon = selectRandom ["PylonRack_1Rnd_AAA_missiles","PylonRack_1Rnd_Missile_AA_04_F","PylonRack_1Rnd_GAA_missiles"];
	_innerpylon = "PylonRack_1Rnd_GAA_missiles";
	//=========wingtips===========
	_vehicle setPylonLoadOut [1, _wingtipAA,false,[]];
	_vehicle setPylonLoadOut [7, _wingtipAA,false,[]];
	//======middle pylons=========
	_vehicle setPylonLoadOut [2, _middlepylon,false,[]];
	_vehicle setPylonLoadOut [6, _middlepylon,false,[]];
	//======inner pylons===========
	_vehicle setPylonLoadOut [3, _innerpylon,false,[]];
	_vehicle setPylonLoadOut [5, _innerpylon,false,[]];
	//==========main gun==========
	_vehicle setPylonLoadOut [1, _maingun,false,[]];
};

//=================================Helis===========================================

//===== littlebird digital skin
if(_vehicleType in _humming) then {
	_camo = selectRandom [
	'A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_BLUFOR_CO.paa',
	'A3\Air_F\Heli_Light_01\Data\Heli_Light_01_ext_ION_CO.paa',
	'A3\Air_F\Heli_Light_01\Data\skins\Heli_Light_01_ext_wasp_co.paa',
	'A3\Air_F\Heli_Light_01\Data\skins\heli_light_01_ext_digital_co.paa',
	'A3\Air_F\Heli_Light_01\Data\skins\heli_light_01_ext_digital_co.paa'
	];
	_vehicle setObjectTextureGlobal[0, _camo];
};

//===== Huron random skin
if(_vehicleType in _huron) then {
	_camo = ["black"];
	_camo = selectRandom ["black","green"];
	if (_camo == "green") then {
	_vehicle setObjectTextureGlobal [0, "A3\Air_f_heli\Heli_Transport_03\data\Heli_Transport_03_ext01_CO.paa"];
	_vehicle setObjectTextureGlobal [1, "A3\Air_f_heli\Heli_Transport_03\data\Heli_Transport_03_ext02_CO.paa"];
	};
	if (_camo == "black") then {
	_vehicle setObjectTextureGlobal [0, "A3\Air_f_heli\Heli_Transport_03\data\Heli_Transport_03_ext01_black_CO.paa"];
	_vehicle setObjectTextureGlobal [1, "A3\Air_f_heli\Heli_Transport_03\data\Heli_Transport_03_ext02_black_CO.paa"];
	};
};

//======hellcat
if(_vehicleType in _hellcat) then {
	_vehicle setObjectTextureGlobal [0, "\a3\air_F_EPB\Heli_Light_03\Data\Heli_Light_03_base_CO.paa"];
};
//===== orca black skin
if(_vehicleType in _orca) then {
	_vehicle setObjectTextureGlobal [0, "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_co.paa"];
};

//===== kajman loadout
/*
For gunner:
"PylonMissile_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel"[0]"
"PylonRack_1Rnd_Missile_AGM_01_F"
For pilot:
"PylonWeapon_300Rnd_20mm_shells","PylonRack_20Rnd_Rocket_03_HE_F","PylonRack_20Rnd_Rocket_03_AP_F","PylonRack_19Rnd_Rocket_Skyfire"
"PylonRack_1Rnd_Missile_AA_03_F","PylonMissile_1Rnd_Bomb_03_F","PylonMissile_1Rnd_BombCluster_02_F"
*/
if(_vehicleType in _kajmanDL) then {
    _vehicle removeWeapon "rockets_Skyfire";
    _vehicle setPylonLoadOut [1, "PylonRack_3Rnd_LG_scalpel",false,[0]];
    _vehicle setPylonLoadOut [2, "PylonRack_20Rnd_Rocket_03_AP_F",false,[]];
    _vehicle setPylonLoadOut [3, "PylonRack_20Rnd_Rocket_03_HE_F",false,[]];
    _vehicle setPylonLoadOut [4, "PylonRack_3Rnd_LG_scalpel",false,[0]];
};

//===== Ghosthawk
if (_vehicleType in _ghosthawk) then {
	_vehicle setVariable ["turretL_locked",false,true];
	_vehicle setVariable ["turretR_locked",false,true];
	_camo = ["black"];
	_camo = selectRandom ["black","green"];
	if (_camo == "green") then {
	_vehicle setObjectTextureGlobal [0, "A3\Air_F_Beta\Heli_Transport_01\Data\Heli_Transport_01_ext01_BLUFOR_CO.paa"];
	_vehicle setObjectTextureGlobal [1, "A3\Air_F_Beta\Heli_Transport_01\Data\Heli_Transport_01_ext02_BLUFOR_CO.paa"];
	};
	if (_camo == "black") then {
	_vehicle setObjectTextureGlobal [0, "A3\Air_F_Beta\Heli_Transport_01\Data\Heli_Transport_01_ext01_CO.paa"];
	_vehicle setObjectTextureGlobal [1, "A3\Air_F_Beta\Heli_Transport_01\Data\Heli_Transport_01_ext02_CO.paa"];
	};	
};

//===== Heli KillMessage
if (_vehicleType in _allHelis) then {
	_vehicle addEventHandler ["killed",{[] spawn {sleep 3;_artyMessageArray = ['mp_groundsupport_65_chopperdown_BHQ_0','mp_groundsupport_65_chopperdown_BHQ_1','mp_groundsupport_65_chopperdown_BHQ_2'];_artyMessage = selectRandom _artyMessageArray;[[west, 'Base'],_artyMessage] remoteExec ['sideRadio',0,false];};}];
};
//=========================================UAV=======================================
if(_vehicleType in _uav) then {
	{deleteVehicle _x;} count (crew _vehicle);
	[_vehicle] spawn {
		_vehicle = _this select 0;
		sleep 2;
		createVehicleCrew _vehicle;
	};
};

//==================================ground vehicles================================
//===== strider nato skin
if (_vehicleType in _strider) then {
	_vehicle setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'];
	_vehicle setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa'];
};
//===== gorgon nato skin
if (_vehicleType in _gorgon) then {
	_vehicle setObjectTextureGlobal [0, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa"];
	_vehicle setObjectTextureGlobal [1, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"];
	_vehicle setObjectTextureGlobal [2, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa"];
	_vehicle setObjectTextureGlobal [3, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"];
};
//===== qilin black skin
if (_vehicleType in _qilin) then {
	_vehicle setObjectTextureGlobal[0, '\A3\soft_f_exp\LSV_02\data\CSAT_LSV_01_black_CO.paa'];
	_vehicle setObjectTextureGlobal[1, '\A3\soft_f_exp\LSV_02\data\CSAT_LSV_02_black_CO.paa'];
	_vehicle setObjectTextureGlobal[2, '\A3\soft_f_exp\LSV_02\data\CSAT_LSV_03_black_CO.paa'];
};

//=================================Misc======================================
//===== black camo
if (_vehicleType in _blackVehicles) then {
	for "_i" from 0 to 9 do {_vehicle setObjectTextureGlobal [_i,"#(argb,8,8,3)color(0,0,0,0.6)"];};
};
//=====nato camo
if (_vehicleType in _natocamo) then {
	for "_i" from 0 to 2 do {_vehicle setObjectTextureGlobal[_i,"#(argb,8,8,3)color(0.518,0.519,0.455,0.2)"];};
};
//=====remove certain weapons from all vehicles:
{
	_weaponlist = weapons _vehicle;
	if (_x in _weaponlist) then {
		_vehicle removeWeapon _x
	};
} forEach ["Laserdesignator_pilotCamera","Laserdesignator_mounted"];
//=== Zues
{_x addCuratorEditableObjects [[_vehicle],false];} count allCurators;

if ((missionStart select 1) == 4 && (missionStart select 2) == 1) then {
	_vehicle setObjectTextureGlobal[0, '#(argb,8,8,3)color(0.8,0.1,0.6,0.6)'];
	_vehicle setObjectTextureGlobal[1, '#(argb,8,8,3)color(0.8,0.1,0.6,0.6)'];
	_vehicle setObjectTextureGlobal[2, '#(argb,8,8,3)color(0.8,0.1,0.6,0.6)'];
};
