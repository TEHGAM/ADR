/*
* Author: alganthe
* Actually start the carrying
*
* Arguments:
* 0: Unit doing the carrying <OBJECT>
* 1: Unit being carried <OBJECT>
*
* Return Value:
* Nothing
*/
params ["_dragger", "_dragged"];

[_dragger, "AcinPercMstpSnonWnonDnon"] call derp_revive_fnc_syncAnim;
[_dragged, "AinjPfalMstpSnonWrflDnon_carried_still"] call derp_revive_fnc_syncAnim;

 _dragged attachTo [_dragger, [0.4, 0, -1.2], "LeftShoulder"];

[{
    params ["_args", "_idPFH"];
    _args params ["_dragger","_dragged", "_startTime"];

    if !(_dragged getVariable "derp_revive_isCarried") then {
        [_idPFH] call derp_fnc_removePerFrameHandler;
    };

    if (!alive _dragged || {!alive _dragger} || {_dragger getVariable ["derp_revive_downed", false]} || {vehicle _dragger != _dragger} || {_dragger distance _dragged > 10}) then {
        if ((_dragger distance _dragged > 10) && {(derp_missionTime - _startTime) < 1}) exitWith {};
        [_dragger, _dragged, "CARRYING"] call derp_revive_fnc_dropPerson;
        [_idPFH] call derp_fnc_removePerFrameHandler;
    };
} , 0.5, [_dragger, _dragged, derp_missionTime]] call derp_fnc_addPerFrameHandler;
