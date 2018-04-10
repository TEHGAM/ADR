/*
* Author: alganthe
* Adjust the downed animation for terrain
*
* Arguments:
* 0: Unit to adjust <OBJECT>
*
* Return Value:
* Nothing
*/
params ["_unit"];

if (local _unit) then {
    _unit setVectorDir surfaceNormal position _unit;
    _unit setVectorUp surfaceNormal position _unit;
} else {
    [_unit] remoteExec ["derp_revive_fnc_adjustForTerrain", _unit];
};
