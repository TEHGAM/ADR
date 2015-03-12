/*
Author: Quiksilver
*/

_this addAction ["<t color='#ff1111'>Get Intel</t>","mission\side\actions\recover.sqf",[],21,true,true,"","(cursorTarget distance player) < 5"];
_this addAction ["<t color='#ff1111'>Surrender</t>","mission\side\actions\surrender.sqf",[],21,true,true,"","(cursorTarget distance player) < 25"];
