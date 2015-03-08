/*

Author: wildw1ng
Contributor: Quiksilver
Editor: Your name here

Quiksilver notes:

	The more restrictions, the more performance-costly, as it is monitoring constantly whether players have weapons they shouldn't have.
	Item restrictions (explosives, rangefinders, uav terminals, etc.) have to be considered in a different manner. As of ArmA 1.16, don't bother trying to restrict
	items using the below setup, it doesn't work.

_________________________________________________*/

#define AT_MSG "Only AT Soldiers may use this weapon system. Launcher removed."
#define SNIPER_MSG "Only Snipers may use this weapon system. Sniper rifle removed."
#define AUTOTUR_MSG "You are not allowed to use this weapon system, Backpack removed."
#define UAV_MSG "Only UAV operator may use this Item, UAV terminal removed."

while { true } do {

	//------------------------------------- Launchers

	if ((player hasWeapon "launch_NLAW_F") || (player hasWeapon "launch_B_Titan_F") || (player hasWeapon "launch_O_Titan_F") || (player hasWeapon "launch_I_Titan_F") || (player hasWeapon "launch_B_Titan_short_F") || (player hasWeapon "launch_O_Titan_short_F") || (player hasWeapon "launch_I_Titan_short_F")) then
	{
		if ((playerSide == west && typeOf player != "B_soldier_LAT_F" && typeOf player != "B_recon_LAT_F" && typeOf player != "B_soldier_AT_F") || (playerside == east && typeOf player != "O_soldier_LAT_F") || (playerside == resistance && typeOf player != "I_soldier_LAT_F")) then
		{
			player removeWeapon (secondaryWeapon player);
			titleText [AT_MSG, "PLAIN", 3];
		};
	};

	//------------------------------------- Sniper Rifles

	if ((player hasWeapon "srifle_GM6_F") || (player hasWeapon "srifle_GM6_LRPS_F") || (player hasWeapon "srifle_LRR_F") || (player hasWeapon "srifle_GM6_SOS_F") || (player hasWeapon "srifle_GM6_camo_F") || (player hasWeapon "srifle_GM6_camo_SOS_F") || (player hasWeapon "srifle_GM6_camo_LRPS_F") || (player hasWeapon "srifle_LRR_camo_F") || (player hasWeapon "srifle_LRR_camo_LRPS_F") || (player hasWeapon "srifle_LRR_camo_SOS_F") || (player hasWeapon "srifle_LRR_LRPS_F") || (player hasWeapon "srifle_LRR_SOS_F")) then
	{
		if ((playerSide == west && typeOf player != "B_sniper_F") || (playerside == east && typeOf player != "O_sniper_F")) then
		{
			player removeWeapon (primaryWeapon player);
			titleText [SNIPER_MSG, "PLAIN", 3];
		};
	};

	//------------------------------------- UAV

	_uavOperator = ["B_soldier_UAV_F","B_officer_F"];
   	_uavRestricted = ["B_UavTerminal","O_UavTerminal","I_UavTerminal"];
    _assignedItems = assignedItems player;

	if (({"B_UavTerminal" == _x} count _assignedItems) > 0) then {
		if (({player isKindOf _x} count _uavOperator) < 1) then {
			player unassignItem "B_UavTerminal";
			player removeItem "B_UavTerminal";
			titleText [UAV_MSG,"PLAIN",3];
		};
	};

	//------------------------------------- Opfor turret backpacks

	_backpackRestricted = [
		"O_Mortar_01_support_F",
		"I_Mortar_01_support_F",
		"O_Mortar_01_weapon_F",
		"I_Mortar_01_weapon_F",
		"O_UAV_01_backpack_F",
		"I_UAV_01_backpack_F",
		"O_HMG_01_support_F",
		"I_HMG_01_support_F",
		"O_HMG_01_support_high_F",
		"I_HMG_01_support_high_F",
		"O_HMG_01_weapon_F",
		"I_HMG_01_weapon_F",
		"B_HMG_01_A_weapon_F",
		"O_HMG_01_A_weapon_F",
		"I_HMG_01_A_weapon_F",
		"O_GMG_01_weapon_F",
		"I_GMG_01_weapon_F",
		"B_GMG_01_A_weapon_F",
		"O_GMG_01_A_weapon_F",
		"I_GMG_01_A_weapon_F",
		"O_HMG_01_high_weapon_F",
		"I_HMG_01_high_weapon_F",
		"B_HMG_01_A_high_weapon_F",
		"O_HMG_01_A_high_weapon_F",
		"I_HMG_01_A_high_weapon_F",
		"O_GMG_01_high_weapon_F",
		"I_GMG_01_high_weapon_F",
		"B_GMG_01_A_high_weapon_F",
		"O_GMG_01_A_high_weapon_F",
		"I_GMG_01_A_high_weapon_F",
		"I_AT_01_weapon_F",
		"O_AT_01_weapon_F",
		"I_AA_01_weapon_F",
		"O_AA_01_weapon_F"
	];

	if (backpack player in _backpackRestricted) then {
		removeBackpack player;
		titleText [AUTOTUR_MSG, "PLAIN", 3];
	};
	sleep 5;
};
