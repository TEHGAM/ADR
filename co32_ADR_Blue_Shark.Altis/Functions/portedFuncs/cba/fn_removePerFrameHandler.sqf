/* ----------------------------------------------------------------------------
Function: CBA_fnc_removePerFrameHandler
Description:
    Remove a handler that you have added using CBA_fnc_addPerFrameHandler.
Parameters:
    _handle - The function handle you wish to remove. <NUMBER>
Returns:
    None
Examples:
    (begin example)
        _handle = [{player sideChat format["every frame! _this: %1", _this];}, 0, ["some","params",1,2,3]] call CBA_fnc_addPerFrameHandler;
        sleep 10;
        [_handle] call CBA_fnc_removePerFrameHandler;
    (end)
Author:
    Nou & Jaynus, donated from ACRE project code for use by the community; commy2
---------------------------------------------------------------------------- */
params [["_handle", -1, [0]]];

if (_handle < 0 || {_handle >= count derp_PFHhandles}) exitWith {};

[{
    params ["_handle"];

    derp_perFrameHandlerArray deleteAt (derp_PFHhandles select _handle);
    derp_PFHhandles set [_handle, nil];

    {
        _x params ["", "", "", "", "", "_handle"];
        derp_PFHhandles set [_handle, _forEachIndex];
    } forEach derp_perFrameHandlerArray;
}, _handle] call derp_fnc_directCall;

nil
