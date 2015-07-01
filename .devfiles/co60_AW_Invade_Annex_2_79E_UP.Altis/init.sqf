call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";
[] execVM "scripts\DOM_squad\init.sqf";
[] execVM "scripts\tags\tags.sqf";
if (isDedicated) exitWith { "addToScore" addPublicVariableEventHandler { ((_this select 1) select 0) addScore ((_this select 1) select 1); }; }; // Относится к скрипту =BTC=_revive