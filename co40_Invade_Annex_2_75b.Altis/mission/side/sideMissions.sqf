/*
Authors: Rarek [AW] & Quiksilver

Last modified: 2/04/2014 by Quiksilver

To do: heaps!
	ie. change 'island' trigger to BIS_fnc_worldArea.
	ie. more SMs. rescue. kill. intel. timer and fail variables.
	ie. break cases into separate files.
*/

private ["_firstRun","_mission","_isGroup","_obj","_skipTimer","_awayFromBase","_road","_position","_briefing","_altPosition","_flatPos","_accepted","_randomPos","_spawnGroup","_unitsArray","_randomDir","_hangar","_x","_sideMissions","_completeText","_roadList","_armour","_armourGroup","_car","_carGroup","_truck","_newGrp"];

//-------------------------------------- Side mission array

_sideMissions = [
	"destroyChopper",
	"destroySmallRadar",
	"destroyExplosivesCoast",
	"destroyWeaponsSupply",
	"destroyResearchOutpost", 
	"destroyInsurgentHQ"
	];

_mission = "";

//-------------------------------------- Side mission rewards

smRewards =
[
	["an MBT-52 Kuma", "I_MBT_03_cannon_F"],["a To-199 Neophron (CAS)", "O_Plane_CAS_02_F"],["an AH-99 Blackfoot", "B_Heli_Attack_01_F"],["an FV-720 Mora", "I_APC_tracked_03_cannon_F"],["a PO-30 Orca", "O_Heli_Light_02_F"],["an AFV-4 Gorgon", "I_APC_Wheeled_03_cannon_F"],["a Strider HMG", "I_MRAP_03_hmg_F"],["an Mi-48 Kajman", "O_Heli_Attack_02_black_F"],["an A-143 Buzzard (CAS)", "I_Plane_Fighter_03_CAS_F"],["an M2A1 Slammer", "B_MBT_01_cannon_F"],["an IFV-6a Cheetah", "B_APC_Tracked_01_AA_F"],["an Offroad (Armed)", "B_G_Offroad_01_armed_F"],["an MQ4A Greyhawk", "B_UAV_02_F"],["an AH-9 Pawnee", "B_Heli_Light_01_armed_F"],["a WY-55 Hellcat", "I_Heli_light_03_F"],["a T-100 Varsuk", "O_MBT_02_cannon_F"],["an M2A4 Slammer (Urban Purpose)", "B_MBT_01_TUSK_F"],["an A-164 Wipeout (CAS)", "B_Plane_CAS_01_F"]
];

smMarkerList =
["smReward1","smReward2","smReward3","smReward4","smReward5","smReward6","smReward7","smReward8","smReward9","smReward10","smReward11","smReward12","smReward13","smReward14","smReward15","smReward16","smReward17","smReward18","smReward19","smReward20","smReward21","smReward22","smReward23","smReward24","smReward25","smReward26","smReward27"];

//-------------------------------------- PVEH



//--------------------------------------- Side mission complete text

_completeText = 
"<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#00B2EE'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>Focus on the main objective for now; we'll relay this success to the intel team and see if there's anything else you can do for us. We'll get back to you in 15 - 30 minutes.</t>";

//-------------------------------------- Set up some mission variables

sideMissionUp = false;
sideObj = objNull;

_firstRun = true;
_skipTimer = false;
_roadList = island nearRoads 4000; //change this to the BIS function that creates a trigger covering the map (Quiksilver: BIS_fnc_worldArea)
_unitsArray = [sideObj];

while {true} do
{	
	if (_firstRun) then
	{
		_firstRun = false;
		sleep 10;
		
		_mission = _sideMissions call BIS_fnc_selectRandom;
		
	} else {
		if (!_skipTimer) then
		{
			//Wait between 15-25 minutes before assigning another mission
			sleep (900 + (random 600));  // default 900 and 600

			//Select random mission from the SM list
			_mission = _sideMissions call BIS_fnc_selectRandom;
		} else {
			//Reset skipTimer
			_skipTimer = false;
		};
	};
	
	//Grab the code for the selected mission
	
	switch (_mission) do
	{
case "destroyChopper":
		{
			//Set up briefing message
			_briefing =
			"<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy Chopper</t><br/>____________________<br/>OPFOR forces have been provided with a new prototype attack chopper and they're keeping it in a hangar somewhere on the island.<br/><br/>We've marked the suspected location on your map; head to the hangar and destroy that chopper. Fly it into the sea if you have to, just get rid of it.</t>";

			_flatPos = [0,0,0];
			_accepted = false;
			while {!_accepted} do
			{
				_position = [] call BIS_fnc_randomPos;
				_flatPos = _position isFlatEmpty
				[
					5,
					0,
					0.3,
					10,
					0,
					false
				];

				while {(count _flatPos) < 3} do
				{
					_position = [] call BIS_fnc_randomPos;
					_flatPos = _position isFlatEmpty
					[
						5,
						0,
						0.3,
						10,
						0,
						false
					];
				};

				if ((_flatPos distance (getMarkerPos "respawn_west")) > 1000 && (_flatPos distance (getMarkerPos currentAO)) > 500) then //DEBUG - set >500 from AO to (PARAMS_AOSize * 2)
				{
					_accepted = true;
				};
			};

			//Spawn hangar and chopper
			_randomDir = (random 360);
			_hangar = "Land_TentHangar_V1_F" createVehicle _flatPos;
			waitUntil {alive _hangar};
			_hangar setPos [(getPos _hangar select 0), (getPos _hangar select 1), ((getPos _hangar select 2) - 1)];
			sideObj = "O_Heli_Attack_02_black_F" createVehicle _flatPos;
			waitUntil {!isNull sideObj};
			
			sideObj lock 3;
			{_x setDir _randomDir} forEach [sideObj,_hangar];
			sideObj setVehicleLock "LOCKED";
			_hangar allowDamage false;
			
			_fuzzyPos = 
			[
				((_flatPos select 0) - 300) + (random 600),
				((_flatPos select 1) - 300) + (random 600),
				0
			];

			{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
			"sideMarker" setMarkerText "Side Mission: Destroy Chopper";
			publicVariable "sideMarker";
			publicVariable "sideObj";

			//Spawn some enemies around the objective
			_unitsArray = [sideObj];
			_x = 0;
			for "_x" from 0 to 2 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};

			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [getPos sideObj, 500, 10] call BIS_fnc_findOverwatch;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
				[(units _spawnGroup)] call QS_fnc_setSkill3;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "O_APC_Tracked_02_cannon_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_soldier_repair_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;

			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill2;
			_armour lock 3;
			
			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_soldier_repair_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;

			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill4;
			_armour lock 3;

			{
			_newGrp = [_x] call QS_fnc_garrisonBuildings;
			if (!isNull _newGrp) then { 
				_unitsArray = _unitsArray + [_newGrp]; 
				};
			} forEach (getPos sideObj nearObjects ["House", 150]);
			
			//Send new side mission hint
			GlobalHint = _briefing; publicVariable "GlobalHint"; hint parseText _briefing;
			showNotification = ["NewSideMission", "Destroy Enemy Chopper"]; publicVariable "showNotification";

			sideMissionUp = true;
			publicVariable "sideMissionUp";
			sideMarkerText = "Destroy Chopper";
			publicVariable "sideMarkerText";
			
			//Wait until objective is destroyed
			waitUntil {sleep 0.5; !alive sideObj};

			sideMissionUp = false;
			publicVariable "sideMissionUp";
			
			//Send completion hint
			[] call QS_fnc_rewardPlusHint;

			//Hide SM marker
			"sideMarker" setMarkerPos [-10000,-10000,-10000];
			"sideCircle" setMarkerPos [-10000,-10000,-10000];
			publicVariable "sideMarker";
			
			
			//------------------------------ Delete
			
			sleep 120;
			[_unitsArray] spawn QS_fnc_deleteOldUnitsAndVehicles;
			deleteVehicle sideObj;
			deleteVehicle _hangar;

			
		}; /* case "destroyChopper": */
		
		
		
case "destroySmallRadar":
		{
			//Set up briefing message
			_briefing =
			"<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy Radar</t><br/>____________________<br/>OPFOR forces have erected a small radar on the island as part of a project to keep friendly air support at bay.<br/><br/>We've marked the position on your map; head over there and take down that radar.</t>";
			
			_flatPos = [0,0,0];
			_accepted = false;
			while {!_accepted} do
			{
				//Get random safe position somewhere on the island
				_position = [] call BIS_fnc_randomPos;
				_flatPos = _position isFlatEmpty 
				[
					5, //minimal distance from another object
					1, //try and find nearby positions if original is incorrect
					0.5, //30% max gradient
					sizeOf "Land_Radar_small_F", //gradient must be consistent for entirety of object
					0, //no water
					false //don't find positions near the shoreline
				];
			
				while {(count _flatPos) < 1} do
				{
					_position = [] call BIS_fnc_randomPos;
					_flatPos = _position isFlatEmpty 
					[
						10, //minimal distance from another object
						1, //try and find nearby positions if original is incorrect
						0.5, //30% max gradient
						sizeOf "Land_Radar_small_F", //gradient must be consistent for entirety of object
						0, //no water
						false //don't find positions near the shoreline
					];
				};
				
				if ((_flatPos distance (getMarkerPos "respawn_west")) > 1000 && (_flatPos distance (getMarkerPos currentAO)) > 500) then //DEBUG - set >500 from AO to (PARAMS_AOSize * 2)
				{
					_accepted = true;
				};
			};
			
			//Spawn radar, set vector and add marker
			sideObj = "Land_Radar_Small_F" createVehicle _flatPos;
			waitUntil {alive sideObj};
			sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) - 2)];
			sideObj setVectorUp [0,0,1];
			_fuzzyPos = 
			[
				((_flatPos select 0) - 300) + (random 600),
				((_flatPos select 1) - 300) + (random 600),
				0
			];

			{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
			"sideMarker" setMarkerText "Side Mission: Destroy Radar";
			publicVariable "sideMarker";
			publicVariable "sideObj";

			//Spawn some enemies around the objective
			_unitsArray = [sideObj];
			_x = 0;
			for "_x" from 0 to 2 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};

			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardTeam")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill2;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_soldier_repair_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;
			
			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			
			_unitsArray = _unitsArray + [_armourGroup];
			
			[(units _armourGroup)] call QS_fnc_setSkill4;
			_armour lock 3;

			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "O_APC_Tracked_02_cannon_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_soldier_repair_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;

			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill1;
			_armour lock 3;

			//Throw out objective hint
			GlobalHint = _briefing; publicVariable "GlobalHint"; hint parseText GlobalHint;
			showNotification = ["NewSideMission", "Destroy Enemy Radar"]; publicVariable "showNotification";

			sideMissionUp = true;
			publicVariable "sideMissionUp";
			sideMarkerText = "Destroy Radar";
			publicVariable "sideMarkerText";
			
			waitUntil {sleep 0.5; !alive sideObj}; //wait until the objective is destroyed

			sideMissionUp = false;
			publicVariable "sideMissionUp";
			
			//Throw out objective completion hint
			[] call QS_fnc_rewardPlusHint;

			//Hide SM marker
			"sideMarker" setMarkerPos [-10000,-10000,-10000];
			"sideCircle" setMarkerPos [-10000,-10000,-10000];
			publicVariable "sideMarker";
			
			//Delete
			sleep 120;
			[_unitsArray] spawn QS_fnc_deleteOldUnitsAndVehicles;
			deleteVehicle sideObj;


		}; /* case "destroySmallRadar": */
		
	
case "destroyExplosivesCoast":
		{
			//Set up briefing message
			_briefing =
			"<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy Smuggled Explosives</t><br/>____________________<br/>The OPFOR have been smuggling explosives onto the island and hiding them in a Mobile HQ on the coastline.<br/><br/>We've marked the building on your map; head over there and destroy their stock. Keep well back when you blow it; there's a lot of stuff in that building.</t>";
			
			_flatPos = [0,0,0];
			_accepted = false;

			while {!_accepted} do
			{
				_position = [[[getPos island,4000]],["water","out"]] call BIS_fnc_randomPos;
				_flatPos = _position isFlatEmpty
				[
					2,
					0,
					0.3,
					1,
					1,
					true
				];

				while {(count _flatPos) < 1} do
				{
					_position = [[[getPos island,16000]],["water","out"]] call BIS_fnc_randomPos;
					_flatPos = _position isFlatEmpty
					[
						2,
						0,
						0.3,
						1,
						1,
						true
					];
				};

				if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700 && (_flatPos distance (getMarkerPos currentAO)) > 500) then //DEBUG - set >500 from AO to (PARAMS_AOSize * 2)
				{
					_accepted = true;
				};
			};
			
			//Spawn Mobile HQ
			_randomDir = (random 360);
			sideObj = "Land_Cargo_HQ_V1_F" createVehicle _flatPos;
			waitUntil {alive sideObj};
			sideObj setDir _randomDir;
			sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) - 0.5)];
			sideObj setVectorUp [0,0,1];
			
			//Spawn some enemies around the objective
			_unitsArray = [sideObj];
			_x = 0;
			for "_x" from 0 to 2 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AT")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};

			_x = 0;
			for "_x" from 0 to 1 do
			{	
				_sfGroup = createGroup east;
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_sfGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "SpecOps" >> "OI_diverTeam")] call BIS_fnc_spawnGroup;
				[_sfGroup, _flatPos, 100] call BIS_fnc_taskPatrol;
				[(units _sfGroup)] call QS_fnc_setSkill3;
				
				_unitsArray = _unitsArray + [_sfGroup];
			};
			
			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_soldier_repair_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;
			
			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill4;
			_armour lock 3;

			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "O_APC_Wheeled_02_rcws_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_soldier_repair_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;
			
			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill1;
			_armour lock 3;
		
		
			_boatGroup = createGroup east;
			_randomPos = [_flatPos, 50, 200, 10, 2, 1, 0] call BIS_fnc_findSafePos;
			_boat = "O_Boat_Armed_01_hmg_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_diver_F" createUnit [_randomPos,_boatGroup];
				"O_diver_F" createUnit [_randomPos,_boatGroup];
				"O_diver_TL_F" createUnit [_randomPos,_boatGroup];

				((units _boatGroup) select 0) assignAsDriver _boat;
				((units _boatGroup) select 1) assignAsGunner _boat;
				((units _boatGroup) select 2) assignAsCommander _boat;
				((units _boatGroup) select 0) moveInDriver _boat;
				((units _boatGroup) select 1) moveInGunner _boat;
				((units _boatGroup) select 2) moveInCommander _boat;
			
			//[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill2;
			_armour lock 3;
			
			{
			_newGrp = [_x] call QS_fnc_garrisonBuildings;
			if (!isNull _newGrp) then { 
				_unitsArray = _unitsArray + [_newGrp]; 
				};
			} forEach (getPos sideObj nearObjects ["House", 150]);

			//Set marker up
			_fuzzyPos = 
			[
				((_flatPos select 0) - 300) + (random 600),
				((_flatPos select 1) - 300) + (random 600),
				0
			];

			{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
			"sideMarker" setMarkerText "Side Mission: Destroy Smuggled Explosives";
			publicVariable "sideMarker";
			publicVariable "sideObj";
			
			//Throw briefing hint
			GlobalHint = _briefing; publicVariable "GlobalHint"; hint parseText GlobalHint;
			showNotification = ["NewSideMission", "Destroy Smuggled Explosives"]; publicVariable "showNotification";
			
			sideMissionUp = true;
			publicVariable "sideMissionUp";
			sideMarkerText = "Destroy Smuggled Explosives";
			publicVariable "sideMarkerText";
			
			//Wait for boats to be dead
			waitUntil {sleep 0.5; !alive sideObj};
			
			sideMissionUp = false;
			publicVariable "sideMissionUp";
			
			//Improve this to do some randomised mortar explosions quite quickly after the killing of the building in a small radius

			//Throw completion hint
			[] call QS_fnc_rewardPlusHint;
			
			//Hide SM marker
			"sideMarker" setMarkerPos [-10000,-10000,-10000];
			"sideCircle" setMarkerPos [-10000,-10000,-10000];
			publicVariable "sideMarker";	
			
			//Delete
			sleep 120;
			[_unitsArray] spawn QS_fnc_deleteOldUnitsAndVehicles;
			deleteVehicle sideObj;
			
		}; /* case "destroyExplosivesCoast": */
			
case "destroyResearchOutpost":
		{
			//Set up briefing message
			_briefing =
			"<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy Research Outpost</t><br/>____________________<br/>The OPFOR are conducting biological weapons testing in a small building somewhere on Altis.<br/><br/>We've marked the approximate location on your map; head over there and destroy their work before it's too late!</t>";
			
			_flatPos = [0,0,0];
			_accepted = false;

			while {!_accepted} do
			{
				_position = [[[getPos island,16000]],["water","out"]] call BIS_fnc_randomPos;
				_flatPos = _position isFlatEmpty
				[
					2,
					0,
					0.3,
					1,
					0,
					false
				];

				while {(count _flatPos) < 1} do
				{
					_position = [[[getPos island,16000]],["water","out"]] call BIS_fnc_randomPos;
					_flatPos = _position isFlatEmpty
					[
						2,
						0,
						0.3,
						1,
						0,
						false
					];
				};

				if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700 && (_flatPos distance (getMarkerPos currentAO)) > 500) then //DEBUG - set >500 from AO to (PARAMS_AOSize * 2)
				{
					_accepted = true;
				};
			};
			
			//Spawn Research HQ
			_randomDir = (random 360);
			sideObj = "Land_Research_HQ_F" createVehicle _flatPos;
			waitUntil {alive sideObj};
			sideObj setDir _randomDir;
			sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) - 0.5)];
			sideObj setVectorUp [0,0,1];
			
			//Spawn some enemies around the objective
			_unitsArray = [sideObj];
			_x = 0;
			for "_x" from 0 to 2 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [getPos sideObj, 300, 50] call BIS_fnc_findOverwatch;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconSentry")] call BIS_fnc_spawnGroup;
				[(units _spawnGroup)] call QS_fnc_setSkill3;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};

			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconTeam")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill2;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_soldier_repair_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;
			
			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill4;
			_armour lock 3;

			_carGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_car = "O_MRAP_02_hmg_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_soldier_repair_F" createUnit [_randomPos,_carGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];

				((units _carGroup) select 0) assignAsDriver _car;
				((units _carGroup) select 1) assignAsGunner _car;
				((units _carGroup) select 0) moveInDriver _car;
				((units _carGroup) select 1) moveInGunner _car;
			
			[_carGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_carGroup];
			[(units _carGroup)] call QS_fnc_setSkill1;
			_car lock 3;
			
			_carGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_car = "O_MRAP_02_hmg_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_soldier_repair_F" createUnit [_randomPos,_carGroup];
				"O_crew_F" createUnit [_randomPos,_carGroup];

				((units _carGroup) select 0) assignAsDriver _car;
				((units _carGroup) select 1) assignAsGunner _car;
				((units _carGroup) select 0) moveInDriver _car;
				((units _carGroup) select 1) moveInGunner _car;
			
			[_carGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_carGroup];
			[(units _carGroup)] call QS_fnc_setSkill1;
			_car lock 3;
			
			_armourGroup = createGroup east;
			_randomPos = [_flatPos, 20, 30, 5, 0, 1, 0] call BIS_fnc_findSafePos;
			_armour = "O_Truck_03_device_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_crew_F" createUnit [_randomPos,_armourGroup];
				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 0) moveInDriver _armour;

			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill1;
			_armour lock 3;
			_armour setFuel 0;

			//Set marker up
			_fuzzyPos = 
			[
				((_flatPos select 0) - 300) + (random 600),
				((_flatPos select 1) - 300) + (random 600),
				0
			];

			{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
			"sideMarker" setMarkerText "Side Mission: Destroy Research Outpost";
			publicVariable "sideMarker";
			publicVariable "sideObj";
			
			//Throw briefing hint
			GlobalHint = _briefing; publicVariable "GlobalHint"; hint parseText GlobalHint;
			showNotification = ["NewSideMission", "Destroy Research Outpost"]; publicVariable "showNotification";
			
			sideMissionUp = true;
			publicVariable "sideMissionUp";
			sideMarkerText = "Destroy Research Outpost";
			publicVariable "sideMarkerText";
			
			//Wait for boats to be dead
			waitUntil {sleep 0.5; !alive sideObj};
			
			sideMissionUp = false;
			publicVariable "sideMissionUp";
			

			//Throw completion hint
			[] call QS_fnc_rewardPlusHint;
			
			//Hide SM marker
			"sideMarker" setMarkerPos [-10000,-10000,-10000];
			"sideCircle" setMarkerPos [-10000,-10000,-10000];
			publicVariable "sideMarker";	
			
			//Delete
			sleep 120;
			[_unitsArray] spawn QS_fnc_deleteOldUnitsAndVehicles;
			deleteVehicle sideObj;
			
		}; /* case "destroyResearchOutpost": */
		
		
case "destroyWeaponsSupply":
		{
			//Set up briefing message
			_briefing =
			"<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Intercept Weapons Transfer</t><br/>____________________<br/>Rogue Independents are supplying OPFOR with advanced weapons and intel.<br/><br/>We've marked the transfer building on your map. They are using an old cargo house. Head over there and destroy it before the transfer is complete!</t>";
			
			_flatPos = [0,0,0];
			_accepted = false;
			while {!_accepted} do
			{
				_position = [] call BIS_fnc_randomPos;
				_flatPos = _position isFlatEmpty 
				[
					5,
					1,
					0.5,
					sizeOf "Land_Cargo_HQ_V1_F",
					0,
					false
				];

				while {(count _flatPos) < 1} do
				{
					_position = [] call BIS_fnc_randomPos;
					_flatPos = _position isFlatEmpty 
					[
						10,
						1,
						0.5,
						sizeOf "Land_Cargo_HQ_V1_F",
						0,
						false
					];
				};

				if ((_flatPos distance (getMarkerPos "respawn_west")) > 1700 && (_flatPos distance (getMarkerPos currentAO)) > 500) then //DEBUG - set >500 from AO to (PARAMS_AOSize * 2)
				{
					_accepted = true;
				};
			};
			
			//Spawn Weapons Supply House
			sideObj = "Land_Cargo_HQ_V1_F" createVehicle _flatPos;
			waitUntil {alive sideObj};
			sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2)-0.25)];
			sideObj setVectorUp [0,0,1];
			_fuzzyPos = 
			[
				((_flatPos select 0) - 300) + (random 600),
				((_flatPos select 1) - 300) + (random 600),
				0
			];

			{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
			"sideMarker" setMarkerText "Side Mission: Destroy Weapons Depot";
			publicVariable "sideMarker";
			publicVariable "sideObj";
			
			//Spawn some enemies around the objective
			_unitsArray = [sideObj];
			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_x = 0;
			for "_x" from 0 to 2 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam_AA")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};

			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;
			
			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill4;
			_armour lock 3;
			
			_carGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_car = "I_MRAP_03_hmg_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"I_crew_F" createUnit [_randomPos,_carGroup];
				"I_crew_F" createUnit [_randomPos,_carGroup];
				"I_crew_F" createUnit [_randomPos,_carGroup];

				((units _carGroup) select 0) assignAsDriver _car;
				((units _carGroup) select 1) assignAsGunner _car;
				((units _carGroup) select 2) assignAsCommander _car;
				((units _carGroup) select 0) moveInDriver _car;
				((units _carGroup) select 1) moveInGunner _car;
				((units _carGroup) select 2) moveInCommander _car;
			
			[_carGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_carGroup];
			[(units _carGroup)] call QS_fnc_setSkill1;
			_car lock 3;
			
			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "I_APC_tracked_03_cannon_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"I_crew_F" createUnit [_randomPos,_armourGroup];
				"I_crew_F" createUnit [_randomPos,_armourGroup];
				"I_officer_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;
			
			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill3;
			_armour lock 3;

			_armourGroup = createGroup east;
			_randomPos = [_flatPos, 20, 30, 5, 0, 1, 0] call BIS_fnc_findSafePos;
			_armour = "I_Truck_02_ammo_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"I_crew_F" createUnit [_randomPos,_armourGroup];
				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 0) moveInDriver _armour;

			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill1;
			_armour lock 3;
			_armour setFuel 0;
			
			{
			_newGrp = [_x] call QS_fnc_garrisonBuildings;
			if (!isNull _newGrp) then { 
				_unitsArray = _unitsArray + [_newGrp]; 
				};
			} forEach (getPos sideObj nearObjects ["House", 150]);
			
			//Throw briefing hint
			GlobalHint = _briefing; publicVariable "GlobalHint"; hint parseText GlobalHint;
			showNotification = ["NewSideMission", "Destroy Weapons Depot"]; publicVariable "showNotification";
			
			sideMissionUp = true;
			publicVariable "sideMissionUp";
			sideMarkerText = "Destroy Weapons Depot";
			publicVariable "sideMarkerText";
			
			//Wait for boats to be dead
			waitUntil {sleep 0.5; !alive sideObj};
			
			sideMissionUp = false;
			publicVariable "sideMissionUp";
			
			//Improve this to do some randomised mortar explosions quite quickly after the killing of the building in a small radius

			//Throw completion hint
			[] call QS_fnc_rewardPlusHint;
			
			//Hide SM marker
			"sideMarker" setMarkerPos [-10000,-10000,-10000];
			"sideCircle" setMarkerPos [-10000,-10000,-10000];
			publicVariable "sideMarker";	
			
			// Delete
			sleep 120;
			[_unitsArray] spawn QS_fnc_deleteOldUnitsAndVehicles;
			deleteVehicle sideObj;
			
		}; /* case "destroyWeaponsSupply": */
		
		
case "destroyInsurgentHQ":
		{
			//Set up briefing message
			_briefing =
			"<t align='center'><t size='2.2'>New Side Mission</t><br/><t size='1.5' color='#00B2EE'>Destroy Insurgency HQ</t><br/>____________________<br/>OPFOR are training an insurgency on Altis.<br/><br/>We've marked the position on your map; head over there, sanitize the area and destroy their HQ.</t>";
			
			_flatPos = [0,0,0];
			_accepted = false;
			while {!_accepted} do
			{
				//Get random safe position somewhere on the island
				_position = [] call BIS_fnc_randomPos;
				_flatPos = _position isFlatEmpty 
				[
					5, //minimal distance from another object
					1, //try and find nearby positions if original is incorrect
					0.5, //30% max gradient
					sizeOf "Land_Cargo_HQ_V2_F",
					0, //no water
					false //don't find positions near the shoreline
				];
			
				while {(count _flatPos) < 1} do
				{
					_position = [] call BIS_fnc_randomPos;
					_flatPos = _position isFlatEmpty 
					[
						10, //minimal distance from another object
						1, //try and find nearby positions if original is incorrect
						0.5, //30% max gradient
						sizeOf "Land_Cargo_HQ_V2_F",
						0, //no water
						false //don't find positions near the shoreline
					];
				};
				
				if ((_flatPos distance (getMarkerPos "respawn_west")) > 1000 && (_flatPos distance (getMarkerPos currentAO)) > 500) then //DEBUG - set >500 from AO to (PARAMS_AOSize * 2)
				{
					_accepted = true;
				};
			};
			
			//Spawn HQ, set vector and add marker
			sideObj = "Land_Cargo_HQ_V2_F" createVehicle _flatPos;
			waitUntil {alive sideObj};
			sideObj setPos [(getPos sideObj select 0), (getPos sideObj select 1), ((getPos sideObj select 2) - 0.05)];
			sideObj setVectorUp [0,0,1];
			_fuzzyPos = 
			[
				((_flatPos select 0) - 300) + (random 600),
				((_flatPos select 1) - 300) + (random 600),
				0
			];

			{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
			"sideMarker" setMarkerText "Side Mission: Destroy Insurgency HQ";
			publicVariable "sideMarker";
			publicVariable "sideObj";

			//Spawn some enemies around the objective
			_unitsArray = [sideObj];
			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_x = 0;
			for "_x" from 0 to 2 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfTeam_AT")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill1;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};

			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [getPos sideObj, 500, 30] call BIS_fnc_findOverwatch;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_SniperTeam_M")] call BIS_fnc_spawnGroup;
				[(units _spawnGroup)] call QS_fnc_setSkill3;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_x = 0;
			for "_x" from 0 to 1 do
			{
				_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
				_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconPatrol")] call BIS_fnc_spawnGroup;
				[_spawnGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
				[(units _spawnGroup)] call QS_fnc_setSkill2;
				
				_unitsArray = _unitsArray + [_spawnGroup];
			};
			
			_armourGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_armour = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_crew_F" createUnit [_randomPos,_armourGroup];
				"O_officer_F" createUnit [_randomPos,_armourGroup];

				((units _armourGroup) select 0) assignAsDriver _armour;
				((units _armourGroup) select 1) assignAsGunner _armour;
				((units _armourGroup) select 2) assignAsCommander _armour;
				((units _armourGroup) select 0) moveInDriver _armour;
				((units _armourGroup) select 1) moveInGunner _armour;
				((units _armourGroup) select 2) moveInCommander _armour;
			
			[_armourGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_armourGroup];
			[(units _armourGroup)] call QS_fnc_setSkill4;
			_armour lock 3;

			_carGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_car = "B_G_Offroad_01_armed_F" createVehicle _randomPos;
			waitUntil{!isNull _car};

				"O_crew_F" createUnit [_randomPos,_carGroup];
				"O_crew_F" createUnit [_randomPos,_carGroup];
				"O_crew_F" createUnit [_randomPos,_carGroup];

				((units _carGroup) select 0) assignAsDriver _car;
				((units _carGroup) select 1) assignAsGunner _car;
				((units _carGroup) select 0) moveInDriver _car;
				((units _carGroup) select 1) moveInGunner _car;
			
			[_carGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_carGroup];
			[(units _carGroup)] call QS_fnc_setSkill2;
			_car lock 3;
			
			_carGroup = createGroup east;
			_randomPos = [[[getPos sideObj, 300],[]],["water","out"]] call BIS_fnc_randomPos;
			_car = "B_G_Offroad_01_armed_F" createVehicle _randomPos;
			waitUntil{!isNull _armour};

				"O_crew_F" createUnit [_randomPos,_carGroup];
				"O_crew_F" createUnit [_randomPos,_carGroup];

				((units _carGroup) select 0) assignAsDriver _car;
				((units _carGroup) select 1) assignAsGunner _car;
				((units _carGroup) select 0) moveInDriver _car;
				((units _carGroup) select 1) moveInGunner _car;
			
			[_carGroup, _flatPos, 300] call BIS_fnc_taskPatrol;
			_unitsArray = _unitsArray + [_carGroup];
			[(units _carGroup)] call QS_fnc_setSkill2;
			_car lock 3;
			
			{
			_newGrp = [_x] call QS_fnc_garrisonBuildings;
			if (!isNull _newGrp) then { 
				_unitsArray = _unitsArray + [_newGrp]; 
				};
			} forEach (getPos sideObj nearObjects ["House", 150]);

			//Throw out objective hint
			GlobalHint = _briefing; publicVariable "GlobalHint"; hint parseText GlobalHint;
			showNotification = ["NewSideMission", "Destroy Insurgency HQ"]; publicVariable "showNotification";

			sideMissionUp = true;
			publicVariable "sideMissionUp";
			sideMarkerText = "Destroy Insurgency HQ";
			publicVariable "sideMarkerText";
			
			waitUntil {sleep 0.5; !alive sideObj}; //wait until the objective is destroyed

			sideMissionUp = false;
			publicVariable "sideMissionUp";
			
			//Throw out objective completion hint
			[] call QS_fnc_rewardPlusHint;

			//Hide SM marker
			
			"sideMarker" setMarkerPos [-10000,-10000,-10000];
			"sideCircle" setMarkerPos [-10000,-10000,-10000];
			publicVariable "sideMarker";	
			
			//Delete
			
			sleep 120;
			[_unitsArray] spawn QS_fnc_deleteOldUnitsAndVehicles;
			deleteVehicle sideObj;

		}; /* case "destroyInsurgentHQ": */
	};
};