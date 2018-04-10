/*
* Author: alganthe
* Handles UI elements such as medic icons on medics and PP effects
*
* Arguments:
*
* Return Value:
* Nothing
*/
derp_revive_drawIcon3DID = addMissionEventHandler ["Draw3D", {
    {
        drawIcon3D [
            "\A3\ui_f\data\igui\cfg\actions\heal_ca.paa",
            [0.1, 0.47, 0.83, 1],
            visiblePosition _x,
            1,
            1,
            0,
            format ["%1 meters away", ceil (player distance2D _x)],
            2,
            0.04
        ];
    } foreach ((player nearEntities ["Man", 1000]) select {side _x == playerSide && {_x getUnitTrait "Medic"}});
}];

if (isNil "derp_revive_ppColor") then {
    derp_revive_ppColor = ppEffectCreate ["ColorCorrections", 1632]
};
if (isNil "derp_revive_ppVig") then {
    derp_revive_ppVig = ppEffectCreate ["ColorCorrections", 1633]
};
if (isNil "derp_revive_ppBlur") then {
    derp_revive_ppBlur = ppEffectCreate ["DynamicBlur", 525]
};

// Start effects
derp_revive_ppColor ppEffectAdjust [1,1,0.15,[0.3,0.3,0.3,0],[0.3,0.3,0.3,0.3],[1,1,1,1]];
derp_revive_ppVig ppEffectAdjust [1,1,0,[0.15,0,0,1],[1.0,0.5,0.5,1],[0.587,0.199,0.114,0],[1,1,0,0,0,0.2,1]];
derp_revive_ppBlur ppEffectAdjust [0];
{
    _x ppEffectCommit 0; _x ppEffectEnable true; _x ppEffectForceInNVG true
} forEach [derp_revive_ppColor, derp_revive_ppVig, derp_revive_ppBlur];

// PFH for the progression of the revive effects
[{
    params ["_args", "_pfhID"];
    _args params ["_timer"];

    //grab blood level
    if (player getVariable ["derp_revive_downed", false] && {alive player}) then {
        private _blood = (_timer - derp_revive_bleedOutTimer) / _timer;

        //calculate desaturation
        private _bright = 0.2 + (0.1 * _blood);
        derp_revive_ppColor ppEffectAdjust [1,1, 0.15 / _blood,[0.3,0.3,0.3,0],[_bright,_bright,_bright,_bright],[1,1,1,1]];

        //calculate intensity of vignette
        private _intense = 0.6 + (0.4 * _blood);
        derp_revive_ppVig ppEffectAdjust [1,1,0,[0.15,0,0,1],[1.0,0.5,0.5,1],[0.587,0.199,0.114,0],[_intense,_intense,0,0,0,0.2,1]];

        //calculate intensity of blur
        private _blur = 0.7 * (1 - _blood);
        derp_revive_ppBlur ppEffectAdjust [_blur];

        //smoothly transition
        {_x ppEffectCommit 1} forEach [derp_revive_ppColor, derp_revive_ppVig, derp_revive_ppBlur];
    } else {
        _pfhID call derp_fnc_removePerFrameHandler;
    };
}, 1, [(getMissionConfigValue ["derp_revive_bleedOutTimer", 300])]] call derp_fnc_addPerFrameHandler;

showHUD [true, false, false, false, false, false, false, true];
