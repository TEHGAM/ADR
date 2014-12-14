// Edited by TEHGAM

// JIP check — this code should be placed as first line of init.sqf file
if (!isServer && isNull player) then {isJIP=true;} else {isJIP=false;};

enableSentences false;

call compile preprocessFile "scripts\=BTC=_revive\=BTC=_revive_init.sqf"; // Скрипт возрождения
call compile preprocessFile "scripts\=BTC=_TK_punishment\=BTC=_tk_init.sqf";

_null=[] execVM "mission\side\resp.sqf";
mdh_resp_resp5	= 50000;
mdh_resp_resp3	= 1;
mdh_resp_resp1	= 0;
mdh_resp_resp2	= 0;

_null = [] execvm "scripts\vehicle\crew\crew.sqf";              // Vehicle HUD

_null = [] execVM "restrictions.sqf";                           // Gear restrictions

_null = [] execVM "scripts\admin_uid.sqf";                      // Admin spectate

_null = [] execVM "scripts\grenadeStop.sqf";                    // Spawn protection

_null = [] execVM "scripts\vehicle\fastrope\zlt_fastrope.sqf";  // Helicopter rope
_null = [] execVM "scripts\misc\playerMarkers.sqf";             // BLUFOR map tracker

[] execVM "scripts\id.sqf";                                     // Скрипт позывных

[] execVM "scripts\DOM_squad\init.sqf";                         // Управление отрядами

// PVEHs
"showNotification" addPublicVariableEventHandler
{
  private ["_type", "_message"];
  _array = _this select 1;
  _type = _array select 0;
  _message = "";
  if (count _array > 1) then { _message = _array select 1; };
  [_type, [_message]] call BIS_fnc_showNotification;
};

"GlobalHint" addPublicVariableEventHandler
{
  private ["_GHint"];
  _GHint = _this select 1;
  hint parseText format["%1", _GHint];
};

"hqSideChat" addPublicVariableEventHandler
{
  _message = _this select 1;
  [WEST,"HQ"] sideChat _message;
};

"addToScore" addPublicVariableEventHandler
{
  ((_this select 1) select 0) addScore ((_this select 1) select 1);
};

"radioTower" addPublicVariableEventHandler
{
  "radioMarker" setMarkerPosLocal (markerPos "radioMarker");
  "radioMarker" setMarkerTextLocal (markerText "radioMarker");
  "radioCircle" setMarkerPosLocal (markerPos "radioCircle");
};

"refreshMarkers" addPublicVariableEventHandler
{
  {
    _x setMarkerShapeLocal (markerShape _x);
    _x setMarkerSizeLocal (markerSize _x);
    _x setMarkerBrushLocal (markerBrush _x);
    _x setMarkerColorLocal (markerColor _x);
  } forEach _targets;

  {
    _x setMarkerPosLocal (markerPos _x);
    _x setMarkerTextLocal (markerText _x);
  } forEach ["aoMarker","aoCircle"];
};

"sideMarker" addPublicVariableEventHandler
{
  "sideMarker" setMarkerPosLocal (markerPos "sideMarker");
  "sideCircle" setMarkerPosLocal (markerPos "sideCircle");
  "sideMarker" setMarkerTextLocal format["Side Mission: %1",sideMarkerText];
};

"priorityMarker" addPublicVariableEventHandler
{
  "priorityMarker" setMarkerPosLocal (markerPos "priorityMarker");
  "priorityCircle" setMarkerPosLocal (markerPos "priorityCircle");
  "priorityMarker" setMarkerTextLocal format["Priority Target: %1",priorityTargetText];
};

"TakeMarker" addPublicVariableEventHandler
{
  createMarker [((_this select 1) select 0), getMarkerPos ((_this select 1) select 1)];
  "theTakeMarker" setMarkerShape "ICON";
  "theTakeMarker" setMarkerType "o_unknown";
  "theTakeMarker" setMarkerColor "ColorOPFOR";
  "theTakeMarker" setMarkerText format["Take %1", ((_this select 1) select 1)];
};

// Wait until player is initialized
if (!isDedicated) then {
  waitUntil {!isNull player && isPlayer player};
  sidePlayer = side player;
};

// Wait until player is alive
if (!isServer) exitWith {
  while {true} do {
    waitUntil {sleep 1; !alive player};
    waitUntil {sleep 1; alive player};
  };
};

// Other useful stuff
enableSaving [false, false];
enableSentences false;

// Handle parameters
for [ {_i = 0}, {_i < count(paramsArray)}, {_i = _i + 1} ] do {
  call compile format
  [
    "PARAMS_%1 = %2",
    (configName ((missionConfigFile >> "Params") select _i)),
    (paramsArray select _i)
  ];
};

// Server scripts
if (PARAMS_mainAO == 1) then { _null = [] execVM "mission\main\AO.sqf"; };                          // Озновные задачи
if (PARAMS_SideMissions == 1) then { _null = [] execVM "mission\side\sideMissions.sqf"; };          // Допки
if (PARAMS_UrbanMissions == 1) then { _null = [2400] execVM "mission\side\initUrbanDestroy.sqf"; }; // Time before next exec
if (PARAMS_Artillery == 1) then { _null = [] execVM "mission\priority\Artillery.sqf"; };            // Enemy artillery
[]execVM "scripts\eos\OpenMe.sqf";                                                                  // По городским и обороне
_null = [] execVM "scripts\misc\clearBodies.sqf";                                                   // Performance costly
_null = [] execVM "scripts\misc\clearItems.sqf";
[] execVM "module_performance\init.sqf";
