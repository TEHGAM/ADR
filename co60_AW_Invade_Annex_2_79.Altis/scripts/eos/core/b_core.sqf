if (!isServer) exitWith {};
private ["_fGroup","_cargoType","_vehType","_CHside","_mkrAgl","_initialLaunch","_pause","_eosZone","_hints","_waves","_aGroup","_side","_actCond","_enemyFaction","_mAH","_mAN","_distance","_grp","_cGroup","_bGroup","_CHType","_time","_timeout","_faction"];

_mkr = (_this select 0); _mPos = markerpos(_this select 0); _mkrX = getMarkerSize _mkr select 0; _mkrY = getMarkerSize _mkr select 1; _mkrAgl = markerDir _mkr;
_infantry = (_this select 1); _PApatrols = _infantry select 0; _PAgroupSize = _infantry select 1;
_LVeh = (_this select 2); _LVehGroups = _LVeh select 0; _LVgroupSize = _LVeh select 1;
_AVeh = (_this select 3); _AVehGroups = _AVeh select 0;
_SVeh = (_this select 4); _CHGroups = _SVeh select 0; _fSize = _SVeh select 1;
_settings = (_this select 5); _faction = _settings select 0; _mA=_settings select 1; _side = _settings select 2;
_heightLimit = if (count _settings > 4) then {_settings select 4} else {false};
_debug = if (count _settings > 5) then {_settings select 5} else {false};
_basSettings = (_this select 6);
_pause = _basSettings select 0;
_waves = _basSettings select 1;
_timeout = _basSettings select 2;
_eosZone = _basSettings select 3;
_hints = _basSettings select 4;
_initialLaunch = if (count _this > 7) then {_this select 7} else {false};

_Placement = (_mkrX + 150);

if (_mA == 0) then {_mAH = 1; _mAN = 0.5;};
if (_mA == 1) then {_mAH = 0; _mAN = 0;};
if (_mA == 2) then {_mAH = 0.5; _mAN = 0.5;};
	
if (_side == EAST) then {_enemyFaction = "east";};
if (_side == WEST) then {_enemyFaction = "west";};
if (_side == INDEPENDENT) then {_enemyFaction = "GUER";};
if (_side == CIVILIAN) then {_enemyFaction = "civ";};

if ismultiplayer then {
	if (_heightLimit) then {
		_actCond = "{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 5} count playableunits > 0";
	} else {
		_actCond = "{vehicle _x in thisList && isplayer _x} count playableunits > 0";
	};
} else {
	if (_heightLimit) then {
		_actCond = "{vehicle _x in thisList && isplayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0";
	} else {
	_actCond = "{vehicle _x in thisList && isplayer _x} count allUnits > 0";
	};
};

_basActivated = createTrigger ["EmptyDetector", _mPos];
_basActivated setTriggerArea [_mkrX, _mkrY, _mkrAgl, false];
_basActivated setTriggerActivation ["ANY", "PRESENT", true];
_basActivated setTriggerStatements [_actCond, "", ""];

_mkr setmarkercolor bastionColor;
_mkr setmarkeralpha _mAN;

waituntil {triggeractivated _basActivated};
_mkr setmarkercolor bastionColor;
_mkr setmarkeralpha _mAH;

_bastActive = createTrigger ["EmptyDetector", _mPos];
_bastActive setTriggerArea [_mkrX, _mkrY, _mkrAgl, false];
_bastActive setTriggerActivation ["any", "PRESENT", true];
_bastActive setTriggerTimeout [1, 1, 1, true];
_bastActive setTriggerStatements [_actCond, "", ""];

_bastClear = createTrigger ["EmptyDetector", _mPos];
_bastClear setTriggerArea [(_mkrX + (_Placement * 0.3)), (_mkrY + (_Placement * 0.3)), _mkrAgl, false];
_bastClear setTriggerActivation [_enemyFaction, "NOT PRESENT", true];
_bastClear setTriggerStatements ["this", "", ""];


// PAUSE IF REQUESTED
if (_pause > 0 and !_initialLaunch) then {
	for "_counter" from 1 to _pause do {
		if (_hints) then  {hint format ["Attack ETA : %1", (_pause - _counter)];};

		sleep 1;
	};
};


// SPAWN PATROLS
_aGroup = [];
for "_counter" from 1 to _PApatrols do {
	_pos = [_mPos, [_Placement, (_Placement + 50)], random 360, 1, [0, 0]] call SHK_pos;
	_grp = [_pos, _PAgroupSize, _faction, _side] call EOS_fnc_spawngroup;
	_aGroup set [count _aGroup, _grp];

	if (_debug) then {
		PLAYER SIDECHAT (format ["Spawned Patrol: %1", _counter]);
		0 = [_mkr, _counter, "patrol", getpos (leader _grp)] call EOS_debug
	};

	sleep 1;
};


//SPAWN LIGHT VEHICLES
_bGrp = [];
for "_counter" from 1 to _LVehGroups do {

	_direction = random 360;
	_newpos = [_mPos, [(_Placement + 550), (_Placement + 650)], _direction, 1, [1, 300], [200, "O_MBT_02_cannon_F"]] call SHK_pos;
	if (surfaceiswater _newpos) then {_vehType = 8; _cargoType = 9;} else {_vehType = 7; _cargoType = 9;};
	_bGroup = [_newpos, _side, _faction, _vehType] call EOS_fnc_spawnvehicle;

	if ((_LVgroupSize select 0) > 0) then {
		_cargoGrp = createGroup _side;
		0 = [(_bGroup select 0), _LVgroupSize, (_bGroup select 2), _faction, _cargoType] call eos_fnc_setcargo;
		0 = [_cargoGrp, "INFskill"] call eos_fnc_grouphandlers;
		_bGroup set [count _bGroup, _cargoGrp];
		0 = [_mkr, _bGroup, _counter, _direction, _vehType] execvm "scripts\eos\functions\LVehUnload_fnc.sqf";
	} else {
		_wp = (_x select 2) addWaypoint [_mPos, 50];
		_wp setWaypointType "SAD";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointBehaviour "AWARE"; 
		_wp setWaypointFormation "NO CHANGE";
	};

	0 = [(_bGroup select 2), "LIGskill"] call eos_fnc_grouphandlers;
	_bGrp set [count _bGrp, _bGroup];

	if (_debug) then {
		player sidechat format ["Light Vehicle:%1 - r%2", _counter, _LVehGroups];
		0 = [_mkr, _counter, "Light Veh", (getpos leader (_bGroup select 2))] call EOS_debug;
	};

	sleep 1;
};


//SPAWN ARMOURED VEHICLES
_cGrp=[];
for "_counter" from 1 to _AVehGroups do {

	_newpos = [_mPos, [(_Placement + 700), (_Placement + 800)], random 360, 3, [1, 300], [200, "O_MBT_02_cannon_F"]] call SHK_pos;
	_vehType = 2;
	_cGroup = [_newpos, _side, _faction, _vehType] call EOS_fnc_spawnvehicle;

	0 = [(_cGroup select 2), "ARMskill"] call eos_fnc_grouphandlers;

	_cGrp set [count _cGrp, _cGroup];

	if (_debug) then {
		player sidechat format ["Armoured:%1 - r%2", _counter, _AVehGroups];
		0 = [_mkr, _counter, "Armour", (getpos leader (_cGroup select 2))] call EOS_debug;
	};

	sleep 1;
};


//SPAWN HELICOPTERS
_fGrp=[];
for "_counter" from 1 to _CHGroups do {

	if ((_fSize select 0) > 0) then {_vehType = 4;} else {_vehType = 3;};
	_direction = random 360;
	_newpos = [_mPos, [2000, 3000], _direction, 1, [0, 0]] call SHK_pos;
	_fGroup = [_newpos, _side, _faction, _vehType, "fly"] call EOS_fnc_spawnvehicle;
	_CHside = _side;
	
	if ((_fSize select 0) > 0) then {
		_cargoGrp = createGroup _side;
		0 = [(_fGroup select 0), _fSize, (_fGroup select 2), _faction, 9] call eos_fnc_setcargo;
		0 = [_cargoGrp, "INFskill"] call eos_fnc_grouphandlers;
		_fGroup set [count _fGroup, _cargoGrp];
		0 = [_mkr, _fGroup, _counter, _direction] execvm "scripts\eos\functions\TransportUnload_fnc.sqf";
	} else {
		_wp1 = (_fGroup select 2) addWaypoint [(markerpos _mkr), 0];
		_wp1 setWaypointSpeed "FULL";
		_wp1 setWaypointType "SAD";
		0 = [(_fGroup select 2), "AIRskill"] call eos_fnc_grouphandlers;
	};

	_fGrp set [count _fGrp, _fGroup];

	if (_debug) then {
		player sidechat format ["Chopper:%1", _counter];
		0 = [_mkr, _counter, "Chopper", (getpos leader (_fGroup select 2))] call EOS_debug
	};

	sleep 1;
};


// ADD WAYPOINTS
{
	_getToMarker = _x addWaypoint [_mPos, 50];
	_getToMarker setWaypointType "SAD";
	_getToMarker setWaypointSpeed "FULL";
	_getToMarker setWaypointBehaviour "AWARE"; 
	_getToMarker setWaypointFormation "NO CHANGE";
	sleep 1;
} forEach _aGroup;

{
	_getToMarker = (_x select 2) addWaypoint [_mPos, 50];
	_getToMarker setWaypointType "SAD";
	_getToMarker setWaypointSpeed "FULL";
	_getToMarker setWaypointBehaviour "AWARE"; 
	_getToMarker setWaypointFormation "NO CHANGE";
	sleep 1;
} forEach _cGrp;


waituntil {triggeractivated _bastActive};

for "_counter" from 1 to _timeout do {
	if (_hints) then {
		if (_waves > 1) then {hint format ["Next wave ETA : %1", (_timeout - _counter)];};
	};
	sleep 1;

	if (!triggeractivated _bastActive || getmarkercolor _mkr == "colorblack") exitwith {
		hint "Точка потеряна!";//"Zone lost. You must re-capture it";
		_mkr setmarkercolor hostileColor;
		_mkr setmarkeralpha _mAN;

		if (_eosZone) then {
		0 = [_mkr, [_PApatrols, _PAgroupSize], [_PApatrols, _PAgroupSize], [_LVehGroups, _LVgroupSize], [_AVehGroups, 0, 0, 0], [_faction, _mA, 350, _CHside]] execVM "scripts\eos\core\EOS_Core.sqf";
		};
		_waves = 0;
	};
};

_waves = (_waves - 1);

if (triggeractivated _bastActive and triggeractivated _bastClear and (_waves < 1) ) then {
	if (_hints) then {hint "Наступление отбито!";};//"Waves complete";};
	_mkr setmarkercolor VictoryColor;
	_mkr setmarkeralpha _mAN;
} else {
	if (_waves >= 1) then {
		if (_hints) then  {hint "Противник вызвал подкрепление!";};//"Reinforcements inbound";};
		0 = [_mkr, [_PApatrols, _PAgroupSize], [_LVehGroups, _LVgroupSize], [_AVehGroups], [_CHGroups, _fSize], _settings, [_pause, _waves, _timeout, _eosZone, _hints], true] execVM "scripts\eos\core\b_core.sqf";
	};
};

waituntil {getmarkercolor _mkr == "colorblack" OR getmarkercolor _mkr == VictoryColor OR getmarkercolor _mkr == hostileColor or !triggeractivated _bastActive};
if (_debug) then {player sidechat "delete units";};


// DELETE UNITS
if (count _aGroup > 0) then {
	{
		{deleteVehicle _x} forEach units _x;
	} forEach _aGroup;
};

if (count _bGrp > 0) then {
	{
		_vehicle = _x select 0;
		_crew = _x select 1;
		_grp = _x select 2;
		_cargoGrp = _x select 3;
		{deleteVehicle _x} forEach (_crew);
		if (!(vehicle player == _vehicle)) then {{deleteVehicle _x} forEach[_vehicle];};
		{deleteVehicle _x} forEach units _grp; deleteGroup _grp;
		{deleteVehicle _x} forEach units _cargoGrp; deleteGroup _cargoGrp;
	} forEach _bGrp;
};

if (count _cGrp > 0) then {
	{
		_vehicle = _x select 0;
		_crew = _x select 1;
		_grp = _x select 2;
		{deleteVehicle _x} forEach (_crew);
		if (!(vehicle player == _vehicle)) then {{deleteVehicle _x} forEach[_vehicle];};
		{deleteVehicle _x} forEach units _grp;
		deleteGroup _grp;
	} forEach _cGrp;
};

if (count _fGrp > 0) then {
	{
		_vehicle = _x select 0;
		_crew = _x select 1;
		_grp = _x select 2;
		_cargoGrp = _x select 3;
		{deleteVehicle _x} forEach (_crew);
		if (!(vehicle player == _vehicle)) then {{deleteVehicle _x} forEach [_vehicle];};
		{deleteVehicle _x} forEach units _grp; deleteGroup _grp;
		{deleteVehicle _x} forEach units _cargoGrp; deleteGroup _cargoGrp;
	} forEach _fGrp;
};

deletevehicle _bastActive; deletevehicle _bastClear; deletevehicle _basActivated;
if (getmarkercolor _mkr == "colorblack") then {_mkr setmarkeralpha 0;};