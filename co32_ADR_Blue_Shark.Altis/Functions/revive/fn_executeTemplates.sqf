/*
    Author: Jiri Wainar
    Rewrote by: alganthe

    Description:
    Execute the defined templates for a specific unit.

    Parameters:
        _this: OBJECT - Unit

    Returns:
    True if successful, false if not.
*/
params [["_unit", objNull]];

if (isNull _unit) exitWith {false};


private _executeTemplates = {
    params ["_unit", "_templates"];

    //execute supported templates
    if ({_x == "MenuPosition"} count _templates > 0) then {if (alive _unit) then {[_unit, nil, nil, nil, true] call bis_fnc_respawnMenuPosition} else {[_unit, nil, nil, nil, true] spawn bis_fnc_respawnMenuPosition}};
    if ({_x == "MenuInventory"} count _templates > 0) then {if (alive _unit) then {[_unit, nil, nil, nil, true] call bis_fnc_respawnMenuInventory} else {[_unit, nil, nil, nil, true] spawn bis_fnc_respawnMenuInventory}};

    //reset respawn time
    setPlayerRespawnTime (missionNamespace getVariable ["bis_selectRespawnTemplate_delay", getMissionConfigValue "respawnDelay"]);
};

//execute side templates only, if they are defined
private _templates = missionNamespace getVariable [format["derp_revive_templates%1",_unit call bis_fnc_objectSide],[]];
_templates = _templates - ["derp_revive"];

if (count _templates > 0) exitWith {[_unit, _templates] call _executeTemplates; true};

//otherwise, execute global templates
if (isNil "derp_revive_templates") then {
    derp_revive_templates = getArray (missionConfigFile >> "respawnTemplates");
};

_templates = derp_revive_templates;
_templates = _templates - ["derp_revive"];
if (count _templates > 0) exitWith {[_unit, _templates] call _executeTemplates; true};

true
