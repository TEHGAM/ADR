/*
* Author: alganthe
* Initiate dragging animations, when done will call the proper function to actually start the dragging
*
* Arguments:
* 0: Unit doing the dragging <OBJECT>
* 1: Unit being dragged <OBJECT>
*
* Return Value:
* Nothing
*/
params ["_dragger", "_dragged"];

[_dragger] allowGetIn false;

// Reverse dir needed because of the downed animation being reversed itself
[_dragged, ((getDir _dragger) + 180)] remoteExec ["setDir", _dragged];
_dragged setPosASL (getPosASL _dragger vectorAdd (vectorDir _dragger vectorMultiply 1.5));

_dragger playActionNow "grabDrag";
[_dragged, "AinjPpneMrunSnonWnonDb_grab"] call derp_revive_fnc_syncAnim;

[{
    params ["_args", "_idPFH"];
    _args params ["_dragger", "_dragged", "_timeOut"];

    if ((_dragger getVariable ["derp_revive_downed", false]) || {!alive _dragger} || {!alive _dragged} || {derp_missionTime > _timeOut} || {!(_dragger getVariable ["derp_revive_isDragging", false])} || {!(_dragged setVariable ["derp_revive_isDragged", false])}) exitWith {
        _dragger setVariable ["derp_revive_isDragging", false ,true];
        _dragged setVariable ["derp_revive_isDragged", false ,true];
        [_dragged, "acts_injuredlyingrifle02_180"] call derp_revive_fnc_syncAnim;
        [_dragged] call derp_revive_fnc_adjustForTerrain;
        [_dragger, ""] call derp_revive_fnc_syncAnim;
        [_idPFH] call derp_fnc_removePerFrameHandler;
    };

    // unit is ready to start dragging
    if (animationState _dragger in ["amovpercmstpslowwrfldnon_acinpknlmwlkslowwrfldb_2", "amovpercmstpsraswpstdnon_acinpknlmwlksnonwpstdb_2", "amovpercmstpsnonwnondnon_acinpknlmwlksnonwnondb_2", "acinpknlmstpsraswrfldnon", "acinpknlmstpsnonwpstdnon", "acinpknlmstpsnonwnondnon", "acinpknlmwlksraswrfldb", "acinpknlmwlksnonwnondb"]) exitWith {
        [_dragger, _dragged] call derp_revive_fnc_startDragging;
        [_idPFH] call derp_fnc_removePerFrameHandler;
    };
}, 0.2, [_dragger, _dragged, derp_missionTime + 5]] call derp_fnc_addPerFrameHandler;
