/* ----------------------------------------------------------------------------
Function: derp_fnc_directCall
Description:
    Executes a piece of code in unscheduled environment.
Parameters:
    _code      - Code to execute <CODE>
    _arguments - Parameters to call the code with. (optional) <ANY>
Returns:
    _return - Return value of the function <ANY>
Examples:
    (begin example)
        0 spawn { {systemChat str canSuspend} call derp_fnc_directCall; };
        -> false
    (end)
Author:
    commy2
---------------------------------------------------------------------------- */
params [["_derp_code", {}, [{}]], ["_derp_arguments", []]];

private "_derp_return";

isNil {
    _derp_return = _derp_arguments call _derp_code;
};

if (!isNil "_derp_return") then {_derp_return};
