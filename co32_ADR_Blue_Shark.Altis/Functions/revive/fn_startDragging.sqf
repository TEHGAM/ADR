/*
* Author: alganthe
* Actually start the dragging
*
* Arguments:
* 0: Unit doing the dragging <OBJECT>
* 1: Unit being dragged <OBJECT>
*
* Return Value:
* Nothing
*/
params ["_dragger", "_dragged"];

_dragged setPosASL (getPosASL _dragger vectorAdd (vectorDir _dragger vectorMultiply 1.5));

_dragged attachTo [_dragger, [0, 1, 0]];
[_dragged, 180] remoteExec ["setDir", _dragged];
[_dragged, "AinjPpneMrunSnonWnonDb_still"] call derp_revive_fnc_syncAnim;

[{
    params ["_args", "_idPFH"];
    _args params ["_dragger","_dragged", "_startTime"];

    if !(_dragged getVariable "derp_revive_isDragged") then {
        [_idPFH] call derp_fnc_removePerFrameHandler;
    };

    if (!alive _dragged || {!alive _dragger}|| {_dragger getVariable ["derp_revive_downed", false]} || {vehicle _dragger != _dragger} || {_dragger distance _dragged > 10}) then {
        if ((_dragger distance _dragged > 10) && {(derp_missionTime - _startTime) < 1}) exitWith {};
        [_dragger, _dragged, "DRAGGING"] call derp_revive_fnc_dropPerson;
        [_idPFH] call derp_fnc_removePerFrameHandler;
    };
} , 0.5, [_dragger, _dragged, derp_missionTime]] call derp_fnc_addPerFrameHandler;
