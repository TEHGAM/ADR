/*
author: stanhope
Credit: based off of Quicksilvers respawn script
Description: Monitors if a vehicle is still alive or not.  NOT a good respawn script!

Last modified: 24/2/17 by stanhope
modified: inital rewrite
*/
if (!isServer) exitWith { /* GO AWAY PLAYER */ };

// --------- params
params ["_vehicle", "_delay", "_setup", "_init", "_base"];

private _vehicleType = typeOf _vehicle;
private _spawnDir = getDir _vehicle;
private _spawnPos = getPosWorld _vehicle;

_distanceFromSpawn = 50;

// ---------- init script
[_vehicle] call _init;
private _respawn = false;

sleep (random 30);

// ----------- Monitor loop
while { true } do {

	//==== Vehicle destroyed ====
	if (!alive _vehicle) then {
		sleep _delay;
		
		//Delete the old wreck
		if (!isNull _vehicle) then {deleteVehicle _vehicle;};
		sleep 0.1;
		
		if (_base in controlledZones) then {
			_respawn = true;
		} else {
			_respawn = false;
		};
	};
	sleep 5;
	
	//==== Vehicle abandoned ====
	if ((_vehicle distance _spawnPos) > _distanceFromSpawn) then {
		if (count (crew _vehicle) != 0) exitWith {/*Vehicle isn't empty and thus not abandoned*/}; 
	
		private _noPlayersClose = true;
		{
			if ((_vehicle distance _x) < PARAMS_VehicleRespawnDistance) exitWith {
				//there is a player closer than the respawn Distance
				_noPlayersClose = false;
			};
			sleep 0.1;
		} forEach allPlayers;
		
		if (_noPlayersClose) then {
			deleteVehicle _vehicle; 
			if (_base in controlledZones) then {
			_respawn = true;
			} else {
				_respawn = false;
			};
		};
	};
	sleep 5;
	
	//==== Respawn code ====
	if (_respawn) then {
		//Respawn the vehicle
		private _loopVar = true;
		while {_loopVar} do {
			//wait till the respawnPos is clear
			_spawnPosObjectsNear = _spawnPos nearObjects ["AllVehicles", 1.5];
			sleep 0.1;
			if (count _spawnPosObjectsNear < 1) exitWith {_loopVar = false;};
			sleep 5;
		};
		//Spawn the vehicle
		_vehicle = createVehicle  [_vehicleType, [0,0,(1000 + random(1000))], [], 100, "NONE"];
		waitUntil{sleep 0.1; !isNull _vehicle};
		//Move it to the right pos
		_vehicle setDir _spawnDir;
		_vehicle setPosWorld _spawnPos;
		sleep 0.1;
		
		//Call the init script
		[_vehicle] call _init;
		
		//reset the respawn
		_respawn = false;
		sleep 5;
	};
	
	//looptimeout
	sleep 30;
};
