private ["_enemiesArray","_randomPos","_spawnGroup","_pos","_x","_staticGroup","_static","_carGroup","_car","_apcGroup","_apc","_armourGroup","_armour","_aaGroup","_aa","_airGroup","_air","_airType","_overwatchGroup","_wp","_sniperGroup","_reconGroup"];
_pos = getMarkerPos (_this select 0);
	_enemiesArray = [grpNull];
	_x = 0;

	for "_x" from 1 to PARAMS_SquadsPatrol do {
		_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 1.2)],[]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		[_spawnGroup, getMarkerPos currentAO, 500] call BIS_fnc_taskPatrol;
		[(units _spawnGroup)] call QS_fnc_setSkill1;

		_enemiesArray = _enemiesArray + [_spawnGroup];
	};
	
	for "_x" from 1 to PARAMS_SquadsDefend do {
		_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 4)],[]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "UInfantry" >> "OIA_GuardSquad")] call BIS_fnc_spawnGroup;
		[_spawnGroup, getMarkerPos currentAO] call BIS_fnc_taskDefend;	
		[(units _spawnGroup)] call QS_fnc_setSkill2;

		_enemiesArray = _enemiesArray + [_spawnGroup];
	};
	
	for "_x" from 1 to PARAMS_TeamsPatrol do {
		_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize],[]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		[_spawnGroup, getMarkerPos currentAO, 800] call BIS_fnc_taskPatrol;
		[(units _spawnGroup)] call QS_fnc_setSkill1;

		_enemiesArray = _enemiesArray + [_spawnGroup];
	};
	
	for "_x" from 1 to PARAMS_SniperTeamsPatrol do {
		_sniperGroup = createGroup east;
		_randomPos = [getMarkerPos currentAO, 1200, 100, 10] call BIS_fnc_findOverwatch;
		_sniperGroup = [_randomPos, EAST,(configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_SniperTeam")] call BIS_fnc_spawnGroup;
		[(units _sniperGroup)] call QS_fnc_setSkill3;
		_sniperGroup setBehaviour "COMBAT";
		
		_enemiesArray = _enemiesArray + [_sniperGroup];
	};
	
	for "_x" from 1 to PARAMS_ReconTeamsPatrol do {
		_reconGroup = createGroup east;
		_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize * 1.25)],[]],["water","out"]] call BIS_fnc_randomPos;
		_reconGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OI_reconTeam")] call BIS_fnc_spawnGroup;
		[_reconGroup, getMarkerPos currentAO, 1000] call BIS_fnc_taskPatrol;
		[(units _reconGroup)] call QS_fnc_setSkill2;

		_enemiesArray = _enemiesArray + [_reconGroup];
	};

	for "_x" from 1 to PARAMS_AirDefenseTeams do {
		_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize * 1.1)],[]],["water","out"]] call BIS_fnc_randomPos;
		_spawnGroup = [_randomPos, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
		[_spawnGroup, getMarkerPos currentAO, 1000] call BIS_fnc_taskPatrol;
		[(units _spawnGroup)] call QS_fnc_setSkill1;

		_enemiesArray = _enemiesArray + [_spawnGroup];
	};

	for "_x" from 1 to PARAMS_StaticMG do {
		_staticGroup = createGroup east;
		_randomPos = [getMarkerPos currentAO, 500, 10] call BIS_fnc_findOverwatch;
		_static = "O_HMG_01_high_F" createVehicle _randomPos;
		waitUntil{!isNull _static};
		
			"O_support_MG_F" createUnit [_randomPos,_staticGroup];
			((units _staticGroup) select 0) assignAsGunner _static;
			((units _staticGroup) select 0) moveInGunner _static;
		
		[(units _staticGroup)] call QS_fnc_setSkill3;
		_staticGroup setBehaviour "COMBAT";
		_static lock 3;
	
		_enemiesArray = _enemiesArray + [_staticGroup];
	};
	
	for "_x" from 1 to PARAMS_Overwatch do {
		_overwatchGroup = createGroup east;
		_randomPos = [getMarkerPos currentAO, 600, 50, 10] call BIS_fnc_findOverwatch;
		_overwatchGroup = [_randomPos, East, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		[_overwatchGroup, _randomPos, 50] call BIS_fnc_taskPatrol;
		[(units _overwatchGroup)] call QS_fnc_setSkill1;

		_enemiesArray = _enemiesArray + [_overwatchGroup];
	};
	
	for "_x" from 1 to PARAMS_CarsPatrol do {
		_carGroup = createGroup east;
		_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize],[]],["water","out"]] call BIS_fnc_randomPos;
		if(random 1 < 0.75) then {_car = "O_MRAP_02_hmg_F" createVehicle _randomPos} else {_car = "O_MRAP_02_gmg_F" createVehicle _randomPos};
		waitUntil{!isNull _car};

			"O_Soldier_TL_F" createUnit [_randomPos,_carGroup];
			"O_soldier_repair_F" createUnit [_randomPos,_carGroup];
			((units _carGroup) select 0) assignAsDriver _car;
			((units _carGroup) select 1) assignAsGunner _car;
			((units _carGroup) select 0) moveInDriver _car;
			((units _carGroup) select 1) moveInGunner _car;
		
		[_carGroup, getMarkerPos currentAO, 700] call BIS_fnc_taskPatrol;

		[(units _carGroup)] call QS_fnc_setSkill1;
		_car lock 3;
	
		_enemiesArray = _enemiesArray + [_carGroup];
	};
	
	for "_x" from 1 to PARAMS_APCPatrol do {
		_apcGroup = createGroup east;
		_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize],[]],["water","out"]] call BIS_fnc_randomPos;
		if(random 1 <= 0.50) then {_apc = "O_APC_Tracked_02_cannon_F" createVehicle _randomPos} else {_apc = "I_APC_tracked_03_cannon_F" createVehicle _randomPos};
		waitUntil{!isNull _apc};

			"O_officer_F" createUnit [_randomPos,_apcGroup];
			"O_soldier_repair_F" createUnit [_randomPos,_apcGroup];
			"O_officer_F" createUnit [_randomPos,_apcGroup];
			"O_Soldier_F" createUnit [_randomPos, _apcGroup];
			"O_Soldier_repair_F" createUnit [_randomPos, _apcGroup];
			"O_Soldier_repair_F" createUnit [_randomPos, _apcGroup];
			"O_Soldier_F" createUnit [_randomPos, _apcGroup];
			((units _apcGroup) select 0) assignAsDriver _apc;
			((units _apcGroup) select 1) assignAsGunner _apc;
			((units _apcGroup) select 2) assignAsCommander _apc;
			((units _apcGroup) select 0) moveInDriver _apc;
			((units _apcGroup) select 1) moveInGunner _apc;
			((units _apcGroup) select 2) moveInCommander _apc;

		[_apcGroup, getMarkerPos currentAO, 600] call BIS_fnc_taskPatrol;
		[(units _apcGroup)] call QS_fnc_setSkill2;
		_apc lock 3;
		
		_enemiesArray = _enemiesArray + [_apcGroup];
	};	

	for "_x" from 1 to PARAMS_ArmourPatrol do {
		_armourGroup = createGroup east;
		_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 2)],[]],["water","out"]] call BIS_fnc_randomPos;
		if(random 1 <= 0.5) then {_armour = "O_MBT_02_cannon_F" createVehicle _randomPos} else {_armour = "I_MBT_03_cannon_F" createVehicle _randomPos};
		waitUntil{!isNull _armour};

			"O_officer_F" createUnit [_randomPos,_armourGroup];
			"O_soldier_repair_F" createUnit [_randomPos,_armourGroup];
			"O_officer_F" createUnit [_randomPos,_armourGroup];
			"O_Soldier_repair_F" createUnit [_randomPos, _armourGroup];
			"O_Soldier_LAT_F" createUnit [_randomPos, _armourGroup];
			"O_Soldier_AR_F" createUnit [_randomPos, _armourGroup];
			"O_Soldier_AR_F" createUnit [_randomPos, _armourGroup];
			((units _armourGroup) select 0) assignAsDriver _armour;
			((units _armourGroup) select 1) assignAsGunner _armour;
			((units _armourGroup) select 2) assignAsCommander _armour;
			((units _armourGroup) select 0) moveInDriver _armour;
			((units _armourGroup) select 1) moveInGunner _armour;
			((units _armourGroup) select 2) moveInCommander _armour;
		
		[_armourGroup, getMarkerPos currentAO, 400] call BIS_fnc_taskPatrol;
		[(units _armourGroup)] call QS_fnc_setSkill2;
		_armour lock 3;
		
		_enemiesArray = _enemiesArray + [_armourGroup];
	};
	
	for "_x" from 1 to PARAMS_AAPatrol do {
		_aaGroup = createGroup east;
		_randomPos = [[[getMarkerPos currentAO, (PARAMS_AOSize / 2)],[]],["water","out"]] call BIS_fnc_randomPos;
		_aa = "O_APC_Tracked_02_AA_F" createVehicle _randomPos;
		waitUntil{!isNull _aa};

			"O_officer_F" createUnit [_randomPos,_aaGroup];
			"O_soldier_repair_F" createUnit [_randomPos,_aaGroup];
			"O_officer_F" createUnit [_randomPos,_aaGroup];
			"O_Soldier_repair_F" createUnit [_randomPos, _aaGroup];
			"O_Soldier_F" createUnit [_randomPos, _aaGroup];
			((units _aaGroup) select 0) assignAsDriver _aa;
			((units _aaGroup) select 1) assignAsGunner _aa;
			((units _aaGroup) select 2) assignAsCommander _aa;
			((units _aaGroup) select 0) moveInDriver _aa;
			((units _aaGroup) select 1) moveInGunner _aa;
			((units _aaGroup) select 2) moveInCommander _aa;
		
		[_aaGroup, getMarkerPos currentAO, 500] call BIS_fnc_taskPatrol;
		[(units _aaGroup)] call QS_fnc_setSkill4;
		_aa lock 3;
		
		_enemiesArray = _enemiesArray + [_aaGroup];
	};

	if((random 10 <= PARAMS_AirPatrol)) then {
		_airGroup = createGroup east;
		_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize],[]],["water","out"]] call BIS_fnc_randomPos;
		_airType = ["O_Heli_Attack_02_F","I_Heli_light_03_F"] call BIS_fnc_selectRandom;
		_air = _airType createVehicle [_randomPos select 0,_randomPos select 1,1000];
		waitUntil{!isNull _air};
		_air engineOn true;
		_air lock 3;
		_air setPos [_randomPos select 0,_randomPos select 1,300];

		_air spawn
		{
			private["_x"];
			for [{_x=0},{_x<=200},{_x=_x+1}] do
			{
				_this setVelocity [0,0,0];
				sleep 0.1;
			};
		};

		"O_helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 0) assignAsDriver _air;
		((units _airGroup) select 0) moveInDriver _air;
		"O_helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 1) assignAsGunner _air;
		((units _airGroup) select 1) moveInGunner _air;

		[_airGroup, getMarkerPos currentAO, 800] call BIS_fnc_taskPatrol;
		_air flyInHeight 300;
		[(units _airGroup)] call QS_fnc_setSkill4;
		
		_enemiesArray = _enemiesArray + [_airGroup];
	};

	if((random 10 <= PARAMS_AirPatrol)) then {
		_airGroup = createGroup east;
		_randomPos = [[[getMarkerPos currentAO, PARAMS_AOSize],[]],["water","out"]] call BIS_fnc_randomPos;
		_airType = ["O_Heli_Attack_02_F","I_Heli_light_03_F"] call BIS_fnc_selectRandom;
		_air = _airType createVehicle [_randomPos select 0,_randomPos select 1,1000];
		waitUntil{!isNull _air};
		_air engineOn true;
		_air lock 3;
		_air setPos [_randomPos select 0,_randomPos select 1,300];

		_air spawn
		{
			private["_x"];
			for [{_x=0},{_x<=200},{_x=_x+1}] do
			{
				_this setVelocity [0,0,0];
				sleep 0.1;
			};
		};

		"O_helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 0) assignAsDriver _air;
		((units _airGroup) select 0) moveInDriver _air;
		"O_helipilot_F" createUnit [_randomPos,_airGroup];
		((units _airGroup) select 1) assignAsGunner _air;
		((units _airGroup) select 1) moveInGunner _air;

		[_airGroup, getMarkerPos currentAO, 800] call BIS_fnc_taskPatrol;
		_air flyInHeight 300;
		[(units _airGroup)] call QS_fnc_setSkill4;
		
		_enemiesArray = _enemiesArray + [_airGroup];
	};
	
	{
		_newGrp = [_x] call QS_fnc_garrisonBuildings;
		if (!isNull _newGrp) then { _enemiesArray = _enemiesArray + [_newGrp]; };
	} forEach (getMarkerPos currentAO nearObjects ["House", 800]);
	
	_enemiesArray;