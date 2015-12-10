{deleteVehicle _x;} count (allMissionObjects "WeaponHolder");
/*
{deleteVehicle _x;} count (allMissionObjects "StaticWeapon");
{deleteVehicle _x;} count allMines;
*/
{deleteVehicle _x;} count allDead;
{deleteVehicle _x;} count (allMissionObjects "Ruins");
{deleteVehicle _x;} count (allMissionObjects "CraterLong");
sleep 2;
{if ((count units _x) == 0) then {deleteGroup _x;};} count allGroups;