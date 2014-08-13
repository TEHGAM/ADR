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
   2. Vehicle name
   
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
