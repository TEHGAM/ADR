
private ["_itemsToClear","_obj","_rad","_delay"];
_obj = getMarkerPos "respawn_west"; 				// get spawn - might as well
_rad = 150;  										//  radius outwards from center point to clear items.
_delay = 300; 										// amount of time in-between clean-ups
 
while {true} do
{
	sleep _delay;

	_itemsToClear = nearestObjects [_obj,["weaponholder"],_rad];
	{
		deleteVehicle _x;
	} forEach _itemsToClear;

};