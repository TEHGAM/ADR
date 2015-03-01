/*
	File: taskAttack.sqf
	Author: Joris-Jan van 't Land   (tweaked by Quiksilver for I&A)

	Description:
	Group will attack the position.

	Parameter(s):
	_this select 0: group (Group)
	_this select 1: attack position (Array)
	
	Returns:
	Boolean - success flag
*/

private ["_grp", "_pos"];

_grp = _this select 0;
_pos = _this select 1;

//Create the waypoint.

private ["_wp"];
_wp = _grp addWaypoint [_pos, 0];
_wp setWaypointType "SAD";
_wp setWaypointSpeed "FULL";
_wp setWaypointCompletionRadius 100;

//Set group properties.

if ((random 1) >= 0.45) then {
	[_grp,0] setWaypointFormation "LINE";
} else {
	[_grp,0] setWaypointFormation "WEDGE";
};

if ((random 1) >= 0.25) then {
	{
		if ((random 1) >= 0.5) then {
			_x setUnitPos "UP";
		};
	} count (units _grp);
};

{_x enableFatigue FALSE;} count (units _grp);
_grp enableAttack TRUE;
_grp setBehaviour "COMBAT";
_grp setSpeedMode "FULL";
_grp setCombatMode "RED";

true;