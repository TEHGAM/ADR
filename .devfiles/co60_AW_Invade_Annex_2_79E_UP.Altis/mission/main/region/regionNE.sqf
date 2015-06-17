/*
Author: 

	Quiksilver

Last modified: 

	2/05/2014

Description:

	North-East Theater
	
Notes:
	
	_targets = ["Sofia Radar Station","Research Facility","Limni","Paros","Molos","Delfinaki Outpost","Nidasos Woodlands","Sofia Powerplant","Gatolia Solar Farm","Molos Airfirld","Ghost Hotel","Kalithea"];

______________________________________________*/

private ["_target1","_target2","_target3","_targetArray","_pos","_i","_position","_flatPos","_roughPos","_targetStartText","_targets","_targetsLeft","_dt","_enemiesArray","_unitsArray","_radioTowerDownText","_targetCompleteText","_regionCompleteText","_null","_mines","_chance"];
eastSide = createCenter east;

//---------------------------------------------- AO location marker array

_targets = ["Sofia Radar Station","Research Facility","Limni","Paros","Almira","Molos","Delfinaki Outpost","Nidasos Woodlands","Sofia Powerplant","Gatolia Solar Farm","Molos Airfirld","Ghost Hotel","Kalithea"];

//----------------------------------------------- SELECT A FEW RANDOM AOs

_target1 = _targets call BIS_fnc_selectRandom;
_targets = _targets - [_target1];
_target2 = _targets call BIS_fnc_selectRandom;
_targets = _targets - [_target2];
_target3 = _targets call BIS_fnc_selectRandom;

_targetArray = [_target1,_target2,_target3];

//----------------------------------------------- AO MAIN SEQUENCE

while { count _targetArray > 0 } do {
	
	sleep 1;

	//------------------------------------------- Set new current AO

	currentAO = _targetArray call BIS_fnc_selectRandom;

	//------------------------------------------ Edit and place markers for new target
	
	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle","aoMarker"];
	"aoMarker" setMarkerText format["Захватить: %1",currentAO];
	sleep 1;

	//------------------------------------------ Create AO detection trigger
	
	_dt = createTrigger ["EmptyDetector", getMarkerPos currentAO];
	_dt setTriggerArea [PARAMS_AOSize, PARAMS_AOSize, 0, false];
	_dt setTriggerActivation ["EAST", "PRESENT", false];
	_dt setTriggerStatements ["this","",""];

	//------------------------------------------ Spawn enemies
	
	sleep 5;
	_enemiesArray = [currentAO] call QS_fnc_AOenemy;

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
	waitUntil { sleep 0.5; alive radioTower };
	radioTower setVectorUp [0,0,1];
	radioTowerAlive = true; publicVariable "radioTowerAlive";
	{ _x setMarkerPos _roughPos; } forEach ["radioMarker", "radioCircle"];

	//-----------------------------------------------Spawn minefield
	
	_chance = random 10;
	if (_chance < PARAMS_RadioTowerMineFieldChance) then {
	
		_unitsArray = [_flatPos] call QS_fnc_AOminefield;
	
		"radioMarker" setMarkerText "Радиовышка (мины)";
	} else {
		"radioMarker" setMarkerText "Радиовышка";
	};
	publicVariable "radioTower";

	{
		_x addCuratorEditableObjects [[radioTower], false];
	} foreach allCurators;

	//------------------------------------------- Set target start text
	
	_targetStartText = format
	[
		"<t align='center' size='2.2'>Захватить</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Начинайте наступление.<br/><br/>Уничтожив радиовышку вы устраните их возможность на вызов авиаподдержки.",
		currentAO
	];

	//-------------------------------------------- Show global target start hint
	
	GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewMain", currentAO]; publicVariable "showNotification";
	showNotification = ["NewSub", "Уничтожить радиовышку противника"]; publicVariable "showNotification";		
	
	//-------------------------------------------- CORE LOOP
	
	currentAOUp = true; publicVariable "currentAOUp";
	
			if (PARAMS_AOReinforcementJet == 1) then {
		[] spawn {
			sleep (30 + (random 180));
			if (alive radioTower) then {
				while {(alive radioTower)} do {
					[] call QS_fnc_enemyCAS;
					sleep (480 + (random 480));
				};
			};
		};
	};
	
	waitUntil {sleep 3; !alive radioTower};
	
	//--------------------------------------------- RADIO TOWER DESTROYED
	
	radioTowerAlive = false; publicVariable "radioTowerAlive";
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];
	_radioTowerDownText = "<t align='center' size='2.2'>Радиовышка</t><br/><t size='1.5' color='#08b000' align='center'>Уничтожена</t><br/>____________________<br/><t size='1.2' color='#08b000' align='center'>Теперь противник не сможет вызвать авиаподдержку.</t><br/>";
	GlobalHint = _radioTowerDownText; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["CompletedSub", "Радиовышка уничтожена!"]; publicVariable "showNotification";
	
	//---------------------------------------------- WHEN ENEMIES KILLED

	waitUntil {sleep 5; count list _dt < PARAMS_EnemyLeftThreshhold};
	
	currentAOUp = false; publicVariable "currentAOUp";
	
	_targetArray = _targetArray - [currentAO];

	//---------------------------------------------- DE-BRIEF 1
	
	sleep 3;
	_targetCompleteText = format ["<t align='center' size='2.2'>Захватили</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/><t align='left'>Хорошая работа! %1, мужики! Возвращайтесь на базу для перегруппировки на следующее задание.</t>",currentAO];
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["aoCircle","aoMarker","radioCircle"];
	GlobalHint = _targetCompleteText; hint parseText GlobalHint; publicVariable "GlobalHint";
	showNotification = ["CompletedMain", currentAO]; publicVariable "showNotification";

	//------------------------------------------------- DELETE
	
	deleteVehicle _dt;
	[_enemiesArray] spawn QS_fnc_AOdelete;
	if (_chance < PARAMS_RadioTowerMineFieldChance) then {[_unitsArray] spawn QS_fnc_AOdelete;};

	//------------------------------------------------- DEFEND AO
	
	if (PARAMS_DefendAO == 1) then {
		_aoUnderAttack = [] execVM "mission\main\AOdefend.sqf";
		waitUntil {scriptDone _aoUnderAttack};
	};
	{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["aoCircle_2","aoMarker_2"];

	//----------------------------------------------------- DE-BRIEF
	
	_targetCompleteText = format ["<t align='center' size='2.2'>Удержали</t><br/><t size='1.5' align='center' color='#00FF80'>%1</t><br/>____________________<br/><t align='left'>Начинайте перегруппировку сил.</t>",currentAO];
	GlobalHint = _targetCompleteText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	
	//----------------------------------------------------- MAINTENANCE
	
	_aoClean = [] execVM "scripts\misc\clearItemsAO.sqf";
	waitUntil {
		scriptDone _aoClean
	};
	sleep 20;
};