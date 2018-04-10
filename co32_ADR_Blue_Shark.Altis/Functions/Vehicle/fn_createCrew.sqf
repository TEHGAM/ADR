
/*
	File: spawnCrew.sqf
	Author: Joris-Jan van 't Land

	Description:
	Function to fill all crew positions in a vehicle, including turrets.
	In dummy mode no objects are created and the returned array contains only ones.
	In this mode the function can be used to count the actual crew of an existing vehicle or vehicle type.

	Parameter(s):
	_this select 0: the vehicle (Object)
	_this select 1: the crew's group (Group)
	_this select 2: Faction from units.hpp

	Returns:
	Array of Objects or Scalars - newly created crew or crew count
*/

//Validate parameter count
if ((count _this) < 2) exitWith {debugLog "Log: [spawnCrew] Function requires at least 2 parameters!"; []};

params ["_vehicle", "_grp","_factionDefine"];

//Validate parameters
if ((typeName _vehicle) != (typeName objNull)) exitWith {debugLog "Log: [spawnCrew] Vehicle (0) must be an Object!"; []};
if ((typeName _grp) != (typeName grpNull)) exitWith {debugLog "Log: [spawnCrew] Crew group (1) must be a Group!"; []};
if ((typeName _factionDefine) != (typeName "")) exitWith {debugLog "Log: [spawnCrew] Crew type (4) must be a String!"; []};

_type = typeOf _vehicle;

_entry = configFile >> "CfgVehicles" >> _type;
_crew = [];

private ["_hasDriver"];
_hasDriver = getNumber (_entry >> "hasDriver");

// Get Faction approprate units
_crewTypeArray = (missionconfigfile >> "unitList" >> _factionDefine >> "units") call BIS_fnc_getCfgData;

//Spawn a driver if needed
if ((_hasDriver == 1) && (isNull (driver _vehicle))) then
{
        _crewType = _crewTypeArray call BIS_fnc_selectRandom;
		_unit = _grp createUnit [_crewType, position _vehicle, [], 0, "NONE"];
		_crew = _crew + [_unit];

		_unit moveInDriver _vehicle;
};

//Search through all turrets and spawn crew for these as well.
_turrets = [_entry >> "turrets"] call BIS_fnc_returnVehicleTurrets;

//All turrets were found, now spawn crew for them
_funcSpawnTurrets =
{
    _crewType = _crewTypeArray call BIS_fnc_selectRandom;
	private ["_turrets", "_path"];
	_turrets = _this select 0;
	_path = _this select 1;

	private ["_i"];
	_i = 0;
	while {_i < (count _turrets)} do
	{
		private ["_turretIndex", "_thisTurret"];
		_turretIndex = _turrets select _i;
		_thisTurret = _path + [_turretIndex];

			if (isNull (_vehicle turretUnit _thisTurret)) then
			{
				//Spawn unit into this turret, if empty.
				_unit = _grp createUnit [_crewType, position _vehicle, [], 0, "NONE"];
				_crew = _crew + [_unit];

				_unit moveInTurret [_vehicle, _thisTurret];
			};

		//Spawn units into subturrets.
		[_turrets select (_i + 1), _thisTurret] call _funcSpawnTurrets;

		_i = _i + 2;
	};
};

[_turrets, []] call _funcSpawnTurrets;
[_vehicle,"LIEUTENANT"] call bis_fnc_setRank;

_crew
