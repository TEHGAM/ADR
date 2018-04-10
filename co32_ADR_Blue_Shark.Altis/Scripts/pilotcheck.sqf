/*
Original author: Kamaradski [AW].
Since then been tweaked by many hands!
Notable contributors: chucky [allFPS], Quiksilver, BACONMOP, stanhope.

description: script that makes sure only pilots get in pilot seats (or admins)

last edited: 19/10/15 by stanhope

edited: rewrote them to get rid of the double arrays and to include the admin bypass
*/
//====definin aircrafts:

aircraftNoCoPilot = [
    // NATO TRANPORT HELI
    "B_Heli_Light_01_F",
    "B_Heli_Light_01_stripped_F",
    "B_Heli_Transport_01_F",
    "B_Heli_Transport_01_camo_F",
    "B_Heli_Transport_03_F",
    "B_Heli_Transport_03_unarmed_F",
    "B_Heli_Transport_03_black_F",
    "B_Heli_Transport_03_unarmed_green_F",
    "B_CTRG_Heli_Transport_01_sand_F",
    "B_CTRG_Heli_Transport_01_tropic_F",
    "B_T_VTOL_01_infantry_F",
    "B_T_VTOL_01_vehicle_F",
    "B_T_VTOL_01_infantry_blue_F",
    "B_T_VTOL_01_infantry_olive_F",
    "B_T_VTOL_01_vehicle_blue_F",
    "B_T_VTOL_01_vehicle_olive_F",

    // NATO ATTACK HELI (that shouldn't allow copilots)
    "B_Heli_Light_01_armed_F",
    "B_Heli_Light_01_dynamicLoadout_F",
    //"B_Heli_Attack_01_F", //this one should have a co-pilot
    //"B_Heli_Attack_01_dynamicLoadout_F", //this one should have a co-pilot
    "B_T_VTOL_01_armed_F",
    "B_T_VTOL_01_armed_blue_F",
    "B_T_VTOL_01_armed_olive_F",


    // INDEP TRANPORT HELI
    "I_Heli_Transport_02_F",
    "I_Heli_light_03_unarmed_F",
    "I_C_Heli_Light_01_civil_F",

    // INDEP ATTACK HELI (that shouldn't allow copilots)
    "I_Heli_light_03_F",
    "I_Heli_light_03_dynamicLoadout_F",


    // CSAT TRANPORT HELI
    "O_Heli_Light_02_unarmed_F",
    "O_Heli_Transport_04_F",
    "O_Heli_Transport_04_ammo_F",
    "O_Heli_Transport_04_bench_F",
    "O_Heli_Transport_04_box_F",
    "O_Heli_Transport_04_covered_F",
    "O_Heli_Transport_04_fuel_F",
    "O_Heli_Transport_04_medevac_F",
    "O_Heli_Transport_04_repair_F",
    "O_Heli_Transport_04_black_F",
    "O_Heli_Transport_04_ammo_black_F",
    "O_Heli_Transport_04_bench_black_F",
    "O_Heli_Transport_04_box_black_F",
    "O_Heli_Transport_04_covered_black_F",
    "O_Heli_Transport_04_fuel_black_F",
    "O_Heli_Transport_04_medevac_black_F",
    "O_Heli_Transport_04_repair_black_F",
    "O_T_VTOL_02_infantry_F",
    "O_T_VTOL_02_vehicle_F",
    "O_T_VTOL_02_infantry_dynamicLoadout_F",
    "O_T_VTOL_02_vehicle_dynamicLoadout_F",
    "O_T_VTOL_02_infantry_hex_F",
    "O_T_VTOL_02_infantry_ghex_F",
    "O_T_VTOL_02_infantry_grey_F",
    "O_T_VTOL_02_vehicle_hex_F",
    "O_T_VTOL_02_vehicle_ghex_F",
    "O_T_VTOL_02_vehicle_grey_F",

    // CSAT ATTACK HELI (that shouldn't allow copilots)
    "O_Heli_Light_02_dynamicLoadout_F",
    "O_Heli_Light_02_F",
    "O_Heli_Light_02_v2_F"
    //,"O_Heli_Attack_02_F",
    //"O_Heli_Attack_02_black_F",
    //"O_Heli_Attack_02_dynamicLoadout_F",
    //"O_Heli_Attack_02_dynamicLoadout_black_F"
];


player addEventHandler ["getInMan",{
	private _vehicleObject = _this select 2;
	private _adminInForbidden = false;

	 // player is not a pilot and is trying to get into the copilot seat of a vehicle where this is disabled
	if( !(player isKindOf "B_Helipilot_F") && ((aircraftNoCoPilot find (typeOf _vehicleObject)) != -1)) then {
		private _forbidden = [_vehicleObject turretUnit [0]];
		if( player in _forbidden ) then {
			if (player getVariable "isAdmin") exitWith {
				_adminInForbidden = true;
			};
			[parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>You entered a restricted seat.</t><br /><t size='1.2'>The co-pilot seat is locked for this vehicle.</t>"], true, nil, 5, 0.5, 0.3] spawn BIS_fnc_textTiles;
			moveOut player;
		};
	};

	// player is trying to get in a heli as the pilot while not being a pilot.
	if( (_vehicleObject isKindOf "Helicopter" || _vehicleObject isKindOf "Plane") && !(_vehicleObject isKindOf "ParachuteBase") && !(player isKindOf "B_Helipilot_F") ) then {
		private _forbidden = [driver _vehicleObject];
		if(player in _forbidden) exitWith {
			if (player getVariable "isAdmin") exitWith {
				_adminInForbidden = true;
			};
			[parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>You entered a restricted seat.</t><br /><t size='1.2'>The pilot seat is locked for non-pilots</t>"], true, nil, 5, 0.5, 0.3] spawn BIS_fnc_textTiles;
			moveOut player ;
		};
	};
	//reminding the admin  not to abuse his powers
	if (_adminInForbidden) exitWith {
		systemChat "Entred restricted seat, allowed because of admin priviliges, do not abuse this!";
	};
}];

player addEventHandler ["SeatSwitchedMan",{
	private _vehicleObject = _this select 2;
	private _adminInForbidden = false;

	 // player is not a pilot and is trying to get into the copilot seat of a vehicle where this is disabled
	if( !(player isKindOf "B_Helipilot_F") && ((aircraftNoCoPilot find (typeOf _vehicleObject)) != -1)) then {
		private _forbidden = [_vehicleObject turretUnit [0]];
		if( player in _forbidden ) then {
			if (player getVariable "isAdmin") exitWith {
				_adminInForbidden = true;
			};
			[parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>You entered a restricted seat.</t><br /><t size='1.2'>The co-pilot seat is locked for this vehicle.</t>"], true, nil, 5, 0.5, 0.3] spawn BIS_fnc_textTiles;
			moveOut player;
		};
	};

	// player is trying to get in a heli as the pilot while not being a pilot.
	if( (_vehicleObject isKindOf "Helicopter" || _vehicleObject isKindOf "Plane") && !(_vehicleObject isKindOf "ParachuteBase") && !(player isKindOf "B_Helipilot_F") ) then {
		private _forbidden = [driver _vehicleObject];
		if(player in _forbidden) exitWith {
			if (player getVariable "isAdmin") exitWith {
				_adminInForbidden = true;
			};
			[parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>You entered a restricted seat.</t><br /><t size='1.2'>The pilot seat is locked for non-pilots</t>"], true, nil, 5, 0.5, 0.3] spawn BIS_fnc_textTiles;
			moveOut player ;
		};
	};
	//reminding the admin  not to abuse his powers
	if (_adminInForbidden) exitWith {
		systemChat "Entred restricted seat, allowed because of admin priviliges, do not abuse this!";
	};
}];