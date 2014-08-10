/*
Author: 
	Quiksilver
Last modified: 
	8/04/2014
Description: 
	Spawns enemy CAS while radio tower is alive.

To do: 	
	Find a good way to delete enemy JTAC, and not have it counted toward SPAWN_LIMIT.
	Clean up code.

Useful stuff: 
	OPFOR CAS armaments:
		Sahr-3 			- 2Rnd_Missile_AA_03_F
		Sharur AG 		- 4Rnd_Missile_AGM_01_F
		Tratnyr HE 		- 20Rnd_Rocket_03_HE_F
		Tratnyr AP 		- 20Rnd_Rocket_03_AP_F
		LOM-250G Bomb 	- ?
		Cannon 30mm 	- ?	
		
	Enemy CAS drone: 
		"O_UAV_02_CAS_F" // note, needs some tweaking to work correctly, due to crew and weakness with bis_fnc_spawnVehicle drones.
		This has potential for UAV/CAS synergy re laser designation. 
		Working on integrating enemy JTAC, probably 50% complete.
__________________________________________________________*/


#define AIR_TYPE "O_Plane_CAS_02_F"
#define SPAWN_LIMIT 2
#define FIXED_TIME 600
#define RANDOM_TIME 600
#define EASY true

waitUntil {sleep 1; !(isNil "currentAOUp")};
waitUntil {sleep 1; !(isNil "currentAO")};
private ["_priorityMessageJet"];

while {true} do {
	sleep (FIXED_TIME + (random RANDOM_TIME));
    if ((radioTowerAlive) && (({(typeOf _x == AIR_TYPE) && (side _x == east)} count vehicles) < SPAWN_LIMIT)) then {
		_patrolPos = getMarkerPos currentAO;
		
		_helo_Patrol = createGroup EAST;
		_helo_Array = [[1000, _patrolPos select 1, 2000], 90, [AIR_TYPE] call BIS_fnc_selectRandom, east] call BIS_fnc_spawnVehicle;
			
		_helo_Patrol = _helo_Array select 0;
		_helo_crew = _helo_Array select 1;
		[_helo_Array select 2, _patrolPos] call BIS_fnc_taskAttack;
		
		[(units _helo_Patrol)] call QS_fnc_setSkill4;
		
		showNotification = ["EnemyJet", "Enemy CAS approaching the AO!"]; publicVariable "showNotification";
		
		_priorityMessageJet =
		"<t align='center' size='2.2'>Priority Target (AO)</t><br/><t size='1.5' color='#b60000'>Enemy CAS Inbound</t><br/>____________________<br/>OPFOR are inbound with CAS to support their infantry forces!<br/><br/>This is a priority target!";
		GlobalHint = _priorityMessageJet; publicVariable "GlobalHint"; hint parseText _priorityMessageJet;
		
		waitUntil {
			
			sleep 1;
			_helo_Patrol setVehicleAmmo 1;
			sleep 1;
			
			if (EASY) then {
				_helo_Patrol setVehicleAmmo 1;
				_helo_Patrol removeMagazineTurret ["4Rnd_Missile_AGM_01_F",[0]];
				_helo_Patrol removeMagazines "4Rnd_Missile_AGM_01_F";	
			};
			
			!alive _helo_Patrol || {!canMove _helo_Patrol}
		};

		[] call QS_fnc_rewardPlusHintJet;

		sleep 5;
		_helo_Patrol setDamage 1;
		sleep 5;
		deleteVehicle _helo_Patrol;

		{
			_x setDamage 1;
			sleep 5;
			deleteVehicle _x;
		} foreach _helo_crew;
    };
    sleep 10;
};
