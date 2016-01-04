/*
Author:

	Jester [AW] & Quiksilver

Last modified:

	16/04/2014 by QS

Description:

	When AO is complete, a chance that OPFOR will counterattack.

	Create AO detection trigger
	At end of sequence, count EAST.
	if (EAST < 1) exitWith {lost};
	if (EAST > 0) exitWith (held);

	Also, APCs spawned with EOS do not engage for whatever reason
_______________________________________________________*/

sleep 5;

if(random 1 >= 0.5) then {

	_defendMessages = [
		"Враг контратакует! Займите круговую оборону для защиты захваченной территории.",
		"Противник вызвал подкрепление!"
	];

	_targetStartText = format [
		"<t align='center' size='2.2'>Оборона</t><br/><t size='1.5' align='center' color='#0d4e8f'>%1</t><br/>____________________<br/>Враг контратакует! Займите оборонительные позиции!",
		currentAO
	];

	GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewMainDefend", currentAO]; publicVariable "showNotification";

	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle_2", "aoMarker_2"];
	"aoMarker_2" setMarkerText format["Оборона: %1", currentAO];

	sleep 10;
	//publicVariable "refreshMarkers";
	publicVariable "currentAO";
	currentAOUp = true; publicVariable "currentAOUp";
	radioTowerAlive = false; publicVariable "radioTowerAlive";

	_playersOnlineHint = format [
		"<t size='1.5' align='left' color='#C92626'>Контратака</t><br/><br/>____________________<br/>Противник перегруппировал часть своих сил на контратаку захваченной нами точки.",
		currentAO
	];

	_defendTimer1 = 600;
	_defendTimer2 = random 120;

	GlobalHint = _playersOnlineHint; publicVariable "GlobalHint"; hint parseText GlobalHint;

	sleep 10;

	hqSideChat = _defendMessages call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST, "HQ"] sideChat hqSideChat;

	// Determine the multiplier to increase amount of enemies during the defence phase, based on player count
	_playerCount = playersNumber WEST;
	_enemyMultiplier = _playerCount / 64 + 1;

	// Randomly choose from 4 different enemy compositions
	_type = [1, 2, 3, 4];
	_selectedType = _type select (floor (random (count _type)));

	// DEBUG
	//[format ["DEFENCE_DEBUG: _playerCount <%1> | _enemyMultiplier <%2> | _selectedType <%3>", _playerCount, _enemyMultiplier, _selectedType, _tower_dmg], "systemChat"] call BIS_fnc_MP;

	if (_selectedType == 1) then {
		null = [["aoCircle_2"],
		[round(3 * _enemyMultiplier), 2],	// Infantry [Number of groups, Groups size]
		[round(3 * _enemyMultiplier), 4],	// Light vehicles [Number of groups, Cargo size]
		[0],								// Armored vehicles [Numger of groups]
		[1, 0],								// Helicopters [Number of groups, Cargo size]
		[0, 0, EAST], [0, 1, 120, FALSE, true]] call Bastion_Spawn;
	};
	if (_selectedType == 2) then {
		null = [["aoCircle_2"],
		[round(2 * _enemyMultiplier), 2],	// Infantry [Number of groups, Groups size]
		[round(1 * _enemyMultiplier), 4],	// Light vehicles [Number of groups, Cargo size]
		[round(1 * _enemyMultiplier)],		// Armored vehicles [Numger of groups]
		[round(2.5 * _enemyMultiplier), 4],	// Helicopters [Number of groups, Cargo size]
		[0, 0, EAST], [0, 1, 120, FALSE, true]] call Bastion_Spawn;
	};
	if (_selectedType == 3) then {
		null = [["aoCircle_2"],
		[round(3 * _enemyMultiplier), 2],	// Infantry [Number of groups, Groups size]
		[round(2 * _enemyMultiplier), 4],	// Light vehicles
		[round(1 * _enemyMultiplier)],		// Armored vehicles
		[1, 0],								// Helicopters
		[0, 0, EAST], [0, 1, 120, FALSE, true]] call Bastion_Spawn;
	};
	if (_selectedType == 4) then {
		null = [["aoCircle_2"],
		[round(3 * _enemyMultiplier), 2],	// Infantry [Number of groups, Groups size]
		[round(1 * _enemyMultiplier), 4],	// Light vehicles [Number of groups, Cargo size]
		[round(1.5 * _enemyMultiplier)],	// Armored vehicles [Numger of groups]
		[round(1 * _enemyMultiplier), 4],	// Helicopters [Number of groups, Cargo size]
		[0, 0, EAST], [0, 1, 120, FALSE, true]] call Bastion_Spawn;
	};

	hint "В близи захваченной территории, обнаружены вражеские силы.";

	sleep 5;

	hqSideChat = "Обороняйтесь, противник начинает штурм!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

	sleep _defendTimer1;

	hqSideChat = "Атака врага отбита, противник отступает!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

	sleep _defendTimer2;

	[["aoCircle_2"]] call EOS_deactivate;
};
