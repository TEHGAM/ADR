/*
@filename: init.sqf
Author:
	
	Quiksilver

Last modified:

	12/05/2014
	
Description:

	Things that may run on both server and client.
	Deprecated initialization file, still using until the below is correctly partitioned between server and client.
______________________________________________________*/


call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";
[] execVM "scripts\DOM_squad\init.sqf";
if (isDedicated) exitWith { "addToScore" addPublicVariableEventHandler { ((_this select 1) select 0) addScore ((_this select 1) select 1); }; }; // Относится к скрипту =BTC=_revive

while {true} do {
sleep 3;
reservedUnits = [zeus1, zeus2, zeus3]; // Name of the playable soldier.
reservedUIDs = ["76561198017758762","76561198062030976","76561198053877632","76561198074604871","76561198163722032","76561198015092620"]; //UIDs obviously
 
waitUntil {alive player};
if (player in reservedUnits) then {
    if ((getPlayerUID player) in reservedUIDs ) then {
        hint "Вы можете использовать этот слот.";} 
	else {endMission "END1";};
};
};