/*
@filename: UAVfix.sqf
Author:

	Quiksilver
	
Last modified:

	13/10/2014 ArmA 1.30 by Quiksilver
	
Description:

	Addressing the issue of UAVs spawning 'dead'.
	
____________________________________________________________________*/


private ["_uavs","_obj","_rad","_towerRad","_delay","_loopTimeout","_uavArray"];
_obj = getMarkerPos "UAVspawn"; 								// uav spawn
_rad = 300;  													// radius outwards from center point to search for Autonomous
_delay = 300;  													// default 600
_loopTimeout = 20 + (random 20);
_uavArray = ["B_UAV_02_CAS_F","B_UAV_02_F","B_UGV_01_F","B_UGV_01_rcws_F"];
 
//---------- LOOP
 
while { true } do { 
	sleep 900;

	//---------- DESPAWN UAV CREW
		
	_uavs = _obj nearEntities [_uavArray,_rad];
		
	{{deleteVehicle _x;} forEach crew _x;} forEach _uavs;
		
	sleep 3;
		
	//---------- RESPAWN UAV CREW
		
	{createVehicleCrew _x;} forEach _uavs;
	{_x setCombatMode "BLUE";} count _uavs;
};