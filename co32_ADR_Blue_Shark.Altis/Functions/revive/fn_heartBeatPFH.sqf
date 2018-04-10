
[{
    params ["_args", "_pfhID"];

    if (!alive player || {!(player getVariable ["derp_revive_downed", false])}) then {
        _pfhID call derp_fnc_removePerFrameHandler;
    } else {
        playSound (selectRandom ["derp_heartBeat1", "derp_heartBeat2", "derp_heartBeat3", "derp_heartBeat4"]);
    };
}, 2, []] call derp_fnc_addPerFrameHandler;
