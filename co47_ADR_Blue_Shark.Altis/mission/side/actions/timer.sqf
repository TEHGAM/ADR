/*
Author: ToxaBes
Description: timer for bomb
*/
private ["_object", "_time", "_step"];
if (!TIMER_IN_USE) then {
    TIMER_IN_USE = true; publicVariable "TIMER_IN_USE";
    player playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon";
    _object = _this select 0;
    _time = _this select 3 select 0;
    _step = _this select 3 select 1;
    [_object,"QS_fnc_removeAction0",nil,true] spawn BIS_fnc_MP;
    _basePos = getMarkerPos "respawn_west";
    while {_time > 0} do {    
        if (!alive _object) exitWith {};
        hqSideChat = format ["%1 секунд до подрыва", _time];        
        publicVariable "hqSideChat"; 
        [WEST, "HQ"] sideChat hqSideChat;
        _time = _time - _step; 
        sleep _step;
    };
    if (alive _object && {(_object distance _basePos) > 2200} && !nukeExplosion) then {
        hqSideChat = "Подрыв!";        
    } else {
        hqSideChat = "Заряд находится менее чем в 2км от базы. Командование отключило таймер!"; 
    };
    publicVariable "hqSideChat"; 
    [WEST, "HQ"] sideChat hqSideChat;
    _epicenter = getPos _object;
    if ((_object distance _basePos) > 2200 && !nukeExplosion) then {
        nukeExplosion = true; publicVariable "nukeExplosion";
        _k = 1.66;
        _radius = 900;
        _radiusEMI = 1400;   
        _object setDamage 0.9;                         
        _bigBomb = createVehicle ["Bo_GBU12_LGB", _epicenter, [], 0, "NONE"];
        _obj = createVehicle ["Land_HelipadEmpty_F", _epicenter, [], 0, "NONE"];
        [[[_obj, _epicenter], "scripts\nuke.sqf"], "BIS_fnc_execVM", true, false, false] call BIS_fnc_MP;
        _allObjects = nearestObjects [_epicenter,[], _radius];
        {
            _distance = [_epicenter, getPos _x] call BIS_fnc_distance2D;
            _x setDamage (abs ((_distance / _radius) - _k));
        } foreach _allObjects;
        _allObjects = nearestObjects [_epicenter, ["LandVehicle","Air","Ship"], _radiusEMI];
        {
            _x engineOn false;
            _x setfuel 0;        
        } foreach _allObjects;
    };
} else {
	hintSilent "Таймер уже запущен - ищите укрытие!";
};
