///////////////////
//  AVERAGE FPS  //
///////////////////
diag_log text "";

_ArrayCounter = 0;
diag_log text "Average FPS";

_lineOutput = "====";
for "_loopcounter" from 1 to (count pvpfw_monitor_fpsArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;

_lineOutput = "";
for "_loopcounter" from 50 to 1 step -2 do {
	if (_loopcounter <= 9) then{
		_lineOutput = _lineOutput + " " + str _loopcounter + "|";
	}else{
		_lineOutput = _lineOutput + str _loopcounter + "|";
	};
	
	{
		_arrayEntry = (pvpfw_monitor_fpsArray select _ArrayCounter);
		switch (true) do{
			case(_arrayEntry > _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_arrayEntry == _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_arrayEntry == _loopcounter - 1):{_lineOutput = _lineOutput + ".";};
			case(_arrayEntry < _loopcounter):{_lineOutput = _lineOutput + " ";};
			default{};
		};
		_ArrayCounter = _ArrayCounter + 1;
	}forEach pvpfw_monitor_fpsArray;
	_lineOutput = _lineOutput + "|";
	diag_log text _lineOutput;
	_ArrayCounter = 0;
	_lineOutput = "";
};

_lineOutput = "====";
for "_loopcounter" from 1 to (count pvpfw_monitor_fpsArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;
diag_log pvpfw_monitor_fpsArray;

///////////////////
//  Minimum FPS  //
///////////////////
diag_log text "";

_ArrayCounter = 0;
diag_log text "Average Minimum FPS";

_lineOutput = "====";
for "_loopcounter" from 1 to (count pvpfw_monitor_fpsMinArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;

_lineOutput = "";
for "_loopcounter" from 50 to 1 step -2 do {
	if (_loopcounter <= 9) then{
		_lineOutput = _lineOutput + " " + str _loopcounter + "|";
	}else{
		_lineOutput = _lineOutput + str _loopcounter + "|";
	};
	
	{
		_arrayEntry = (pvpfw_monitor_fpsMinArray select _ArrayCounter);
		switch (true) do{
			case(_arrayEntry > _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_arrayEntry == _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_arrayEntry == _loopcounter - 1):{_lineOutput = _lineOutput + ".";};
			case(_arrayEntry < _loopcounter):{_lineOutput = _lineOutput + " ";};
			default{};
		};
		_ArrayCounter = _ArrayCounter + 1;
	}forEach pvpfw_monitor_fpsMinArray;
	_lineOutput = _lineOutput + "|";
	diag_log text _lineOutput;
	_ArrayCounter = 0;
	_lineOutput = "";
};

_lineOutput = "====";
for "_loopcounter" from 1 to (count pvpfw_monitor_fpsMinArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;
diag_log pvpfw_monitor_fpsMinArray;

///////////////////
////  Players  ////
///////////////////
diag_log text "";

_ArrayCounter = 0;
diag_log text "Playercount";

_lineOutput = "====";
for "_loopcounter" from 1 to (count pvpfw_monitor_PlayersNumberArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;

_lineOutput = "";
for "_loopcounter" from 100 to 4 step -4 do {
	switch(true)do{
		case(_loopcounter <= 9):{
			_lineOutput = _lineOutput + "  " + str _loopcounter + "|";
		};
		case(_loopcounter <= 99):{
			_lineOutput = _lineOutput + " " + str _loopcounter + "|";
		};
		default{
			_lineOutput = _lineOutput + str _loopcounter + "|";
		};
	};
	
	{
		_currentPlayersNumber = pvpfw_monitor_PlayersNumberArray select _ArrayCounter;
		switch (true) do{
			case(_currentPlayersNumber > _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_currentPlayersNumber == _loopcounter || _currentPlayersNumber == _loopcounter - 1):{_lineOutput = _lineOutput + ":";};
			case(_currentPlayersNumber == _loopcounter - 2 || _currentPlayersNumber == _loopcounter - 3):{_lineOutput = _lineOutput + ".";};
			case(_currentPlayersNumber < _loopcounter):{_lineOutput = _lineOutput + " ";};
			default{};
		};
		_ArrayCounter = _ArrayCounter + 1;
	}forEach pvpfw_monitor_PlayersNumberArray;
	_lineOutput = _lineOutput + "|";
	diag_log text _lineOutput;
	_ArrayCounter = 0;
	_lineOutput = "";
};

_lineOutput = "====";
for "_loopcounter" from 1 to (count pvpfw_monitor_PlayersNumberArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;
diag_log pvpfw_monitor_PlayersNumberArray;

/////////////////////////////
////  allMisisonObjects  ////
/////////////////////////////
diag_log text "";

_ArrayCounter = 0;
diag_log text "allMissionObjects";

_lineOutput = "====";
for "_loopcounter" from 1 to (count pvpfw_monitor_missionObjects) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;

_lineOutput = "";
_maxExtreme = [pvpfw_monitor_missionObjects,1] call BIS_fnc_findExtreme;
for "_loopcounter" from (_maxExtreme + (10 - (_maxExtreme % 10))) to 10 step -10 do { 
	switch(true)do{
		case(_loopcounter <= 9):{
			_lineOutput = _lineOutput + "  " + str _loopcounter + "|";
		};
		case(_loopcounter <= 99):{
			_lineOutput = _lineOutput + " " + str _loopcounter + "|";
		};
		default{
			_lineOutput = _lineOutput + str _loopcounter + "|";
		};
	};
	
	{
		_currentPlayersNumber = pvpfw_monitor_missionObjects select _ArrayCounter;
		switch (true) do{
			case(_currentPlayersNumber > _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_currentPlayersNumber <= _loopcounter && _currentPlayersNumber > _loopcounter - 5):{_lineOutput = _lineOutput + ":";};
			case(_currentPlayersNumber <= _loopcounter - 5 && _currentPlayersNumber > _loopcounter - 10):{_lineOutput = _lineOutput + ".";};
			case(_currentPlayersNumber < _loopcounter):{_lineOutput = _lineOutput + " ";};
			default{};
		};
		_ArrayCounter = _ArrayCounter + 1;
	}forEach pvpfw_monitor_missionObjects;
	_lineOutput = _lineOutput + "|";
	diag_log text _lineOutput;
	_ArrayCounter = 0;
	_lineOutput = "";
};

_lineOutput = "====";
for "_loopcounter" from 1 to (count pvpfw_monitor_missionObjects) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;
diag_log pvpfw_monitor_missionObjects;