/*
 Script Made By  MacRae    
 Modded by [KH]Jman
 Tweaked by Quiksilver for the addAction shit
*/
private ["_chair","_unit"];
_chair = _this select 0; 
_unit = _this select 1; 
[[_unit, "Crew"],"QS_fnc_switchMoveMP"] spawn BIS_fnc_MP;
player setVariable ["seated",true];
_unit setPos (getPos _chair); 
_unit setDir ((getDir _chair) - 180); 
standup = _unit addaction [
	"<t color='#0099FF'>Stand Up</t>",
	"scripts\standup.sqf",
	[],
	10,
	true,
	true,
	'',
	'(player getVariable "seated")'
];
_unit setpos [getpos _unit select 0, getpos _unit select 1,((getpos _unit select 2) +1)];


