/* 
Author:			Quiksilver

modified by:	stanhope, AW community member

Describtion:	Clear inventory via addaction in onplayerrespawn.sqf
*/

_vehicle = vehicle player;
clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
