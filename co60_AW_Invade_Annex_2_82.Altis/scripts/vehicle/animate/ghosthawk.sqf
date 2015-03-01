private ["_veh","_speed"];
_veh = _this select 0;
while {alive _veh} do {
	_speed = speed _veh;
	if (_speed < 10) then {  					
		_veh animateDoor ['door_R',1];
		_veh animateDoor ['door_L',1];
	} else {
		_veh animateDoor ['door_R',0];
		_veh animateDoor ['door_L',0];
  };
   sleep 10;
};