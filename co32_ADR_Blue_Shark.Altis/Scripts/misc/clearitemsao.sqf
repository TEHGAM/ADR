{deleteVehicle _x;} count (allMissionObjects "WeaponHolder");
[] spawn {
    private ['_static'];
    {
        _static = _x;
        if ((isNull (attachedTo _static)) && {(({((_x distance _static) < 1000)} count allPlayers) isEqualTo 0)}) then {
            if ((count (crew _static)) > 0) then {
                {deleteVehicle _x;} count (crew _static);
            };
            deleteVehicle _static;
        };
    } count (allMissionObjects "StaticWeapon" );
};
{deleteVehicle _x;} count allMines;
{deleteVehicle _x;} count allDead;
{deleteVehicle _x;} count (allMissionObjects "Ruins");
sleep 2;
{if ((count units _x) == 0) then {deleteGroup _x;};} count allGroups;