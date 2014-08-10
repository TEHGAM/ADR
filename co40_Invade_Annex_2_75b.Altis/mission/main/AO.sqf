/*
@file: AO.sqf
Author: Rarek [AW] & Quiksilver
Last modified: 8/04/2014 by Quiksilver

Description:

	Main AO

To do:
	Random enemy composition
	Other secret squirrel stuff
_________________________________________________*/

private ["_pos","_i","_position","_flatPos","_roughPos","_targetStartText","_targets","_dt","_enemiesArray","_radioTowerDownText","_targetCompleteText","_null","_mines","_chance"];


//---------------------------------------------- AO location marker array

_targets = [
	"Pyrsos","Sofia Radar Station","Research Facility","Feres","Skopos Castle","Zaros Power Station","Factory","Syrta","Zaros","Chalkeia","Aristi Turbines","Dump","Frini","Limni","Rodopoli","Charkia","Alikampos","Neochori","Eginio","Agios Dionysios","Paros","Molos","Didymos Turbines","Delfinaki Outpost","Panochori","The Stadium","Negades","Abdera","Kore","Oreokastro","Dorida","Galati Outpost","Frini Woodlands","Nidasos Woodlands","Sofia Powerplant","Gatolia Solar Farm","Vikos Outpost","Sagonisi Outpost","Panagia","Selakano Outpost","Athira","Fotia Turbines","Athanos","Lakka","Faronaki"
];

//----------------------------------------------- Set a few blank variables for event handlers

eastSide = createCenter EAST;
radioTowerAlive = false;
currentAOUp = false;
refreshMarkers = true;
currentAO = "Nothing";
publicVariable "currentAO";

//----------------------------------------------- AO MAIN SEQUENCE

while { true } do {
	
	sleep 10;

	//------------------------------------------- Set new current AO
	
	currentAO = _targets call BIS_fnc_selectRandom;

	//------------------------------------------ Set currentAO for JIP updates
	
	publicVariable "currentAO";
	currentAOUp = true;
	publicVariable "currentAOUp";

	//------------------------------------------ Edit and place markers for new target
	
	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle","aoMarker"];
	"aoMarker" setMarkerText format["Take %1",currentAO];
	sleep 5;
	publicVariable "refreshMarkers";

	//------------------------------------------ Create AO detection trigger
	
	_dt = createTrigger ["EmptyDetector", getMarkerPos currentAO];
	_dt setTriggerArea [PARAMS_AOSize, PARAMS_AOSize, 0, false];
	_dt setTriggerActivation ["EAST", "PRESENT", false];
	_dt setTriggerStatements ["this","",""];

	//------------------------------------------ Spawn enemies
	
	_enemiesArray = [currentAO] call QS_fnc_spawnUnits;

	//------------------------------------------ Spawn radiotower
	
	_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
	_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
	
	while {(count _flatPos) < 1} do {
		_position = [[[getMarkerPos currentAO, PARAMS_AOSize],_dt],["water","out"]] call BIS_fnc_randomPos;
		_flatPos = _position isFlatEmpty[3, 1, 0.3, 30, 0, false];
	};
	
	_roughPos = 
	[
		((_flatPos select 0) - 200) + (random 400),
		((_flatPos select 1) - 200) + (random 400),
		0
	];

	radioTower = "Land_TTowerBig_2_F" createVehicle _flatPos;
	waitUntil {sleep 0.5; alive radioTower};
	radioTower setVectorUp [0,0,1];
	radioTowerAlive = true;
	publicVariable "radioTowerAlive";
	{ _x setMarkerPos _roughPos; } forEach ["radioMarker", "radioCircle"];

	//-----------------------------------------------Spawn minefield
	
	
	_chance = random 10;
	if (_chance < PARAMS_RadioTowerMineFieldChance) then {
	
		_mines = [_flatPos] call QS_fnc_minefield;
		_enemiesArray = _enemiesArray + _mines;
		"radioMarker" setMarkerText "Radiotower (Minefield)";
	} else {
		"radioMarker" setMarkerText "Radiotower";
	};
	publicVariable "radioTower";

	//------------------------------------------- Set target start text
	
	_targetStartText = format
	[
		"<t align='center' size='2.2'>New Target</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>We did a good job with the last target, lads. I want to see the same again. Get yourselves over to %1 and take 'em all down!<br/><br/>Remember to take down that radio tower to stop the enemy from calling in CAS.",
		currentAO
	];

	//-------------------------------------------- Show global target start hint
	
	GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewMain", currentAO]; publicVariable "showNotification";
	showNotification = ["NewSub", "Destroy the enemy radio tower."]; publicVariable "showNotification";

	//-------------------------------------------- Enemy Reinforcement CAS
	
	if (PARAMS_AOReinforcementJet == 1) then { _null = [] execVM "mission\priority\CAS.sqf"; };				
	
	//-------------------------------------------- Wait for target completion
	
	waitUntil {sleep 5; count list _dt > PARAMS_EnemyLeftThreshhold};
	waitUntil {sleep 0.5; !alive radioTower};
	radioTowerAlive = false;
	publicVariable "radioTowerAlive";
	"radioMarker" setMarkerPos [-10000,-10000,-10000];
	"radioCircle" setMarkerPos [-10000,-10000,-10000];
	_radioTowerDownText =
		"<t align='center' size='2.2'>Radio Tower</t><br/><t size='1.5' color='#08b000' align='center'>DESTROYED</t><br/>____________________<br/>The enemy radio tower has been destroyed! Fantastic job, lads!<br/><br/><t size='1.2' color='#08b000' align='center'> The enemy cannot call in air support now!</t><br/>";
	GlobalHint = _radioTowerDownText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["CompletedSub", "Enemy radio tower destroyed."]; publicVariable "showNotification";

	waitUntil {sleep 5; count list _dt < PARAMS_EnemyLeftThreshhold};

	_targets = _targets - [currentAO];

	publicVariable "refreshMarkers";
	currentAOUp = false;
	publicVariable "currentAOUp";

	//--------------------------------------------- Delete detection trigger and markers
	
	deleteVehicle _dt;
	radioTowerAlive = true;
	publicVariable "radioTowerAlive";

	//---------------------------------------------- Small sleep to let deletions process
	
	sleep 5;

	//---------------------------------------------- Set target completion text
	
	_targetCompleteText = format
	[
		"<t align='center' size='2.2'>Target Taken</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/><t align='left'>Fantastic job taking %1, boys! Give us a moment here at HQ and we'll line up your next target for you.</t>",
		currentAO
	];

	{_x setMarkerPos [-10000,-10000,-10000];} forEach ["aoCircle","aoMarker","radioCircle"];

	//------------------------------------------------- Show global target completion hint
	
	GlobalHint = _targetCompleteText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["CompletedMain", currentAO]; publicVariable "showNotification";

	//------------------------------------------------- Delete enemies
	
	[_enemiesArray] spawn QS_fnc_deleteOldAOUnits;

	//------------------------------------------------- AI Retaliation by Jester [AW] and Quiksilver
	
	if (PARAMS_DefendAO == 1) then {
		_aoUnderAttack = [] execVM "mission\main\AOdefend.sqf";
		waitUntil {scriptDone _aoUnderAttack};
	};
	
	publicVariable "refreshMarkers";
	currentAOUp = false;
	publicVariable "currentAOUp";

	//---------------------------------------------------- Delete detection trigger and markers
	
	deleteVehicle _dt;

	//---------------------------------------------------- Small sleep to let deletions process
	
	sleep 1;

	//----------------------------------------------------- Set target completion text
	
	_targetCompleteText = format
	[
		"<t align='center' size='2.2'>Target Defended</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Fantastic job defending %1, boys! Give us a moment here at HQ and we'll line up your next target for you.</t>",
		currentAO
	];

	{_x setMarkerPos [-10000,-10000,-10000];} forEach ["aoCircle_2","aoMarker_2"];

	//----------------------------------------------------- Show global target completion hint
	
	GlobalHint = _targetCompleteText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["CompletedMainDefended", currentAO]; publicVariable "showNotification";
	
	sleep 5;
};