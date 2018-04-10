/*
* Author: alganthe
* Event handling the drawing of icons on downed units for medics or for everyone (depending on setting)
* DO NOT CALL THIS. This should only be called once on player init
*
* Arguments:
* Nothing
*
* Return Value:
* Nothing
*/
addMissionEventHandler ["Draw3D", {
    {
        drawIcon3D [
            "\A3\ui_f\data\igui\cfg\actions\heal_ca.paa",
            [0.74, 0.06, 0.06, 1 * (1 - ((player distance2d _x  ) / 1000))],
            visiblePosition _x,
            1 * (1 - ((player distance2d _x  ) / 1000)),
            1 * (1 - ((player distance2d _x) / 1000)),
            0,
            "",
            2 * (1 - ((player distance2d _x) / 1000)),
            0.04 * (1 - ((player distance2d _x) / 1000))
        ];
    } forEach (position player nearEntities ["CAManBase", 1000] select {_x != player && {_x getVariable ["derp_revive_downed", false]} && {(_x getVariable ['derp_revive_side', west]) == side player}});
}];
