/*
author: ?

Description: scripts that cleans up things every so many seconds, and sooooo many other things
*/
_24HoursInSeconds = 86400;

/*time at which the server should restart in seconds, 
note that this time should be 1 hour before you want the server to restart
as the restart script itself gives multiple warnings that the server will restart before actually restarting*/
_restartTime = 18000;

//mission start time
_missionStartTime = missionStart;
_missionStartTimeSeconds = ( ((_missionStartTime select 3)) * 3600 + ((_missionStartTime select 4) * 60) + (_missionStartTime select 5) ); 

//determine runtime
private ["_runtime"];

if (_missionStartTimeSeconds < _restartTime) then{
	/*	if before the time it should restart and after midnight
		take the time between midnight and the time it should restart and substract the current time
		the result is the runtime*/
	_runtime = (_restartTime - _missionStartTimeSeconds);
} else{
	/*	if before midnight and after the time it should restart
		substract the start time from 24 hours and add the time at which it should restart
		the result is the runtime*/
	_runtime = ( (_24HoursInSeconds - _missionStartTimeSeconds) + _restartTime);
};

sleep 360;
waitUntil {sleep 1; time > 360};

while {true} do {
	
	if (time > _runtime) then {["timedRestart"] execVM "Scripts\RestartScript.sqf";};
	
	{deleteVehicle _x;} count allDead;
	sleep 1;
	{deleteVehicle _x;} count (allMissionObjects "CraterLong");
	sleep 1;
	{deleteVehicle _x;} count (allMissionObjects "WeaponHolder");
	sleep 1;
	{deleteVehicle _x;} count (allMissionObjects "WeaponHolderSimulated");
	sleep 1;
	{if ((count units _x) == 0) then {deleteGroup _x;};} count allGroups;
	sleep 1;
    
    _ejectionItems = [
		"B_Ejection_Seat_Plane_Fighter_01_F",
		"B_Ejection_Seat_Plane_CAS_01_F",
		"O_Ejection_Seat_Plane_CAS_02_F",
		"O_Ejection_Seat_Plane_Fighter_02_F",
		"I_Ejection_Seat_Plane_Fighter_04_F",
		"I_Ejection_Seat_Plane_Fighter_03_F",
		"plane_fighter_01_canopy_f",
		"plane_fighter_02_canopy_f",
		"plane_fighter_03_canopy_f",
		"plane_fighter_04_canopy_f",
		"Plane_CAS_01_Canopy_f",
		"Plane_CAS_02_Canopy_f"
	];
	
    {
		if ( speed _x == 0 ) then{ deleteVehicle _x; }; 
    } forEach (entities [_ejectionItems, []]);
	
    _fog = fogParams;
	_fogValue = _fog select 0;
	_fogDecay = _fog select 1;
	_fogBase = _fog select 2;
	if (_fogdecay != 0) then {_fogdecay = 0;};
	if (_fogBase != 0) then {_fogBase = 0;};
	0 setFog [_fogValue, _fogDecay, _fogBase];
	sleep 1;
	
	if (_fogValue > 0.7) then {
		for "_i" from 0 to 19 do {_fogValue = _fogValue - 0.035; 0 setFog [_fogValue, _fogDecay, _fogBase]; sleep 2;};
	};
	if (_fogValue > 0.4) then {
		for "_i" from 0 to 19 do {_fogValue = _fogValue - 0.02; 0 setFog [_fogValue, _fogDecay, _fogBase]; sleep 2;};
	};
	
	if (time > _runtime) then {["timedRestart"] execVM "Scripts\RestartScript.sqf";};
	
	if (daytime > 21 || daytime < 5) then {
		setTimeMultiplier 6;
	} else{
		setTimeMultiplier 1;
	};
	
	sleep 360 + (random 240);
	
};

