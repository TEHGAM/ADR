private ["_opticsAllowed","_specialisedOptics","_basePos","_firstRun","_insideSafezone","_outsideSafezone"];

#define AT_MSG "Только Стрелок[ПТ] может использовать это оружие."
#define SNIPER_MSG "Только снайперы могут использовать это оружие."
#define AUTOTUR_MSG "Данное вооружение запрещено."
#define UAV_MSG "Только операторы БПЛА могут использовать терминал управления."

//===== UAV TERMINAL
_uavOperator = ["B_soldier_UAV_F","B_officer_F"];
//===== AT / MISSILE LAUNCHERS (excl RPG)
_missileSoldiers = ["B_soldier_LAT_F","B_soldier_AA_F","B_soldier_AT_F","B_officer_F","B_recon_LAT_F"];
_missileSpecialised = ["launch_NLAW_F","launch_B_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_short_F","launch_O_Titan_short_F","launch_I_Titan_short_F"];
//===== SNIPER RIFLES
_snipers = ["B_sniper_F","B_officer_F"];
_sniperSpecialised = ["srifle_GM6_F","srifle_GM6_LRPS_F","srifle_GM6_SOS_F","srifle_LRR_F","srifle_LRR_LRPS_F","srifle_LRR_SOS_F","srifle_GM6_camo_F","srifle_GM6_camo_LRPS_F","srifle_GM6_camo_SOS_F","srifle_LRR_camo_F","srifle_LRR_camo_LRPS_F","srifle_LRR_camo_SOS_F"];
//===== BACKPACKS
_backpackRestricted = ["O_Mortar_01_support_F","I_Mortar_01_support_F","O_Mortar_01_weapon_F","I_Mortar_01_weapon_F","O_UAV_01_backpack_F","I_UAV_01_backpack_F","O_HMG_01_support_F","I_HMG_01_support_F","O_HMG_01_support_high_F","I_HMG_01_support_high_F","O_HMG_01_weapon_F","I_HMG_01_weapon_F","O_HMG_01_A_weapon_F","I_HMG_01_A_weapon_F","O_GMG_01_weapon_F","I_GMG_01_weapon_F","O_GMG_01_A_weapon_F","I_GMG_01_A_weapon_F","O_HMG_01_high_weapon_F","I_HMG_01_high_weapon_F","O_HMG_01_A_high_weapon_F","I_HMG_01_A_high_weapon_F","O_GMG_01_high_weapon_F","I_GMG_01_high_weapon_F","O_GMG_01_A_high_weapon_F","I_GMG_01_A_high_weapon_F","I_AT_01_weapon_F","O_AT_01_weapon_F","I_AA_01_weapon_F","O_AA_01_weapon_F","B_Respawn_TentDome_F","B_Respawn_TentA_F","B_Respawn_Sleeping_bag_F","B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F"];

_basePos = getMarkerPos "respawn_west";

_szmkr = getMarkerPos "safezone_marker";
#define SZ_RADIUS 500

_EHFIRED = {
	deleteVehicle (_this select 6);
	hintC "Использование оружия на базе запрещено! В целях безопасности.";
    hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
        0 = _this spawn {
            _this select 0 displayRemoveEventHandler ["unload", hintC_EH];
            hintSilent "";
        };
    }];
};

_firstRun = TRUE;
if (_firstRun) then {
	_firstRun = FALSE;
	if ((player distance _szmkr) <= SZ_RADIUS) then {
		_insideSafezone = TRUE;
		_outsideSafezone = FALSE;
		EHFIRED = player addEventHandler ["Fired",_EHFIRED];
	} else {
		_outsideSafezone = TRUE;
		_insideSafezone = FALSE;
	};
};

while {true} do {

	//------------------------------------- Launchers

	if (({player hasWeapon _x} count _missileSpecialised) > 0) then {
		if (({player isKindOf _x} count _missileSoldiers) < 1) then {
			player removeWeapon (secondaryWeapon player);
			titleText [AT_MSG,"PLAIN",3];
		};
	};
	
	sleep 1;
	//------------------------------------- Sniper Rifles

	if (({player hasWeapon _x} count _sniperSpecialised) > 0) then {
		if (({player isKindOf _x} count _snipers) < 1) then {
			player removeWeapon (primaryWeapon player);
			titleText [SNIPER_MSG,"PLAIN",3];
		};
	};

	sleep 1;
	//------------------------------------- UAV

    _assignedItems = assignedItems player;

	if (({"B_UavTerminal" == _x} count _assignedItems) > 0) then {
		if (({player isKindOf _x} count _uavOperator) < 1) then {
			player unassignItem "B_UavTerminal";
			player removeItem "B_UavTerminal";
			titleText [UAV_MSG,"PLAIN",3];
		};
	};
	
	sleep 1;

	//------------------------------------- Opfor turret backpacks

	if ((backpack player) in _backpackRestricted) then {
		removeBackpack player;
		titleText [AUTOTUR_MSG, "PLAIN", 3];
	};
	
	//===================================== SAFE ZONE MANAGER
	
	_szmkr = getMarkerPos "safezone_marker";
	if (_insideSafezone) then {
		if ((player distance _szmkr) > SZ_RADIUS) then {
			_insideSafezone = FALSE;
			_outsideSafezone = TRUE;
			player removeEventHandler ["Fired",EHFIRED];
		};
	};
	sleep 2;
	if (_outsideSafezone) then {
		if ((player distance _szmkr) < SZ_RADIUS) then { 
			_outsideSafezone = FALSE;
			_insideSafezone = TRUE;
			EHFIRED = player addEventHandler ["Fired",_EHFIRED];
		};
	};
	
	//----- Sleep 
	
	_basePos = getMarkerPos "respawn_west";
	if ((player distance _basePos) <= 500) then {
		sleep 1;
	} else {
		sleep 20;
	};
};