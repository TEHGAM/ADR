/*
* Author: alganthe
* Handles the bleeding timer
*
* Arguments:
* Unit the timer follows, should always be the local player <OBJECT>
*
* Return Value:
* Nothing
*/
params ["_unit"];

derp_revive_bleedOutTimer = 0;

[{
    params ["_args", "_pfhID"];
    _args params ["_unit", "_timerLength"];

    // Check if unit is still downed
    if (!alive _unit || {!(_unit getVariable ["derp_revive_downed", false])}) then {

        derp_revive_bleedOutTimer = nil; // For the next death
        _pfhID call derp_fnc_removePerFrameHandler;
    };

    // Check if timer reached 0
    if (derp_revive_bleedOutTimer >= _timerLength) then {

        derp_revive_bleedOutTimer = nil; // For the next death
        _unit setDamage 1;
        _pfhID call derp_fnc_removePerFrameHandler;

    } else {
        // draw timer
        99 cutText [format ["Timer: %1 \n Hold space to respawn", _timerLength - derp_revive_bleedOutTimer], "PLAIN DOWN", 0.1];
        derp_revive_bleedOutTimer = derp_revive_bleedOutTimer + 1;
    };
}, 1, [_unit, (getMissionConfigValue ["derp_revive_bleedOutTimer", 300])]] call derp_fnc_addPerFrameHandler;
