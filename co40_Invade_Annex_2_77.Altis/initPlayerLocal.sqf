/*
@filename: initPlayerLocal.sqf
Author:
	
	Quiksilver

Last modified:

	19/11/2014
	
Description:

	Client-side scripts and event handlers.
	
______________________________________________________*/


enableSentences false;															

//------------------- client executions

//cutRsc ["WELCOME", "PLAIN"];

_null = [] execvm "scripts\vehicle\crew\crew.sqf"; 		// Vehicle HUD
_null = [] execVM 'scripts\group_manager.sqf';			// Group manager
_null = [] execVM "scripts\restrictions.sqf"; 			// Gear restrictions
//_null = [] execVM "scripts\pilotCheck.sqf"; 			// Pilots-only
_null = [] execVM "scripts\safezone.sqf"; 			// Spawn protection
_null = [] execVM "scripts\jump.sqf";				// Jump action
_null = [] execVM "scripts\misc\diary.sqf";			// Diary tabs
_null = [] execVM "scripts\vehicle\fastrope\zlt_fastrope.sqf";	// Heli rope	
_null = [] execVM "scripts\playerMarkers.sqf";			// Blufor map tracker
// _null = [] execVM "scripts\VA.sqf";				// Virtual Arsenal
_null = [] execVM "scripts\admin_uid.sqf";
_null = [] execVM "scripts\fpsFix\vehicleManager.sqf";
_null = [] execVM "scripts\general.sqf";			// Общие


//-------------------- PVEHs

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
	hint parseText format["%1", _GHint];			// Переменная
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

"sideMarker" addPublicVariableEventHandler
{
	"sideMarker" setMarkerPosLocal (markerPos "sideMarker");
	"sideCircle" setMarkerPosLocal (markerPos "sideCircle");
	"sideMarker" setMarkerTextLocal format["Допка: %1",sideMarkerText];			// Допзадание
};

"priorityMarker" addPublicVariableEventHandler
{
	"priorityMarker" setMarkerPosLocal (markerPos "priorityMarker");
	"priorityCircle" setMarkerPosLocal (markerPos "priorityCircle");
	"priorityMarker" setMarkerTextLocal format["Вторичная цель: %1",priorityTargetText];	// Арта и Батарея
};

tawvd_disablenone = false;
