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

if(1 >= 0.5) then {
	
	_defendMessages = [
		"Вражеские силы наступают. Займите оборонительные укрытия для защиты места дислокации!",
		"Противник вызвал подкрепление. Распределите оборону по периметру основной цели!"
	];
	_targetStartText = format [
		"<t align='center' size='2.2'>ЗАЩИТА ТОЧКИ</t><br/><t size='1.5' align='center' color='#0d4e8f'>%1</t><br/>____________________<br/>Ситуация осложнилась! Противнику удалось вызвать наземное подкрепление. Враг намерен отбить территорию ранее освобожденную нашими силами. Ваш приказ - оборонять позицию любой ценой!",
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
		"<t size='1.5' align='left' color='#C92626'>Враг атакует  %1!</t><br/><br/>____________________<br/>Держитесь, ребята! Противник начинает штурм.", currentAO
	];

	_defendTimer1 = 900;
	_defendTimer2 = random 120;
	
	GlobalHint = _playersOnlineHint; publicVariable "GlobalHint"; hint parseText GlobalHint;

	sleep 30;

	hqSideChat = _defendMessages call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

	null = [["aoCircle_2"],[6,5],[3,2],[0],[1,0],[0,0,EAST],[0,1,120,FALSE,true]] call Bastion_Spawn;
	
	hint "Разведывательные снимки подтвердили наличие врага в периметре главной цели!";
			
	sleep 5;
			
	hqSideChat = "Разведка докладывает что противник понес значительные потери при осаде наших укреплений и начинает перегрупировку сил в течении последующих 15 минут."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
			
	sleep _defendTimer1;
		
	hqSideChat = "Штурм почти полностью подавлен, враг уходит в отступление."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

	sleep _defendTimer2;

	[["aoCircle_2"]] call EOS_deactivate;
};
