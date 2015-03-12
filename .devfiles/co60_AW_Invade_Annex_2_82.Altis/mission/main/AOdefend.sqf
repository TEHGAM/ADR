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

private ["_pos","_rad","_survivors","_type"];

sleep 1;

if(random 1 >= 0.35) then {
	
	_defendMessages = [
		"OPFOR Forces incoming! Seek cover immediately and defend the objective area!",
		"The enemy managed to call in reinforcements! Form a perimeter around the objective area!"
	];
	_targetStartText = format [
		"<t align='center' size='2.2'>Defend Target</t><br/><t size='1.5' align='center' color='#0d4e8f'>%1</t><br/>____________________<br/>We have a problem. The enemy managed to call in land reinforcements. They are on the way to take back the last target. You need to defend it at all cost!",
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
		"<t size='1.5' align='left' color='#C92626'>Enemy attacking %1!</t><br/><br/>____________________<br/>Get ready boys they are almost here!", currentAO
	];

	_defendTimer1 = 480;			// 480
	_defendTimer2 = random 120;		// 120
	
	GlobalHint = _playersOnlineHint; publicVariable "GlobalHint"; hint parseText GlobalHint;

	sleep 10;

	hqSideChat = _defendMessages call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;

	_type = [1,2,3];
	_selectedType = _type select (floor (random (count _type)));
	
	if (_selectedType == 1) then {
		null = [["aoCircle_2"],[6,5],[3,2],[0],[1,0],[0,0,EAST],[0,1,120,FALSE,true]] call Bastion_Spawn;
	};
	if (_selectedType == 2) then {
		null = [["aoCircle_2"],[6,5],[3,2],[0],[2,0],[0,0,EAST],[0,1,120,FALSE,true]] call Bastion_Spawn;
	};
	if (_selectedType == 3) then {
		null = [["aoCircle_2"],[6,5],[3,2],[3],[1,0],[0,0,EAST],[0,1,120,FALSE,true]] call Bastion_Spawn;
	};
		
	hint "Thermal images show enemy are at the perimeter of the AO!";
			
	sleep 5;
			
	hqSideChat = "Assault will end in approximately 10 minutes."; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
			
	sleep _defendTimer1;
		
	hqSideChat = "The attack is almost over!"; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
	
	sleep _defendTimer2;

	[["aoCircle_2"]] call EOS_deactivate;
};