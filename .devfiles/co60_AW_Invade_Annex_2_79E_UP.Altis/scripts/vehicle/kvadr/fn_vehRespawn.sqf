/* ----------------------------------------------------------------------------------------------------

File: fn_vehRespawn.sqf
	
Author: Iceman77
    
Description:
	- Monitor a vehicle and "respawn" it if it's destroyed or abandoned 
	- Can be used on vehicles
	- Set vehicle init upon respawn (optional)
	- Store and keep the vehicle's variable name automatically
    
Parameter(s):
	- _this select 0: < OBJECT > - VEHICLE 
	- _this select 1: < NUMBER > - ABANDONED DELAY IN SECONDS
	- _this select 2: < NUMBER > - DESTROYED DELAY IN SECONDS
	- _this select 3: < CODE > - FUNCTION THE VEHICLE CALLS UPON RESPAWN (OPTIONAL)

Usage (Vehicle init Line): 
	_nul = [ this, 120, 60, LVR_fnc_hunterInit ] spawn LVR_fnc_vehRespawn << have the vehicle call the custom LVR Function upon respawn (see functions.hpp && fn_hunterInit.sqf) 
	_nul = [ this, 120, 60 ] spawn LVR_fnc_vehRespawn; << Default usage
	
---------------------------------------------------------------------------------------------------- */


// SERVER CODE
if ( ! ( isServer ) ) exitWith {};

// SET SCOPE OF LOCAL VARIABLES
private ["_veh","_abandonDelay","_destroyedDelay","_vehInit","_vehName","_vehDir","_vehPos","_vehtype","_abandoned","_dead"];

// PASSED ARGUMENTS ( OBJECT, ABANDONED DELAY, DESTROYED DELAY )
_veh = 			 [_this, 0, objNull, [objNull]] call BIS_fnc_param; 
_abandonDelay =  	 [_this, 1, 60, [0]] call BIS_fnc_param; 
_destroyedDelay =	 [_this, 2, 60, [0]] call BIS_fnc_param; 
_vehInit =        [_this, 3, {}, [{}] ] call BIS_fnc_param;

// STORE THE VEHICLES NAME, DIRECTION, POSITION AND TYPE
_vehName =        vehicleVarName _veh;
_vehDir = 		 getDir _veh; 
_vehPos = 		 getPos _veh; 
_vehtype = 		 typeOf _veh; 

// START LOOP TO MONITOR THE VEHICLE
while { true } Do {

	sleep 1;
	
	// IF THE VEHICLE IS ALIVE AND CAN MOVE AND IS EMPTY THEN THE VEHICLE IS ABANDONED
	if ( ( alive _veh ) && { ( canMove _veh ) && { { ( alive _x ) } count ( crew _veh ) == 0 } } ) then {
	
		_abandoned = true;

			// COUNTDOWN THE ABANDONED DELAY - STALL SCRIPT HERE
			for "_i" from 0 to _abandonDelay do {  
				
				// IF THE VEHICLE ISN'T EMPTY, OR IS DESTROYED, OR IF IT CAN'T MOVE THEN IT'S NOT ABANDONED SO EXIT THE COUNTDOWN EARLY - CONTINUE THE SCRIPT
				if ( { ( alive _x ) } count (crew _veh) > 0 || { !( alive _veh ) || { !( canMove _veh ) } } ) exitWith { _abandoned = false; };
				sleep 1;  
				
			};
		
		// IF THE VEHICLE IS ABANDONED AND ISN'T CLOSE TO IT'S STARTING POSITION THEN DELETE IT AND CREATE A NEW ONE AT THE STARTING POSITION
		if ( ( _abandoned ) && { _veh distance _vehPos > 10 } ) then {
			
			deleteVehicle _veh;
			sleep 1;
			_veh = createVehicle [ _vehtype, _vehPos, [], 0, "CAN_COLLIDE" ];
			_veh setDir _vehDir;
			_veh setPos [ ( _vehPos select 0 ), ( _vehPos select 1 ), 0 ];
			_veh call _vehInit;
			if (_vehName != "") then {
				missionNamespace setVariable [_vehName, _veh];
				publicVariable _vehName;
			};	
		};
	};

	// IF THE VEHICLE IS DESTROYED OR IF IT CAN'T MOVE THEN ITS DEAD
	if ( !( alive _veh ) || { !( canMove _veh ) } ) then {
	
		_dead = true;

			// COUNTDOWN THE DEAD DELAY - STALL SCRIPT HERE
			for "_i" from 0 to _destroyedDelay do {  
			
				// IF THE VEHICLE ISN'T EMPTY, OR IF IT CAN MOVE ( HAS BEEN REPAIRED ) THEN IT'S NOT DEAD SO EXIT THE COUNTDOWN EARLY - CONTINUE THE SCRIPT
				if ( { ( alive _x ) } count ( crew _veh ) > 0 || { ( canMove _veh ) } ) exitWith { _dead = false; };
				sleep 1;  
				
			};
		 
		// IF THE VEHICLE IS DEAD THEN DELETE IT AND CREATE A NEW ONE AT THE STARTING POSITION
		if ( _dead ) then {
		
			deleteVehicle _veh;
			sleep 1;
			_veh = createVehicle [ _vehtype, _vehPos, [], 0, "CAN_COLLIDE" ];
			_veh setDir _vehDir;
			_veh setPos [ ( _vehPos select 0 ), (_vehPos select 1 ), 0 ];
			_veh call _vehInit;
			if (_vehName != "") then {
				missionNamespace setVariable [_vehName, _veh];
				publicVariable _vehName;
			};	
			
		};
	};
};
