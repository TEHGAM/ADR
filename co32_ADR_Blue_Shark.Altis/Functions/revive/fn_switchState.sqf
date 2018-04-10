/*
* Author: alganthe
* Handles the revive states
*
* Arguments:
* 0: Unit to switch state <OBJECT>
* 1: State <ALIVE, DOWNED, REVIVED>
*
* Return Value:
* Nothing
*/
params ["_unit", "_state"];

if (isNull _unit) exitWith {};

_state = toUpper _state;
if !(_state in ["ALIVE", "DOWNED", "REVIVED"]) exitWith {};

switch (_state) do {
    case "DOWNED": {
        // Disable player's action menu
        if (isPlayer _unit) then {{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "Action", "NextAction"];};

        // Save the side before using setCaptive.
        _unit setVariable ["derp_revive_side", side _unit, true];
        _unit setCaptive true;

        [{
            params ["_unit"];

            _unit setVariable ["derp_revive_downed", true, true];
            _unit setVariable ["derp_revive_loadout", getUnitLoadout _unit];
            derp_revive_actionID = (_unit addAction ["", {}, "", 0, false, true, "DefaultAction"]);

            [_unit] call derp_revive_fnc_reviveTimer;
            call derp_revive_fnc_hotkeyHandler;
            call derp_revive_fnc_uiElements;

            if (vehicle _unit == _unit) then {
                _unit setUnconscious false;
                [_unit, "acts_injuredlyingrifle02_180"] call derp_revive_fnc_syncAnim;

                [_unit] call derp_revive_fnc_adjustForTerrain;

                call derp_revive_fnc_heartBeatPFH;

            } else {
                [_unit, "Die"] remoteExec ["playAction", 0];
            };

            [_unit, true] call derp_revive_fnc_animChanged;

            //fade in
            _unit switchCamera "external";
            cutText ["","BLACK IN",1];

            _unit allowDamage true;

        }, [_unit], 2] call derp_fnc_waitAndExecute;
    };

    case "ALIVE": {
        _unit setVariable ["derp_revive_downed", false, true];

        // Enable player's action menu
        if (isPlayer _unit) then {
			{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
			inGameUISetEventHandler ["Action", "
				if ( toLower (_this select 4) find 'arsenal' > -1 ) then{
					_player = _this select 1;
					[_player]spawn {
						waitUntil { sleep 0.1; isNull ( uiNamespace getVariable 'RSCDisplayArsenal' ) };
						[[], 'scripts\arsenal\cleanInventory.sqf'] remoteExec ['execVM', _this select 0, false];
					};
				};
				false
			"]; 
		};

        _unit setVariable ["derp_revive_downed", false, true];

        // Remove revive EHs and effects
        if !(isNil "derp_reviveKeyDownID") then {(findDisplay 46) displayRemoveEventHandler ["KeyDown", derp_reviveKeyDownID]};
        if !(isNil "derp_reviveKeyUpID") then {(findDisplay 46) displayRemoveEventHandler ["KeyUp", derp_reviveKeyUpID]};
        if !(isNil "derp_revive_animChangedID") then {_unit removeEventHandler ["AnimChanged",derp_revive_animChangedID]};
        if !(isNil "derp_revive_drawIcon3DID") then {removeMissionEventHandler ["Draw3D", derp_revive_drawIcon3DID]};
        if !(isNil "derp_revive_actionID") then {_unit removeAction derp_revive_actionID};

        if !(isNil "derp_revive_ppColor") then {
            {_x ppEffectEnable false} forEach [derp_revive_ppColor, derp_revive_ppVig, derp_revive_ppBlur];
        };

        showHUD [true, true, true, true, false, true, true, true];

        _unit setCaptive false;
        remoteExec ["", (str _unit + "animChangedJIPID")];
    };

    case "REVIVED": {
        _unit setVariable ["derp_revive_downed", false, true];

        // Enable player's action menu
        if (isPlayer _unit) then {
			{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
			inGameUISetEventHandler ["Action", "
				if ( toLower (_this select 4) find 'arsenal' > -1 ) then{
					_player = _this select 1;
					[_player]spawn {
						waitUntil { sleep 0.1; isNull ( uiNamespace getVariable 'RSCDisplayArsenal' ) };
						[[], 'scripts\arsenal\cleanInventory.sqf'] remoteExec ['execVM', _this select 0, false];
					};
				};
				false
			"]; 
		};

        // Remove revive EHs
        if !(isNil "derp_reviveKeyDownID") then {(findDisplay 46) displayRemoveEventHandler ["KeyDown", derp_reviveKeyDownID]};
        if !(isNil "derp_reviveKeyUpID") then {(findDisplay 46) displayRemoveEventHandler ["KeyUp", derp_reviveKeyUpID]};
        if !(isNil "derp_revive_animChangedID") then {_unit removeEventHandler ["AnimChanged",derp_revive_animChangedID]};
        if !(isNil "derp_revive_drawIcon3DID") then {removeMissionEventHandler ["Draw3D", derp_revive_drawIcon3DID]};
        if !(isNil "derp_revive_actionID") then {_unit removeAction derp_revive_actionID};

        if !(isNil "derp_revive_ppColor") then {
            {_x ppEffectEnable false} forEach [derp_revive_ppColor, derp_revive_ppVig, derp_revive_ppBlur];
        };

        showHUD [true, true, true, true, false, true, true, true];

        _unit setCaptive false;

        [_unit, "amovppnemstpsnonwnondnon"] call derp_revive_fnc_syncAnim;
    };
};
