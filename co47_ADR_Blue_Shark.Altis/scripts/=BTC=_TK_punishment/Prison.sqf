/*
Author:	ToxaBes
Description: prison logic.
*/
private ["_tk_prison_coords", "_time", "_n", "_count","_target"];
_prisonCoords = [15259,17355,0];
_defaultTime  = 120;
_target        = _this select 0;
if (!isDedicated) then {    
    _effects = [] spawn BTC_Effects;
    if (_target == player) then {
        _time = profileNamespace getVariable ["btc_tk_prison", 0];
        if (_time == 0) then {            	               
            _time = _defaultTime;
            profileNamespace setVariable ["btc_tk_prison", _time];
            saveProfileNamespace;
        };                            
        player setPos _prisonCoords;
        removeAllWeapons player;
        removeAllItems player;
        removeBackpack player;
        removeHeadgear player;
        removeVest player;
        player unassignItem "NVGoggles";
        player removeItem "NVGoggles";            
        _n = 0;
        _k = 1;
        while {_n < _time} do {
        	_count = _time - _n;          
            cutText [format["ВАС НАКАЗАЛИ ЗА УБИЙСТВО СВОИХ! Наказание: %1 сек", _count], "PLAIN DOWN"];
            _n = _n + 1;
            _k = _k + 1;
            if (_k > 5) then {
            	if (player distance _prisonCoords > 10) then {
            		player setPos _prisonCoords;
            	};
                _k = 1;
            };
            if (!alive player) exitWith {};
            sleep 1;            
        };
        if (alive player) then {
            profileNamespace setVariable ["btc_tk_prison", 0];
		    saveProfileNamespace;
		    cutText ["", "PLAIN DOWN"];  
		    player setDamage 1;  
		    sleep 3;    
            BTC_respawn_cond = true;
            _respawn = [] spawn BTC_player_respawn;
        };               
    };
};
