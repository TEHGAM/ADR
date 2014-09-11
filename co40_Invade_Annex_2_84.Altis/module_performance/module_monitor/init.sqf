/****************************************
*****************************************

Module: Monitor
Global-var-shortcut: monitor
Author: Conroy

Description:

Logs the servers performance and playercount.

*****************************************
****************************************/

if (!isServer) exitWith{};

private["_nextSecond","_logInterval","_fps","_fpsMin","_playersNumber","_dumpEachX","_i"];

_handle_config = [] execVM "module_performance\module_monitor\config.sqf";
waitUntil{scriptDone _handle_config};

pvpfw_perf_monitorResultsToRPT = compile preProcessFileLineNumbers "module_performance\module_monitor\dumpPerformanceArrays.sqf";

_logInterval = 10; //in seconds
_dumpEachX = 60 / _logInterval; //dump results to the array once a minute

_fps = 0;
_fpsMin = 0;
_playersNumber = 0;
_missionObjects = 0;

_infoMarker = "";

if (pvpfw_monitor_infoOnMap) then{
	_infoMarker = "pvpfw_monitor_marker_info";
	_infoMarker = createMarker [_infoMarker, [500,500]];
	_infoMarker setmarkerSize [0.5,0.5];
	_infoMarker setmarkerAlpha 0.67;
	_infoMarker setMarkerShape "ICON";
	_infoMarker setMarkerType "mil_box";
	_infoMarker setMarkerColor "colorBlack";
};

_nextSecond = floor diag_tickTime + _logInterval;
_i = 1;

pvpfw_monitor_fpsArray = [];
pvpfw_monitor_fpsMinArray = [];
pvpfw_monitor_PlayersNumberArray = [];
pvpfw_monitor_missionObjects = [];

waitUntil {sleep 0.01; diag_tickTime > _nextSecond};

while{true}do{
	_currentfps = diag_fps;
	_currentObjectCount = count allMissionObjects "All";
	_currentPlayers = playersNumber west + playersNumber east + playersNumber resistance + playersNumber civilian;
	
	if (pvpfw_monitor_infoOnMap) then{
		_infoMarker setMarkerText format["Server: fps %1 | players %2 | objects %3",([_currentfps,1] call BIS_fnc_cutDecimals),_currentPlayers,_currentObjectCount];
	};
	
	_fps = _fps + _currentfps;
	_fpsMin = _fpsMin + diag_fpsmin;
	_playersNumber = _playersNumber + _currentPlayers;
	_missionObjects = _missionObjects + _currentObjectCount;
	 
	if (_i >= _dumpEachX) then{
		pvpfw_monitor_fpsArray set[count pvpfw_monitor_fpsArray,round (_fps / _dumpEachX)];
		pvpfw_monitor_fpsMinArray set[count pvpfw_monitor_fpsMinArray,round (_fpsMin / _dumpEachX)];
		pvpfw_monitor_PlayersNumberArray set[count pvpfw_monitor_PlayersNumberArray,round (_playersNumber / _dumpEachX)];
		pvpfw_monitor_missionObjects set[count pvpfw_monitor_missionObjects,round (_missionObjects / _dumpEachX)];
		//if (!isDedicated) then {player sidechat format["%1",round (_fps / _dumpEachX)];};
		_i = 1;
		_fps = 0;
		_fpsMin = 0;
		_playersNumber = 0;
		_missionObjects = 0;
	}else{
		_i = _i + 1;
	};
	waitUntil {sleep 0.01; diag_tickTime > _nextSecond};
	_nextSecond = floor diag_tickTime + _logInterval;
};
