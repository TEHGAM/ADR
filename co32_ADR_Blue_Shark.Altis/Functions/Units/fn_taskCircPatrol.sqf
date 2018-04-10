/*
	File: taskPatrol.sqf
	Author: Joris-Jan van 't Land
	Revised by: Ryko, Feb 18, 2016

	Description:
	Create a random patrol of six waypoints around a given position.
	... this one actually goes AROUND the position, not hell knows where

	Parameter(s):
	_this select 0: the group to which to assign the waypoints (Group)
	_this select 1: the position on which to base the patrol (Array)
	_this select 2: the maximum distance between waypoints (Number)
	_this select 3: the minimum distance from central position (Number)
	_this select 4: timeout between waypoints
	_this select 5: default combat mode (string)
	_this select 6: default waypoint speed (string)
	_this select 7: default behaviour (string)
	
	Returns:
	Boolean - success flag
*/

//Validate parameter count
if ((count _this) < 3) exitWith {debugLog "Log: [taskPatrol] Function requires at least 3 parameters!"; false};

params ["_group", "_pos", "_maxDist", "_minDist", "_timeout", "_combatMode", "_speed", "_behaviour"];
private ["_randDist", "_waypoint", "_wp", "_v1", "_v2", "_v3", "_cc", "_newWp"];
_randDist = floor(_maxDist / 10);

if ( isNil "_group" ) exitWith
{	diag_log "ERROR: fn_taskCircPatrol.sqf: No group found"; false };

if ( !isNil "_timeout" ) then
{	_timeout = [floor _timeout/2, _timeout, floor _timeout/2]; };

if ( !isNil "_behaviour" ) then
{	_group setBehaviour _behaviour; }
else
{	_group setBehaviour "SAFE"; };

if ( !isNil "_combatMode" ) then
{	_group setCombatMode _combatMode; }
else
{	_group setCombatMode "GREEN"; };

if ( !isNil "_speed" ) then
{	_group setSpeedMode _speed; }
else
{	_group setSpeedMode "LIMITED"; };

if ( isNil "_minDist" ) then
{	_minDist = 0; };

//Create a string of randomly placed waypoints.
_waypoint = [];

if ( vehicle leader _group == leader _group ) then /*Case groupleader is on foot*/
{	_v1 = _maxDist;
	_v2 = ceil(_maxDist * 0.41);
	_v3 = ceil(_maxDist * 0.83);
	_cc = round(random 2); 

	if ( _cc == 0 ) then
	{	_waypoint set [1, [(_pos select 0)- (_v1), (_pos select 1)]];
		_waypoint set [2, [(_pos select 0)- (_v2), (_pos select 1)+ (_v3)]];
		_waypoint set [3, [(_pos select 0)+ (_v2), (_pos select 1)+ (_v3)]];
		_waypoint set [4, [(_pos select 0)+ (_v1), _pos select 1]];
		_waypoint set [5, [(_pos select 0)+ (_v2), (_pos select 1)- (_v3)]];
		_waypoint set [6, [(_pos select 0)- (_v2), (_pos select 1)- (_v3)]];
	}
	else
	{	_waypoint set [6, [(_pos select 0)- (_v1), _pos select 1]];
		_waypoint set [5, [(_pos select 0)- (_v2), (_pos select 1)+ (_v3)]];
		_waypoint set [4, [(_pos select 0)+ (_v2), (_pos select 1)+ (_v3)]];
		_waypoint set [3, [(_pos select 0)+ (_v1), _pos select 1]];
		_waypoint set [2, [(_pos select 0)+ (_v2), (_pos select 1)- (_v3)]];
		_waypoint set [1, [(_pos select 0)- (_v2), (_pos select 1)- (_v3)]];
	};

	for "_w" from 1 to 6 do
	{	if ( !(surfaceIsWater (_waypoint select _w)) && !((_waypoint select _w) isEqualTo [0,0]) ) then
		{	_wp = _group addWaypoint [(_waypoint select _w), 25];
			_wp setWaypointType "MOVE";
			_wp setWaypointCompletionRadius 30;
			if ( !isNil "_timeout" ) then
			{	_wp setWaypointTimeout _timeout; };
			_wp setWaypointFormation "STAG COLUMN";
		};
	};
}
else /*Case groupleader is in a vehicle*/
{	private ["_newWp", "_wpT", "_wps"];
	_newWp = [];
	_waypointPos = selectBestPlaces [_pos, _maxDist, "1+(2*meadow) - (1*forest) - (1*trees) - (1*houses) - (10*sea)", 25, 80];
	{	_wpT = _x select 0;
		if ( _wpT distance _pos > _minDist ) then
		{	_newWp pushBack _wpT; };
	} forEach _waypointPos;
		
	_waypoint set [0, (getPos vehicle leader _group)]; 
	_wp = _group addWaypoint [(_waypoint select 0), 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 5;
	if ( !isNil "_timeout" ) then
	{	_wp setWaypointTimeout _timeout; };
	
	if ( count _newWp > 5 ) then
	{	_wps = 5; }
	else
	{	_wps = count _newWp; };
	
	for "_w" from 1 to _wps do
	{	private ["_dist", "_testWp"];
		_dist = 0;
		_testWp = _waypoint select (_w-1);
		{	if ( _x distance _testWp > _dist ) then
			{	_dist = _x distance _testWp;
				_wpT = _x;
			};
		} forEach _newWp;
		
		if ( !(surfaceIsWater _wpT) && !(_wpT isEqualTo [0,0]) ) then
		{	_waypoint set [_w, _wpT];
			_newWp = _newWp - [_wpT];
			_wp = _group addWaypoint [_wpT, 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointCompletionRadius 5;
			if ( !isNil "_timeout" ) then
			{	_wp setWaypointTimeout _timeout; };
		};
	};
};

for "_w" from 1 to 6 do
{	if ( !(surfaceIsWater (_waypoint select _w)) && !((_waypoint select _w) isEqualTo [0,0]) ) exitWith
	{	_wp = _group addWaypoint [(_waypoint select _w), 0];};
};
_wp setWaypointType "CYCLE";
_wp setWaypointCompletionRadius 30;

if ( !isNil "_timeout" ) then
{	_wp setWaypointTimeout _timeout; };

true