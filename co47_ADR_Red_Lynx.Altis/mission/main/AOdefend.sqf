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

	hqSideChat = _defendMessages call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [EAST, "HQ"] sideChat hqSideChat;

	_type = [1, 2, 3, 4];
	_selectedType = _type select (floor (random (count _type)));

	if (_selectedType == 1) then {
		null = [["aoCircle_2"], [6, 2], [4, 4], [0], [1, 0], [1, 0, WEST], [0, 1, 120, FALSE, true]] call Bastion_Spawn;
	};
	if (_selectedType == 2) then {
		null = [["aoCircle_2"], [6, 2], [2, 4], [1], [4, 4], [1, 0, WEST], [0, 1, 120, FALSE, true]] call Bastion_Spawn;
	};
	if (_selectedType == 3) then {
		null = [["aoCircle_2"], [6, 2], [3, 4], [2], [1, 0], [1, 0, WEST], [0, 1, 120, FALSE, true]] call Bastion_Spawn;
	};
	if (_selectedType == 4) then {
		null = [["aoCircle_2"], [6, 2], [2, 4], [3], [2, 4], [1, 0, WEST], [0, 1, 120, FALSE, true]] call Bastion_Spawn;
	};

	hint "В близи захваченной территории, обнаружены вражеские силы.";

	sleep 5;

	hqSideChat = "Обороняйтесь, противник начинает штурм!"; publicVariable "hqSideChat"; [EAST,"HQ"] sideChat hqSideChat;

	sleep _defendTimer1;

	hqSideChat = "Атака врага отбита, противник отступает!"; publicVariable "hqSideChat"; [EAST,"HQ"] sideChat hqSideChat;

	sleep _defendTimer2;

	[["aoCircle_2"]] call EOS_deactivate;
};