///////////////////////////////////////////////////////////////////////////////////////////////////
//  Simple Heli Door Script v1.03 - tweaked by Quiksilver                                        //
//  Execute from any GhostHawk init field:                                                       //
//  0 = [this] execVM "scripts\b2_heliDoors.sqf";                                                //
//  line 19 original param: if (_alt < 30) && (_speed < 5) then                                  //
//  Inspired by Heli Door Open Script by Delta 1 Actual                                          //
//  http://www.armaholic.com/page.php?id=21969                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////

private ["_veh","_alt","_speed"];

_veh = _this select 0;
if (!isServer || !(_veh isKindOf "Heli_Transport_01_base_F")) exitWith {};

while {alive _veh} do {
  sleep 1;
  _alt = getPos _veh select 2;
  _speed = (sqrt ((velocity _veh select 0)^2 + (velocity _veh select 1)^2 + (velocity _veh select 2)^2));
  if (_speed < 10) then {  					
    _veh animateDoor ['door_R',1];
    _veh animateDoor ['door_L',1];
  } else {
    _veh animateDoor ['door_R',0];
    _veh animateDoor ['door_L',0];
  };
};