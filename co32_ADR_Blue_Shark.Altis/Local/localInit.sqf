/*
Triggers by initServer.sqf
Sets up serverside & global stuff
*/
/*Altis*/

//for some scripts
_mapSize = [configfile >> "cfgworlds" >> "Altis","mapSize"] call bis_fnc_returnConfigEntry;
_mapHalf = _mapSize / 2;
mapCent = [_mapHalf,_mapHalf,0];
publicVariable "mapCent";

//hide some stuff:
{hideObjectGlobal _x} foreach nearestTerrainObjects [(getMarkerPos "marker_deletepad"),[],5]; 

_toHide = [];
{
	_allStuff = (getMarkerPos _x) nearObjects 250;
	_fobStuff = _allStuff - nearestTerrainObjects [(getMarkerPos _x), [], 250, false];
	_toHide = _toHide + _fobStuff;
} forEach ["term_pl_res","aac_pl_res","sdm_pl_res","mol_pl_res"];

{_x hideObjectGlobal true;} forEach _toHide;

//admin channel
adminChannelID = radioChannelCreate [[0.8, 0, 0, 1], "Admin Channel", "%UNIT_NAME", [], true];
publicVariable "adminChannelID";
[adminChannelID, [Quartermaster]] remoteExec ["radioChannelAdd", 0, true];

//global
arsenalArray = [Quartermaster, Quartermaster_1, Quartermaster_2, Quartermaster_3, Quartermaster_4, Quartermaster_5];
publicVariable "arsenalArray";
//global
BaseArray = ["respawn_west","FOB_Martian","FOB_Marathon","FOB_Guardian","FOB_Last_Stand","USS_Freedom"/*,"safeZoneHill"*/]; 
publicVariable "BaseArray";

amountOfAOsToComplete = 85;
publicVariable "amountOfAOsToComplete";



