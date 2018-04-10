/*
* Author: alganthe
* Add the proper actions on unit init, those use cursorObject and are added to the player, no need to add them back after death
*
* Arguments:
* 0: Unit the actions are added to <OBJECT>
*
* Return Value:
* Nothing
*/
params ["_unit"];

private _whoCanRevive = "";
if (getMissionConfigValue ["derp_revive_everyoneCanRevive", 0] == 0) then {
    _whoCanRevive = "{_this getUnitTrait 'medic'} &&";
};

private _itemUsed = "{('FirstAidKit' in items _this) || {'FirstAidKit' in items cursorObject}} &&";

if (getMissionConfigValue ["derp_revive_reviveItem", 0] == 1) then {
    _itemUsed = "{'Medikit' in items _this} &&";
};

// Reviving
_unit addAction [
    "<t color='#ff0000'> Revive </t>",
    {
        params ["", "_caller", "", "_args"];
        _caller playAction "medicStart";
        _caller setVariable ["derp_revive_reviving", true];

        [{
            params ["_args", "_pfhID"];
            _args params ["_startingTIme", "_unit", "_target"];

            if !((_caller distance _target < 5) && {(alive _caller) && {alive _target}} && {_caller getVariable ["derp_revive_reviving", false]} && {_target getVariable ['derp_revive_downed', false]} && {vehicle _target == _target} && {!(_target getVariable ['derp_revive_isDragged', false])} && {!(_target getVariable ['derp_revive_isCarried', false])} && {!(_caller getVariable ['derp_revive_isDragging', false])} && {!(_caller getVariable ['derp_revive_isCarrying', false])}) then {
                _caller playAction "medicStop";
                _unit setVariable ["derp_revive_reviving", false];
                _pfhID call derp_fnc_removePerFrameHandler;

            };
            
            if (_startingTIme + 6 <= time) then {
                if (getMissionConfigValue ["derp_revive_removeFAKOnUse", 1] == 1 && {getMissionConfigValue ["derp_revive_reviveItem", 0] == 0}) then {

                    if ('FirstAidKit' in items _unit) then {
                        _unit removeItem "FirstAidKit";

                    } else {
                        _target removeItem "FirstAidKit";
                    };

                    [_target, "REVIVED"] remoteExecCall ["derp_revive_fnc_switchState", _target];

                    if (group _target isEqualTo group _unit) then {
                        [_unit, 2] remoteExec ["addScore", 2];

                    } else {
                        [_unit, 1] remoteExec ["addScore", 2];
                    };

                    _unit playAction "medicStop";
                     _unit setVariable ["derp_revive_reviving", false];
                    _pfhID call derp_fnc_removePerFrameHandler;
                };
            };
        }, 1, [time, _caller, cursorObject]] call derp_fnc_addPerFrameHandler;
    },
    [],
    10,
    true,
    true,
    "",
    "(_this distance cursorObject < 5) && {!(_this getVariable ['derp_revive_reviving', false])} && {cursorObject getVariable ['derp_revive_downed', false]} && {(cursorObject getVariable ['derp_revive_side', west]) == side _this} && {vehicle _this == _this} && {vehicle cursorObject == cursorObject} &&" + _whoCanRevive + _itemUsed + "{!(cursorObject getVariable ['derp_revive_isDragged', false])} && {!(cursorObject getVariable ['derp_revive_isCarried', false])} && {!(_this getVariable ['derp_revive_isDragging', false])} && {!(_this getVariable ['derp_revive_isCarrying', false])}"
];

// Stop reviving
_unit addAction [
    "<t color='#ff0000'> Stop reviving </t>",
    {
        params ["", "_caller", "", "_args"];
        _caller setVariable ["derp_revive_reviving", false];
        _caller playAction "medicStop";
        
    },
    [],
    10,
    true,
    true,
    "",
    "(_this getVariable ['derp_revive_reviving', false])"
];

// Dragging
_unit addAction [
    "<t color='#DEB887'> Drag </t>",
    {
        params ["", "_caller", "", "_args"];
        _caller setVariable ["derp_revive_isDragging", true ,true];
        cursorObject setVariable ["derp_revive_isDragged", true ,true];
        [_caller, cursorObject] call derp_revive_fnc_dragging;
    },
    [],
    10,
    true,
    true,
    "",
    "(_this distance cursorObject < 5) && {!(_this getVariable ['derp_revive_reviving', false])} && {cursorObject getVariable ['derp_revive_downed', false]} && {(cursorObject getVariable ['derp_revive_side', west]) == side _this} && {vehicle _this == _this} && {vehicle cursorObject == cursorObject} && {!(cursorObject getVariable ['derp_revive_isDragged', false])} && {!(_this getVariable ['derp_revive_isDragging', false])} && {!(_this getVariable ['derp_revive_isCarrying', false])} && {!(cursorObject getVariable ['derp_revive_isCarried', false])}"
];

// Carrying
_unit addAction [
    "<t color='#DEB887'> Carry </t>",
    {
        params ["", "_caller", "", "_args"];
        _caller setVariable ["derp_revive_isCarrying", true ,true];
        cursorObject setVariable ["derp_revive_isCarried", true ,true];
        [_caller, cursorObject] call derp_revive_fnc_carrying;
    },
    [],
    10,
    true,
    true,
    "",
    "(_this distance cursorObject < 5) && {!(_this getVariable ['derp_revive_reviving', false])} && {cursorObject getVariable ['derp_revive_downed', false]} && {(cursorObject getVariable ['derp_revive_side', west]) == side _this} && {isNull objectParent _this} && {vehicle cursorObject == cursorObject} && {!(_this getVariable ['derp_revive_isDragging', false])} && {!(_this getVariable ['derp_revive_isCarrying', false])} && {!(cursorObject getVariable ['derp_revive_isDragged', false])} && {!(cursorObject getVariable ['derp_revive_isCarried', false])}"
];

// Stop dragging
_unit addAction [
    "<t color='#DEB887'> Stop dragging </t>",
    {
        params ["", "_caller", "", "_args"];
        {
            detach _x;
        } foreach ((attachedObjects _caller) select {isNull _x});

        private _dragged = ((attachedObjects _caller) select {_x isKindOf "CAManBase"});
        if (_dragged isEqualTo []) then {
            _caller setVariable ["derp_revive_isDragging", false ,true];
        } else {
            [_caller, _dragged select 0, "DRAGGING"] call derp_revive_fnc_dropPerson;
        };
    },
    [],
    10,
    true,
    true,
    "",
    "(_this getVariable ['derp_revive_isDragging', false])"
];

// Stop carrying
_unit addAction [
    "<t color='#DEB887'> Stop carrying </t>",
    {
        params ["", "_caller", "", "_args"];
        {
            detach _x;
        } foreach ((attachedObjects _caller) select {isNull _x});

        private _dragged = ((attachedObjects _caller) select {_x isKindOf "CAManBase"});
        if (_dragged isEqualTo []) then {
            _caller setVariable ["derp_revive_isCarrying", false ,true];
        } else {
            [_caller, _dragged select 0, "CARRYING"] call derp_revive_fnc_dropPerson;
        };

    },
    [],
    10,
    true,
    true,
    "",
    "(_this getVariable ['derp_revive_isCarrying', false])"
];

// Put in
_unit addAction [
    "<t color='#DEB887'> Put injured in vehicle </t>",
    {
        params ["", "_caller", "", "_args"];
        {
            detach _x;
        } foreach ((attachedObjects _caller) select {isNull _x});

        private _dragged = ((attachedObjects _caller) select {_x isKindOf "CAManBase"}) select 0;
        if (_dragged isEqualTo []) then {
            _caller setVariable ["derp_revive_isDragging", false ,true];
            _caller setVariable ["derp_revive_isCarrying", false ,true];
        } else {
            [_caller, _dragged, "VEHICLE", cursorObject] call derp_revive_fnc_dropPerson;
        };

    },
    [],
    10,
    true,
    true,
    "",
    "(_this distance cursorObject < 5) && {!(_this getVariable ['derp_revive_reviving', false])} && {(_this getVariable ['derp_revive_isCarrying', false]) || {_this getVariable ['derp_revive_isDragging', false]}} && {!(((attachedObjects _this) select {_x isKindOf 'CAManBase'}) isEqualTo [])} && {(cursorObject emptyPositions 'cargo' > 0)} "
];

// Pull out
_unit addAction [
    "<t color='#DEB887'> Pull injured from vehicle </t>",
    {
        params ["", "_caller", "", "_args"];

        private _injured = ((crew cursorObject) select {(_x getVariable ['derp_revive_downed', false])}) select 0;
        moveOut _injured;
    },
    [],
    10,
    true,
    true,
    "",
    "(_this distance cursorObject < 5) && {!(_this getVariable ['derp_revive_reviving', false])} && {!(_this getVariable ['derp_revive_isCarrying', false]) || {!(_this getVariable ['derp_revive_isDragging', false])}} && {!(cursorObject isKindof 'CAManBase')} && {{(_x getVariable ['derp_revive_downed', false]) && {(_x getVariable ['derp_revive_side', west]) == side _this}} count (crew cursorObject) > 0}"
];
