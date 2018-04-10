/*
* Author: alganthe
* Sync an animation across all clients
*
* Arguments:
* 0: Unit on which the action is going to be played <OBJECT>
* 1: Animation to be played <STRING>
*
* Return Value:
* Nothing
*/
params ["_unit", "_animation"];

// Try playMoveNow
if (_unit == vehicle _unit) then {
    _unit playMoveNow _animation;
};

// Didn't worked, remoteExec switchMove then
if (animationState _unit != _animation) then {
    // Execute on all machines. SwitchMove has local effects.
    [_unit, _animation] remoteExec ["switchMove", 0];
};
