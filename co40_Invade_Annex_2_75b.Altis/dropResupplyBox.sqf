/*
Crater cleaner and a bomb remover scripts
Ill post these here, maybe somebody can find these useful 

Script that cleans up craters from the given area, left behind by blown up helicopters and planes. 
Ever had to avoid craters at airfield during takeoff/landing? Those pesky craters have ruined my day several times..
Code:

   Author: -=XTRA=- tox1m

   Description:
   Cleans up craters from the given area.

   Parameter(s):
   1. Area size
   2. Marker name
   
   Example;
   _cratercleaner = [7, "my_BobCat"] execVM "groundWorks.sqf"

*/

private ["_basemarker","_craters","_areasize","_base"];

_areasize    = _this select 0;
_basemarker   = _this select 1; //Bobcat

//_areasize = 7; //Only in small range near Bobcat


while {true} do 
{
 if !(Alive _basemarker) exitWith {};
 _base = getPos _basemarker; //Bobcat position 
 _craters = nearestObjects [_base, ["CraterLong"], _areasize];
   sleep 0.1;
   
   if (count _craters > 0) then
   {
   SystemChat (format ["Craters = %1",count _craters]);
      for "_i" from 0 to ((count _craters) - 1) do
      {
         private ["_crater"];
         _crater = _craters select _i;
		 _basemarker VehicleChat "I`ve prepared the backhoe dipper. Move...";
		 sleep 2;
         if ( speed (_basemarker) >= 7) then 
		   {
				deleteVehicle _crater; 
		   };
      };
   };
   sleep 3;
};

/*
Script that cleans up certain type of bombs from the given area. 
Might be useful against players who try to destroy your base.
Code:

   Author: -=XTRA=- tox1m

   Description:
   Cleans up bombs from the given area.
   Uses nearObjects, since nearestObjects doesnt seem to work with bombs

   Parameter(s):
   1. Work Area size
   2. Vehicle name
   
   Example;
   _bombdisposal = [1000, "my_Bobcat"] execVM "groundWorks.sqf";

*/
/*
private ["_bombs","_bomb1","_bomb2","_bomb3"];


_areasize = 10;
while {true} do
{
   
   _base = getPos _basemarker;
   _bomb1 = _base nearObjects ["IEDLandSmall_F", _areasize];
   _bomb2 = _base nearObjects ["IEDUrbanSmall_F", _areasize];
   _bomb3 = _base nearObjects ["APERSMine", _areasize];
   _bomb4 = _base nearObjects ["APERSBoundingMine", _areasize];
   _bomb5 = _base nearObjects ["IEDLandBig_F", _areasize];
   _bomb6 = _base nearObjects ["IEDUrbanBig_F", _areasize];
   _bomb7 = _base nearObjects ["Claymore_F", _areasize];
   _bomb8 = _base nearObjects ["DemoCharge_F", _areasize];
   _bomb9 = _base nearObjects ["SatchelCharge_F", _areasize];
   _bomb10 = _base nearObjects ["ATMine", _areasize];
   _bomb11 = _base nearObjects ["APERSTripMine", _areasize];
   _bomb12 = _base nearObjects ["APERSTripMine", _areasize]; //reserved for a new mine
   _bombs = _bomb1 + _bomb2 + _bomb3 + _bomb4 + _bomb5 + _bomb6 + _bomb7 + _bomb8 + _bomb9 + _bomb10 + _bomb11 + _bomb12; // Workaround since nearObjects doesnt seem to work with arrays
   if !(Alive _basemarker) exitWith {hint "died"};
   
   if (count _bombs > 0) then
   {
		sleep 3;
      if speed (_basemarker) < 10 then
	  {
		_basemarker groupChat "I`ve find the minefield. Need a minute to disarm it.";
		sleep 2;
		_fuel = 1;
		_fuel = fuel (_basemarker);
		_basemarker setFuel 0;
		_basemarker VehicleChat "20%";
		sleep 1;
		_basemarker VehicleChat "30%";
		sleep 1;
		_basemarker VehicleChat "40%";
		sleep 1;
		_basemarker VehicleChat "50%";
		sleep 1;
		_basemarker VehicleChat "60%";
		sleep 1;
		_basemarker VehicleChat "70%";
		sleep 1;
		_basemarker VehicleChat "80%";
		sleep 1;
		_basemarker VehicleChat "90%";
		sleep 1;
		{deleteVehicle _x} foreach _bombs;
		_basemarker groupChat "Cleared minefield but stay alert.";
		_basemarker setFuel _fuel;
	  };
   };
   sleep 0.5; // Short sleep for catching all the bombs before damage occurs.
  };
  */
