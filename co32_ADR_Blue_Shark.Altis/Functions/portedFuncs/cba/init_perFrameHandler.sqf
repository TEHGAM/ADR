#define DELAY_MONITOR_THRESHOLD 1 // Frames

derp_perFrameHandlerArray = [];
derp_lastTickTime = diag_tickTime;

derp_waitAndExecArray = [];
derp_waitAndExecArrayIsSorted = false;
derp_nextFrameNo = diag_frameno + 1;
// PostInit can be 2 frames after preInit, need to manually set nextFrameNo, so new items get added to buffer B while processing A for the first time:
derp_nextFrameBufferA = [[[], {derp_nextFrameNo = diag_frameno;}]];
derp_nextFrameBufferB = [];
derp_waitUntilAndExecArray = [];

// per frame handler system
derp_fnc_onFrame = {
    private _tickTime = diag_tickTime;
    call derp_fnc_missionTimePFH;

    // Execute per frame handlers
    {
        _x params ["_function", "_delay", "_delta", "", "_args", "_handle"];

        if (diag_tickTime > _delta) then {
            _x set [2, _delta + _delay];
            [_args, _handle] call _function;
            false
        };
    } count derp_perFrameHandlerArray;


    // Execute wait and execute functions
    // Sort the queue if necessary
    if (!derp_waitAndExecArrayIsSorted) then {
        derp_waitAndExecArray sort true;
        derp_waitAndExecArrayIsSorted = true;
    };
    private _delete = false;
    {
        if (_x select 0 > derp_missionTime) exitWith {};

        (_x select 2) call (_x select 1);

        // Mark the element for deletion so it's not executed ever again
        derp_waitAndExecArray set [_forEachIndex, objNull];
        _delete = true;
    } forEach derp_waitAndExecArray;
    if (_delete) then {
        derp_waitAndExecArray = derp_waitAndExecArray - [objNull];
    };


    // Execute the exec next frame functions
    {
        (_x select 0) call (_x select 1);
        false
    } count derp_nextFrameBufferA;
    // Swap double-buffer:
    derp_nextFrameBufferA = derp_nextFrameBufferB;
    derp_nextFrameBufferB = [];
    derp_nextFrameNo = diag_frameno + 1;


    // Execute the waitUntilAndExec functions:
    _delete = false;
    {
        // if condition is satisfied call statement
        if ((_x select 2) call (_x select 0)) then {
            (_x select 2) call (_x select 1);

            // Mark the element for deletion so it's not executed ever again
            derp_waitUntilAndExecArray set [_forEachIndex, objNull];
            _delete = true;
        };
    } forEach derp_waitUntilAndExecArray;
    if (_delete) then {
        derp_waitUntilAndExecArray = derp_waitUntilAndExecArray - [objNull];
    };
};

// fix for save games. subtract last tickTime from ETA of all PFHs after mission was loaded
addMissionEventHandler ["Loaded", {
    private _tickTime = diag_tickTime;

    {
        _x set [2, (_x select 2) - derp_lastTickTime + _tickTime];
    } forEach derp_perFrameHandlerArray;

    derp_lastTickTime = _tickTime;
}];

derp_missionTime = 0;
derp_lastTime = time;

// increase derp_missionTime variable every frame
if (isMultiplayer) then {
    // multiplayer - no accTime in MP
    if (isServer) then {
        // multiplayer server
        derp_fnc_missionTimePFH = {
            if (time != derp_lastTime) then {
                derp_missionTime = derp_missionTime + (_tickTime - derp_lastTickTime);
                derp_lastTime = time; // used to detect paused game
            };

            derp_lastTickTime = _tickTime;
        };

        addMissionEventHandler ["PlayerConnected", {
            (_this select 4) publicVariableClient "derp_missionTime";
        }];
    } else {
        derp_missionTime = -1;

        // multiplayer client
        0 spawn {
            "derp_missionTime" addPublicVariableEventHandler {
                derp_missionTime = _this select 1;

                derp_lastTickTime = diag_tickTime; // prevent time skip on clients

                derp_fnc_missionTimePFH = {
                    if (time != derp_lastTime) then {
                        derp_missionTime = derp_missionTime + (_tickTime - derp_lastTickTime);
                        derp_lastTime = time; // used to detect paused game
                    };

                    derp_lastTickTime = _tickTime;
                };
            };
        };
    };
} else {
    // single player
    derp_fnc_missionTimePFH = {
        if (time != derp_lastTime) then {
            derp_missionTime = derp_missionTime + (_tickTime - derp_lastTickTime) * accTime;
            derp_lastTime = time; // used to detect paused game
        };

        derp_lastTickTime = _tickTime;
    };
};
