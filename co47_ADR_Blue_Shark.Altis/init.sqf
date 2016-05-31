call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf";
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";
[] execVM "scripts\DOM_squad\init.sqf";
if (isDedicated) exitWith { "addToScore" addPublicVariableEventHandler { ((_this select 1) select 0) addScore ((_this select 1) select 1); }; }; // Относится к скрипту =BTC=_revive

// Hide objects
((getMarkerPos "respawn_west") nearestObject 492373) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 492374) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 492375) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 492438) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491581) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491662) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491661) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 490022) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491653) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491656) hideObject true; 

((getMarkerPos "respawn_pilot") nearestObject 491093) allowDamage false; 
((getMarkerPos "respawn_pilot") nearestObject 491010) allowDamage false; 
((getMarkerPos "respawn_pilot") nearestObject 493386) allowDamage false; 
((getMarkerPos "respawn_west") nearestObject 492364) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 492365) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 492366) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 492369) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 492372) hideObject true; 

((getMarkerPos "respawn_west") nearestObject 491600) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 492403) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 492402) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491655) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491654) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491598) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491599) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491597) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491561) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491560) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491562) hideObject true; 
((getMarkerPos "respawn_west") nearestObject 491593) hideObject true; 

[solder1,"BRIEFING"] call BIS_fnc_ambientAnim;
[solder2,"LEAN"] call BIS_fnc_ambientAnim;
[solder3,"GUARD"] call BIS_fnc_ambientAnim;
[solder4,"LISTEN_BRIEFING"] call BIS_fnc_ambientAnim;
[solder5,"LISTEN_BRIEFING"] call BIS_fnc_ambientAnim;
[solder6,"LISTEN_BRIEFING"] call BIS_fnc_ambientAnim;
[Injured1,"PRONE_INJURED"] call BIS_fnc_ambientAnim;
[Injured2,"PRONE_INJURED"] call BIS_fnc_ambientAnim;
[Injured3,"PRONE_INJURED"] call BIS_fnc_ambientAnim;
[medic1,"REPAIR_VEH_KNEEL"] call BIS_fnc_ambientAnim;
[repair1,"REPAIR_VEH_PRONE"] call BIS_fnc_ambientAnim;