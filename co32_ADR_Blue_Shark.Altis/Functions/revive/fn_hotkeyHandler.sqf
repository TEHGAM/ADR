/*
* Author: alganthe
* Handles hotkey presses in the downed state
*
* Arguments:
*
* Return Value:
* Nothing
*/
derp_reviveKeyDownID = (findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["", "_key"];

    if (_key == 1 && {alive player}) then {
        createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);

        disableSerialization;

           private _dlg = findDisplay 49;

           for "_index" from 100 to 2000 do {
               (_dlg displayCtrl _index) ctrlEnable false;
           };

           private _ctrl = _dlg displayctrl 103;
           _ctrl ctrlSetEventHandler ["buttonClick","{closeDialog 0}; failMission 'LOSER';"];
           _ctrl ctrlEnable true;
           _ctrl ctrlSetText "ABORT";
           _ctrl ctrlSetTooltip "Abort.";

           _ctrl = _dlg displayctrl ([104, 1010] select isMultiplayer);
           _ctrl ctrlSetEventHandler ["buttonClick", "closeDialog 0; player setDamage 1; "];
           _ctrl ctrlEnable (call {private _config = missionConfigFile >> "respawnButton"; !isNumber _config || {getNumber _config == 1}});
           _ctrl ctrlSetText "RESPAWN";
           _ctrl ctrlSetTooltip "Respawn.";
       };

    if (_key in actionKeys "TeamSwitch" && {teamSwitchEnabled}) then {
        private _acc = accTime;
        teamSwitch;
        setAccTime _acc;
    };

    if (_key in actionKeys "CuratorInterface" && {getAssignedCuratorLogic player in allCurators}) then {
        openCuratorInterface;
    };

    if (_key in actionKeys "ShowMap") then {
        if (visibleMap) then {
            openMap false;
        } else {
            openMap true;
        };
    };

    // Revive
    if (_key == 57 && {player getVariable ["derp_revive_downed", false]}) then {
        if (isNil "derp_revive_keyDown") then {
            [{
                params ["_args", "_idPFH"];
                _args params ["_timeOut"];

                if (isNil "derp_revive_keyDown") then {
                    [_idPFH] call derp_fnc_removePerFrameHandler;
                } else {
                    if (ceil derp_missionTime >= ceil _timeOut + 3) then {
                        player setDamage 1;
                        [_idPFH] call derp_fnc_removePerFrameHandler;
                    } else {
                         titleText ["Respawn in " + str ((ceil _timeOut + 3) - ceil derp_missionTime), "PLAIN", 0.1]; // The use of ceil is to avoid weird numbers
                    };
                };
            }, 1, [derp_missionTime]] call derp_fnc_addPerFrameHandler;
            derp_revive_keyDown = true;
        };
    };

    if (isServer || {serverCommandAvailable "#kick"}) then {
        if (!(_key in (actionKeys "DefaultAction" + actionKeys "Throw")) && {_key in (actionKeys "Chat" + actionKeys "PrevChannel" + actionKeys "NextChannel")}) then {
            _key = 0;
        };
    };

    _key > 0
}];

derp_reviveKeyUpID = (findDisplay 46) displayAddEventHandler ["KeyUp", {
    derp_revive_keyDown = nil;

    if (_key == 57 && {player getVariable ["derp_revive_downed", false]}) then {
    } else {
        true
    };
}];
