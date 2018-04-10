private ["_removed", "_removedItems"];
_removed = "Items were removed from your inventory.<br /><br />Items removed:<br />=============<br />";
_removedItems = [];

if (!alive player && !gearRestriction) exitWith {};

waitUntil {sleep 1; !isNil "arsenalDefined"};
waitUntil {sleep 0.5; arsenalDefined};

//Weapons
{	if (!( _x in weaponsList ) && (_x != "")) then
	{	player removeWeapon _x;	
		_removed = _removed + str (getText (configFile >> "cfgWeapons" >> _x >> "DisplayName")) + "<br />"; 
		_removedItems pushBack _x;
	};
} forEach (weapons player);
sleep 0.1;
//primary weapon attachements
{	if ( ( !( _x in itemsList ) || (_x in itemBlackList ) ) && (_x != "") )  then
	{	_removed = _removed + str _x + "<br />"; 
		_removedItems pushBack _x;
		player removePrimaryWeaponItem _x; 
	};
} forEach (primaryWeaponItems player);
sleep 0.1;
//secondary weapon attachements
{	if ( ( !( _x in itemsList ) || (_x in itemBlackList ) ) && (_x != "") )  then
	{	_removed = _removed + str _x + "<br />"; 
		player removeSecondaryWeaponItem _x;
	};
} forEach (secondaryWeaponItems player);
sleep 0.1;
//handgun weapon attachements
{	if ( ( !( _x in itemsList ) || (_x in itemBlackList ) ) && (_x != "") )  then
	{	_removed = _removed + str _x + "<br />"; 
		player removeHandgunItem _x;
	};
} forEach (handgunItems  player);
sleep 0.1;

//Headgear
if ( ( !( (headgear player) in itemsList ) || ((headgear player) in itemBlackList ) ) && (headgear player != "") ) then
{	_removed = _removed + str (headgear player) + "<br />"; 
	_removedItems pushBack (headgear player);
	removeHeadgear player; 
};
sleep 0.1;
//Uniform
if ( ( !( (uniform  player) in itemsList ) || ((uniform player) in itemBlackList ) ) && (uniform player != "") ) then
{	_removed = _removed + str (uniform player) + "<br />"; 
	_removedItems pushBack (uniform player);
	removeUniform player;
};
sleep 0.1;
//vest
if ( ( !((vest player) in itemsList ) || ((vest player) in itemBlackList ) ) && (vest player != "") ) then
{	_removed = _removed + str (vest player) + "<br />"; 
	_removedItems pushBack (vest player);
	removeVest player;
};
sleep 0.1;
//Backpack
if ( ( !( (backpack player) in backpackList ) || ((backpack player) in itemBlackList ) ) && (backpack player != "") ) then
{	_removed = _removed + str (backpack player) + "<br />"; 
	_removedItems pushBack (backpack player);
	removeBackpack player;
};
sleep 0.1;
//Assigned itmes
{	if ( ( !( _x in itemsList ) || (_x in itemBlackList ) ) && (_x != "") )  then
	{	_removed = _removed + str _x + "<br />"; 
		_removedItems pushBack _x;
		player unassignItem _x;
		player removeItem _x;
	};
} forEach (assignedItems player);
sleep 0.1;
//Not assigned items itmes
{	if ( ( !( _x in itemsList ) || (_x in itemBlackList ) ) && (_x != "") )  then
	{	_removed = _removed + str _x + "<br />"; 
		_removedItems pushBack _x;
		player removeItem _x;
	};
} forEach (Items player);
sleep 0.1;

//tell him what happend
if ( count _removedItems > 0 ) then	{ hint parseText format ['%1', _removed]; _removedItems = [];};


