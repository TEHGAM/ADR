/*
Author: 

	Jester [AW] & Quiksilver

Last modified: 

	16/04/2014 by QS
	
Description:

	When AO is complete, a chance that OPFOR will counterattack.
	
	Create AO detection trigger
	At end of sequence, count WEST.
	if (WEST < 1) exitWith {lost};
	if (WEST > 0) exitWith (held);
	
	Also, APCs spawned with EOS do not engage for whatever reason
_______________________________________________________*/

sleep 5;

if(random 1 >= 0) then {
	
	_defendMessages = [
		"Вражеские силы на подходе! Ищите укрытие и защищайте зону задания!",
		"Врагу удалось вызвать подкрепление! Сформируйте защитный преиметр вокруг цели!"
	];
	_targetStartText = format [
		"<t align='center' size='2.2'>Защитить цель.</t><br/><t size='1.5' align='center' color='#0d4e8f'>%1</t><br/>____________________<br/>У нас проблемы. Врагу удалось вызвать подкрепление. Они возвращаются к последней цели.Вы должны защитить ее любой ценой!",
		currentAO
	];

	GlobalHint = _targetStartText; publicVariable "GlobalHint"; hint parseText GlobalHint;
	showNotification = ["NewMainDefend", currentAO]; publicVariable "showNotification";

	{_x setMarkerPos (getMarkerPos currentAO);} forEach ["aoCircle_2","aoMarker_2"];
	"aoMarker_2" setMarkerText format["Defend %1",currentAO];

	sleep 10;
	//publicVariable "refreshMarkers";
	publicVariable "currentAO";
	currentAOUp = true; publicVariable "currentAOUp";
	radioTowerAlive = false; publicVariable "radioTowerAlive";

	_playersOnlineHint = format [
		"<t size='1.5' align='left' color='#C92626'>Враг атакует! %1!</t><br/><br/>____________________<br/>Приготовьтесь, они совсем рядом!", currentAO
	];

	_defendTimer1 = 480;
	_defendTimer2 = random 120;
	
	GlobalHint = _playersOnlineHint; publicVariable "GlobalHint"; hint parseText GlobalHint;

	sleep 10;

	hqSideChat = _defendMessages call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

	null = [["aoCircle_2"],[6,5],[3,2],[0],[1,0],[0,0,EAST],[0,1,120,FALSE,true]] call Bastion_Spawn;
	
	hint "Термальные сканеры показывают присутствие противника в зоне боевых действий!";
			
	sleep 5;
			
	hqSideChat = "Атака продолжится еще примерно 10 минут."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
			
	sleep _defendTimer1;
		
	hqSideChat = "Атака почти завершена!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

	sleep _defendTimer2;

	[["aoCircle_2"]] call EOS_deactivate;
};
