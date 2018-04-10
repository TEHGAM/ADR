/*
 Author: BACONMOP
 Description: Main selector for the main AO's

Last edited: 22/1/18 by stanhope

edited: reworked for persistant storage
 
 */
if (time < 120) then {
	//set some stuff up but only if the server hasn't been up for more than 2 minutes

	jetCounter = 0;

	controlledZones = profileNamespace getVariable ["controlledZones", ["BASE"]];
	capturedFOBs = profileNamespace getVariable ["capturedFOBs", []];
	
	if ((count controlledZones) >= amountOfAOsToComplete) then {
		controlledZones = ["BASE"];
		capturedFOBs = [];
	};
	
	_currentAOIndex = (count controlledZones) - 1;
	currentAO = controlledZones select _currentAOIndex;
	publicVariable "controlledZones";
	
	if ((count capturedFOBs) > 0) then {
		{
			_base = _x;
			[_base] spawn { 
				_base = _this select 0;
				[_base] call AW_fnc_BaseManager; 
			};
		} forEach capturedFOBs;
	};
	publicVariable "capturedFOBs";
};

restartServerAfterThisAO = false;
publicVariable "restartServerAfterThisAO";

manualAO = "";
publicVariable "manualAO";

missionActive = true;

while {missionActive} do {

	// Select Location --------------------------------------
	currentAO = [currentAO] call AW_fnc_getAo;
    
    //reset manualAO
    manualAO = ""; 
	
	//Spawn Enemies -----------------------------------------
	_pos = getMarkerPos currentAO;
	_mainAOUnits = [_pos] call derp_fnc_mainAOSpawnHandler;

	//Spawn Markers and Notifications -----------------------
	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle","aoMarker"];
	_name = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "name") call BIS_fnc_getCfgData;
	{_x setMarkerText _name;} forEach ["aoMarker"];

	_targetStartText = format[
		"<t align='center' size='2.2'>New Target</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Good work on that last OP. I want to see the same again. We have a new objective you you. High Command has decided that %1 is of strategic value.<br/><br/>Don't forget about the secondary targets.",
		_name
	];
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

    _mainAoTaskName = format ["Take %1", _name];
    _mainAoTaskDesc = format ["Clear %1 of hostile forces.", _name];
    [west,["MainAoTask"],[_mainAoTaskDesc,_mainAoTaskName,currentAO],(getMarkerPos currentAO),"Created",0,true,"attack",true] call BIS_fnc_taskCreate;

	sleep 10;

	//Spawn Sub-Obj -----------------------------------------
	subObjComplete = 0;
	subObjScript = [] execVM "Missions\Main\SubObj.sqf";

	//Checks for Ao still Active ----------------------------
	switch(mainSide) do{
		case "east":{
			mainMissionTreshold = createTrigger ["EmptyDetector", getMarkerPos currentAO];
			mainMissionTreshold setTriggerArea [800, 800, 0, false];
			mainMissionTreshold setTriggerActivation ["EAST", "PRESENT", false];
			mainMissionTreshold setTriggerStatements ["this","",""];
		};
		case "resistance":{
			mainMissionTreshold = createTrigger ["EmptyDetector", getMarkerPos currentAO];
			mainMissionTreshold setTriggerArea [800, 800, 0, false];
			mainMissionTreshold setTriggerActivation ["GUER", "PRESENT", false];
			mainMissionTreshold setTriggerStatements ["this","",""];
		};
	};
	
	waitUntil {sleep 5; subObjComplete == 1 || !missionActive;};

	// Helicopter reinforcements when side is completed.
	_heliReinf = [currentAO, "airCavSpawnMarker", secondaryMainFaction] call AW_fnc_airCav;


	waitUntil {sleep 5;(count list mainMissionTreshold < PARAMS_EnemyLeftThreshhold) || !missionActive;};

	//Delete and Cleanup ------------------------------------

	controlledZones = controlledZones + [currentAO];
	publicVariable "controlledZones";
	deleteVehicle mainMissionTreshold;

	{
		if (!(isNull _x) && {alive _x}) then {
			deleteVehicle _x;
		};
	} foreach _mainAOUnits;
	{
		deleteVehicle _x;
	} foreach _heliReinf;

	/*
	if (reinforcementsSpawned == 1) then {
	};
	*/

	_type = (missionconfigfile >> "Main_Aos" >> "AOs" >> currentAO >> "type") call BIS_fnc_getCfgData;
	if (_type == "base") then {
		[] spawn { 
			[currentAO] call AW_fnc_BaseManager; 
			capturedFOBs pushBack currentAO;
			publicVariable "capturedFOBs";
		};
	};

	_targetStartText = format[
		"<t align='center' size='2.2'>Secured</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Good work out there. We have provided you with some light assets to help you redeploy to the next assignment.",
		_name
	];
    ["MainAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
    sleep 5;
    ["MainAoTask",west] call bis_fnc_deleteTask;
	[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["aoCircle","aoMarker"];
	reinforcementsSpawned = 0;
	sleep 10;
	
	//End Game ------------------------------------
	
	//85 Main AO's.
	_endMissionCheck = count controlledZones;
	if (_endMissionCheck >= amountOfAOsToComplete) then {
		missionActive = false;
		profileNamespace setVariable ["capturedFOBs", []];
		sleep 0.1;
		profileNamespace setVariable ["controlledZones", ["BASE"]];
		sleep 0.1;
		saveProfileNamespace;
		sleep 1;
		["End1",BIS_fnc_endMission] remoteExecCall["call", 0];
	};
	
	
	if (restartServerAfterThisAO) then {
		autoRestartEnabled = profileNamespace getVariable ["autoRestartEnabled", true];
		if (autoRestartEnabled) exitWith {
			missionActive = false;
			["afterAO"] execVM "Scripts\RestartScript.sqf";
		};
		[Quartermaster, [adminChannelID, "Server restart not executed"]] remoteExecCall ["customChat", 0, false];
	    [Quartermaster, [adminChannelID, "Automated server restart has been disabled by an admin"]] remoteExecCall ["customChat", 0, false];
	};
	
};
