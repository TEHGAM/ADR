_unit = _this select 1;
if ( !alive Shooting_range) then {
    hint "Not available at this time";
} else {
if ( vehicle Shooting_range != Shooting_range) then {
    _unit moveInCargo MHQ;
} else {
if ( vehicle Shooting_range == Shooting_range) then {
    _unit setDir direction Shooting_range; 
    _unit setPosATL [ getPosATL Shooting_range select 0, (getPosATL Shooting_range select 1) - 1, getPosATL Shooting_range select 2]
};
};
};