/*
	Author: BACONMOP
	Written to spawn basic hunters at the main spawn.
*/

_veh = "B_MRAP_01_F" createVehicle (getMarkerPos "hunterSpawn");
_dir = markerDir "hunterSpawn";
_veh setDir _dir;
clearItemCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearBackpackCargoGlobal _veh;
