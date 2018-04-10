/*
author: stanhope
description: small anti-script-kids-script
*/

naughtyAction1 = { 
	_name = name player;
	_text = format ["Player %1 (%2) was kicked for hacking.", _name, getPlayerUID player];
	[_text] remoteExec ["diag_log", 2];
	_text = format ["Player %1 has been kicked for possibly hacking.  Please notify an admin so he can check if the server is still fine.", _name];
	[player, _text] remoteExecCall ["sideChat", 0, false];
	kickPlayerLocal = {[_this select 0] call kickPlayer;};
	[[_name], kickPlayerLocal] remoteExecCall ["call", 2];
};
naughtyAction2 = { 
	_name = name player;
	_text = format ["Player %1 (%2) was banned for hacking.", _name, getPlayerUID player];
	[_text] remoteExec ["diag_log", 2];
	_text = format ["Player %1 has been banned for hacking.  Please notify an admin so he can check if the server is still fine.", _name];
	[player, _text] remoteExecCall ["sideChat", 0, false];
	banPlayerLocal = {[_this select 0] call banPlayer;};
	[[_name], banPlayerLocal] remoteExecCall ["call", 2];
};
playerDamageDisabledCount = 0;
playerExcessiveSpeedCount = 0;
playerHiddenCount = 0;

naughtyCheck = {
	sleep random 60;

	if ((unitRecoilCoefficient player) <= 0.9) then {
		[] spawn naughtyAction2;
	};
	sleep 0.1;
	
	if ((unitRecoilCoefficient player) > 2) then {
		player setUnitRecoilCoefficient 1; 
	};
	sleep 0.1;
	
	if (!isDamageAllowed player && lifeState player != "INCAPACITATED") then {
		if (player getVariable "isZeus") exitWith {};
		playerDamageDisabledCount = playerDamageDisabledCount + 1;
		[] spawn { sleep 600; playerDamageDisabledCount = playerDamageDisabledCount - 1;};
		if (playerDamageDisabledCount > 4) then {
			[] spawn naughtyAction1;
		}
	};
	sleep 0.1;
	
	if (isObjectHidden player) then {
		playerHiddenCount = playerHiddenCount + 1;
		[] spawn {sleep 600; playerHiddenCount = playerHiddenCount - 1;};
		if (playerHiddenCount > 1) then {
			[] spawn naughtyAction2;
		};

	};
	
	(uinamespace getvariable "BIS_AAN") closedisplay 1;
	sleep 0.1;
	
	onEachFrame{};
	sleep 0.1;
	
	if (vehicle player == player) then {
		_vel = velocity player;
		{
			if ((_vel select _x) > 10) then {
				playerExcessiveSpeedCount = playerExcessiveSpeedCount + 1;
				[] spawn naughtyAction1;
			};
		} forEach [0,1,2];
		if (playerExcessiveSpeedCount > 4) then {
			[] spawn { sleep 600; playerExcessiveSpeedCount = playerExcessiveSpeedCount - 1;};
		};
	};
	sleep 0.1;
};


if !(player getVariable "isZeus") then {
	player addEventHandler ["GetOutMan", {[] spawn naughtyCheck;}];
	player addEventHandler ["InventoryOpened", {[] spawn naughtyCheck; false}];
	player addEventHandler ["firedMan", {[] spawn naughtyCheck;}];

	while {true} do {
		sleep (240 + (random 120));
		[] spawn naughtyCheck;
	};
};



