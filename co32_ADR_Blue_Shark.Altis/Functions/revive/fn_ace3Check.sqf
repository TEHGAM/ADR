/*
* Author: alganthe
* Checks if ACE3 is loaded
*
* Arguments:
* None
*
* Return Value:
* BOOL
*/
private _returnValue = "";

if !("ace_medical" in activatedAddons) then {
    _returnValue = "derp_revive";
};

_returnValue
