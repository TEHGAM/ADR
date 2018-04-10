/*
* Author: alganthe
* Drop the person from carrying / dragging
*
* Arguments:
* 0: Unit doing the dragging / carrying <OBJECT>
* 1: Unit being dragged / carried <OBJECT>
* 2: State <DRAGGING, CARRYING or VEHICLE>
*
* Return Value:
* Nothing
*/
params ["_dragger", "_dragged", "_state", ["_vehicle", objNull]];

_state = toUpper _state;
if !(_state in ["DRAGGING", "CARRYING", "VEHICLE"]) exitWith {};

switch (_state) do {
    case "DRAGGING": {

        _dragger setVariable ["derp_revive_isDragging", false, true];
        _dragged setVariable ["derp_revive_isDragged", false, true];

        detach _dragged;

        if (alive _dragged && {vehicle _dragged == _dragged}) then {
            [_dragged, "acts_injuredlyingrifle02_180"] call derp_revive_fnc_syncAnim;
            [_dragged] call derp_revive_fnc_adjustForTerrain;
        };

        if (alive _dragger && {!(_dragger getVariable ["derp_revive_downed", false])} && {vehicle _dragger == _dragger}) then {
            _dragger playAction "released";
        };
    };

    case "CARRYING": {

        _dragger setVariable ["derp_revive_isCarrying", false, true];
        _dragged setVariable ["derp_revive_isCarried", false, true];

        detach _dragged;

        if (alive _dragged && {vehicle _dragged == _dragged}) then {
            true remoteExec ["disableUserInput", _dragged];
            [_dragged, "AinjPfalMstpSnonWrflDf_carried_fallwc"] call derp_revive_fnc_syncAnim;

            [{
                params ["_dragged"];
                false remoteExec ["disableUserInput", _dragged];
                [_dragged] call derp_revive_fnc_adjustForTerrain;
            }, [_dragged], 5] call derp_fnc_waitAndExecute;
        };

        if (alive _dragger && {!(_dragger getVariable ["derp_revive_downed", false])} && {vehicle _dragger == _dragger}) then {
            [_dragger, "AcinPercMrunSnonWnonDf_AmovPercMstpSnonWnonDnon"] call derp_revive_fnc_syncAnim;
        };
    };

    case "VEHICLE": {
        detach _dragged;

        _dragger setVariable ["derp_revive_isDragging", false, true];
        _dragged setVariable ["derp_revive_isDragged", false, true];
        _dragger setVariable ["derp_revive_isCarrying", false, true];
        _dragged setVariable ["derp_revive_isCarried", false, true];

        [_dragger, "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] call derp_revive_fnc_syncAnim;

        [_dragged, _vehicle] remoteExec ["moveInCargo", _dragged];
        [{
            (vehicle (_this select 0) != _this select 0)
        },
        {
            [_this select 0, "Die"] remoteExec ["playAction", 0];
        }, [_dragged]] call derp_fnc_waitUntilAndExecute;

    };
};
