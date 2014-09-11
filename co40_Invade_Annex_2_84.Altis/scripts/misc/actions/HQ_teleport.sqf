_unit = _this select 1;
if ( !alive HQ_receive) then {
    hint "Not available at this time";
} else {
if ( vehicle HQ_receive != HQ_receive) then {
    _unit moveInCargo MHQ;
} else {
if ( vehicle HQ_receive == HQ_receive) then {
    _unit setDir direction HQ_receive; 
    _unit setPosATL [ getPosATL HQ_receive select 0, (getPosATL HQ_receive select 1) - 1, getPosATL HQ_receive select 2]
};
};
};