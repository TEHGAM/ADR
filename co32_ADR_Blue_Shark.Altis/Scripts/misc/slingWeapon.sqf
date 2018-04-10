// slingWeapon.sqf
// slings the player's weapon. If the weapon is slung, change the action to "weapon in hand";

if ( currentWeapon player == "" ) then
{	player action ["SwitchWeapon", player, player, 0];
	player removeAction slingWeaponAction;
	slingWeaponAction = player addAction ["<t color='#ffec9f'>Sling Weapon</t>", "scripts\misc\slingWeapon.sqf", "", -98, false, true, "", "vehicle player==player && slinWeaponActionEnabled"];	
}
else
{	player action ["SwitchWeapon", player, player, 99];
	player removeAction slingWeaponAction;
	slingWeaponAction = player addAction ["<t color='#ffec9f'>Weapon in Hand</t>", "scripts\misc\slingWeapon.sqf", "", -98, false, true, "", "vehicle player==player && slinWeaponActionEnabled"];
};
