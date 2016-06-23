/*
@filename: initPlayerLocal.sqf
Author:

	Quiksilver

Last modified:

	12/05/2014

Description:

	Client scripts and event handlers.
______________________________________________________*/

enableSentences false;
enableEngineArtillery false;

//------------------- Pilots only
_pilots = ["B_Helipilot_F", "O_helipilot_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;

if (_iampilot) then {
	player addBackpack "B_AssaultPack_sgg";
	player addItemToBackpack "ToolKit";

	//==== LASER TARGETS ON PILOTS HELMETS
	player addEventHandler [ "GetInMan", {
		[_this select 0, _this select 2] spawn QS_fnc_HMDLaserTarget;
	}];
};

//------------------- client executions

_null = [] execvm "scripts\vehicle\crew\crew.sqf"; 								// vehicle HUD
_null = [] execVM "scripts\restrictions.sqf"; 									// gear restrictions
_null = [] execVM "scripts\VAS\config.sqf"; 									// VAS
_null = [] execVM "scripts\pilotCheck.sqf"; 									// pilots only
_null = [] execVM "scripts\jump.sqf";											// jump action
_null = [] execVM "scripts\misc\diary.sqf";										// diary tabs
_null = [] execVM "scripts\icons.sqf";											// blufor map tracker
_null = [] execVM "scripts\VAclient.sqf";										// Virtual Arsenal
_null = [] execVM "scripts\admin_uid.sqf";
_null = [] execVM "scripts\heliRearRamp.sqf";									// Block rear ramp actions for non-pilots

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
	hint parseText format["%1", _GHint];
};

"hqSideChat" addPublicVariableEventHandler
{
	_message = _this select 1;
	[WEST, "HQ"] sideChat _message;
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
	if (count sideMarkerText == 2) then {
        "sideMarker" setMarkerTextLocal format["%1", sideMarkerText select 0];
	} else {
        "sideMarker" setMarkerTextLocal format["Допзадание: %1", sideMarkerText];
    };
};

"priorityMarker" addPublicVariableEventHandler
{
	"priorityMarker" setMarkerPosLocal (markerPos "priorityMarker");
	"priorityCircle" setMarkerPosLocal (markerPos "priorityCircle");
	"priorityMarker" setMarkerTextLocal format["Вторичная цель: %1",priorityTargetText];
};
