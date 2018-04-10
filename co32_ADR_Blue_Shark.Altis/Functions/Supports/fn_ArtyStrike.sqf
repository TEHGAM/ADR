/*
Author: BACONMOP

Example:
_pos = getPos Player;
_unit = arty;
[_unit,_pos] call AW_fnc_artyStrike;

Parameters:
1. Unit that will fire.
2. Target Location.
*/
_arty = _this select 0;
_pos = _this select 1;
_arty setVehicleAmmo 1;
_amount = _arty ammo (currentWeapon _arty);
_shotsFired = floor (random _amount);
if (_shotsFired < 1) then {
	_shotsFired = _shotsFired + 1;
};
_ammo = (getArtilleryAmmo [_arty] select 0);
_randomPos = [[[_pos, 10],[]],[]] call BIS_fnc_randomPos;
_redSmoke = "SmokeShellRed" createVehicle _randomPos;
_arty commandArtilleryFire [_pos, _ammo, _shotsFired];