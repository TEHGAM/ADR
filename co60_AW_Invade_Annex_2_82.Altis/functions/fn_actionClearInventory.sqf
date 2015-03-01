// Author: Quiksilver
// Clear inventory add action

_v = vehicle player;
clearItemCargoGlobal _v;
clearMagazineCargoGlobal _v;
inventory_cleared = TRUE;
[] spawn {
	sleep 300;
	inventory_cleared = FALSE;
};