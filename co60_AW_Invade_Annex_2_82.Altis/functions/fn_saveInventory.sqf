/*
Author: Quiksilver
Date modified: 12/10/2014 ArmA 1.30
*/
if (saving_inventory) exitWith {hint "Saving gear, please wait ...";};
saving_inventory = true;
respawnInventory_Saved = true;
hint "Loadout saved. Next time you respawn, your current gear will be loaded.";
[player,[player,"ClassGear"]] call BIS_fnc_saveInventory;
[] spawn {
	sleep 3;
	saving_inventory = false;
};