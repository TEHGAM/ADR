_vehicle = _this select 0;
if(_vehicle isKindOf "Ship") then {
_vehicle addAction ["<t color='#FF0000'>" + "Push" + "</t>","scripts\vehicle\push\push.sqf",[],21,true,true,"","!(_this in (crew _target)) AND (speed _target < 1)"]
} else {
_vehicle addAction ["<t color='#FF0000'>" + "Push" + "</t>","scripts\vehicle\push\push.sqf",[],21,true,true,"","(surfaceIsWater [getPos _target select 0,getPos _target select 1]) AND !(_this in (crew _target)) AND (speed _target < 1)"]};
