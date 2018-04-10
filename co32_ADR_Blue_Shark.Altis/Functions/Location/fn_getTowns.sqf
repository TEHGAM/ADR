/*
| Author: 
|
|	Pfc.Christiansen
|_____
|
|   Description: Call this to get a random town location i.e : _pos = call AW_fnc_findTown; 
|		Returns: Town position.
|	
|	Created: 26/10-2015
|	Last modified: 
|	Made for AhoyWorld.
*/
_towns = nearestLocations [mapCent, ["NameVillage","NameCity","NameCityCapital"], 25000];
_town = _towns call BIS_fnc_selectRandom;
_town