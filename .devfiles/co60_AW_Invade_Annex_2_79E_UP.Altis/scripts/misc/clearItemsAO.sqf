private ["_itemsToClear","_obj","_rad"];
_obj = getMarkerPos currentAO; 						// get spawn - might as well
_rad = 1000;  										//  radius outwards from center point to clear items.
 
_itemsToClear = nearestObjects [_obj,["WeaponHolder"],_rad];
{deleteVehicle _x;} count _itemsToClear;

{deleteVehicle _x;} count (allMissionObjects "CraterLong");