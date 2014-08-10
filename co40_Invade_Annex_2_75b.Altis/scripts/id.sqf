/*
///////////////////////////
    ARMA 3 Identification script
    Author: Cuel
	Updated: Vadim Shchemelinin aka badger
    Created: 2013-04-05
    Version: 0.1
    init.sqf: [] execVM "id.sqf";
///////////////////////////
*/

if (isDedicated) exitWith {};
if (isNil "CUL_Show_ID") then {CUL_Show_ID = true};
if (isNil "CUL_Show_ID_range") then {CUL_Show_ID_range = 25};
private ["_str","_ct"];

waituntil {!isNull player};
while{CUL_Show_ID}do
{
    waitUntil {sleep 0.1; alive player};
    if (!isNull cursorTarget) then
    {
        _ct = cursortarget;
        if (player distance _ct < CUL_Show_ID_range && (side player == side _ct) && _ct != player) then
        {
                if (vehicle _ct != _ct) then
                {
                    switch (true) do
                    {
                            case (!isNull (commander vehicle _ct)): {_ct = commander vehicle _ct};       
                            case (!isNull (driver vehicle _ct)): {_ct = driver vehicle _ct};
                            case (!isNull (gunner vehicle _ct)): {_ct = gunner vehicle _ct};
                    };       
                };
                if (name _ct != "Error: No unit") then
                {
                    _color = '#23CD26';
					if (group player == group _ct) then {
						_color = switch (assignedTeam _ct) do {
							case "MAIN": {"#FFFFFF"};
							case "RED": {"#FFAAAA"};
							case "BLUE": {"#AAAAFF"};
							case "GREEN": {"#AAFFAA"};
							case "YELLOW": {"#FFFFAA"};
							default {"#FFFFFF"}
						};
					};
					_str =  "<t font='PuristaMedium' size='0.5' shadow='1' color='" + _color + "'>" + format['%1',name _ct] +  "</t>";
                    [_str,0,0.4,0.3,0,0,6] spawn BIS_fnc_dynamicText;
                };
        };       
    };
    sleep 0.2;
};