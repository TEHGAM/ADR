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
    while {_time > 0} do {           
        hqSideChat = format ["%1 секунд до подрыва", _time];        
        publicVariable "hqSideChat"; 
        [EAST, "HQ"] sideChat hqSideChat;
        _time = _time - _step; 
        sleep _step;
    };
    hqSideChat = "Подрыв!";        
    publicVariable "hqSideChat"; 
    [EAST, "HQ"] sideChat hqSideChat;
    _object setDamage 1;
} else {
	hintSilent "Таймер уже запущен - ищите укрытие!";
};
