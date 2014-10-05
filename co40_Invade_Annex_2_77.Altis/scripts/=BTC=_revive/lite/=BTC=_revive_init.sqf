/*
Created by =BTC= Giallustio

Visit us at: 
http://www.blacktemplars.altervista.org/
06/03/2012
*/

////////////////// EDITABLE \\\\\\\\\\\\\\\\\\\\\\\\\\
BTC_revive_time_min = 1;
BTC_revive_time_max = 90;
BTC_r_cpr_time      = 60;
BTC_3d_can_see     = ["Man"];
BTC_3d_distance    = 10;
BTC_3d_icon_size   = 0.5;
BTC_3d_icon_color  = [1,0,0,1];
////////////////// Don't edit below \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
if (!isDedicated) then {};
//FNC
call compile preprocessFile "scripts\=BTC=_revive\lite\=BTC=_functions.sqf";

if (isServer) then
{
	BTC_drag_pveh = [];publicVariable "BTC_drag_pveh";
	BTC_carry_pveh = [];publicVariable "BTC_carry_pveh";
	//BTC_marker_pveh = [];publicVariable "BTC_marker_pveh";
	BTC_load_pveh = [];publicVariable "BTC_load_pveh";
	BTC_pullout_pveh = [];publicVariable "BTC_pullout_pveh";
	BTC_cpr_pveh = [];publicVariable "BTC_pullout_pveh";
};
if (isDedicated) exitWith {};

BTC_dragging = false;
BTC_respawn_cond = false;
//Init
[] spawn
{
	waitUntil {!isNull player};
	waitUntil {player == player};
	"BTC_drag_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_carry_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	//"BTC_marker_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_load_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_pullout_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_killed_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	"BTC_cpr_pveh" addPublicVariableEventHandler BTC_fnc_PVEH;
	player addRating 9999;
	BTC_r_loop = false;
	BTC_side = playerSide;
	BTC_respawn_marker = format ["respawn_%1",playerSide];
	if (BTC_respawn_marker == "respawn_guer") then {BTC_respawn_marker = "respawn_guerrila";};
	if (BTC_respawn_marker == "respawn_civ") then {BTC_respawn_marker = "respawn_civilian";};
	player removeAllEventHandlers "HandleDamage";
	[] spawn {sleep 1;player addEventHandler ["HandleDamage", BTC_fnc_handledamage];};
	BIS_fnc_healthEffects_handleDamage_code = {};
	BIS_fnc_healtEffects_init = {};
	player setVariable ["BTC_need_revive",0,true];
	player setVariable ["BTC_dragged",0,true];
	player addAction [("<t color=""#d63333"">") + ("Тащить") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_drag], 8, true, true, "", "[] call BTC_check_action_drag"];
	player addAction [("<t color=""#d63333"">") + ("СЛР") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_cpr], 8, true, true, "", "[] call BTC_check_action_drag"];
	player addAction [("<t color=""#d63333"">") + ("Нести") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_carry], 8, true, true, "", "[] call BTC_check_action_drag"];
	player addAction [("<t color=""#d63333"">") + ("Выгрузить раненого") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_pull_out], 8, true, true, "", "[] call BTC_pull_out_check"];
	BTC_gear = [player] call BTC_get_gear;

	if (({player isKindOf _x} count BTC_3d_can_see) > 0) then {_3d = [] spawn BTC_3d_markers;};
};
