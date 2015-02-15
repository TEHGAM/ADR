/*
@filename: islandConfig.sqf
Author:

	Quiksilver
	
Notes:

	WIP
	Configure the island for the mission.
	"Land_Airport_Tower_ruins_F"
	"Land_LampAirport_F"
	[14520,16705,18]
	_annoyingLamp1 = [0,0,0] nearestObject 529331;
	_annoyingLamp2 = [0,0,0] nearestObject 493984;];

the below doesnt seem to work in MP as of ArmA 1.18.

_ruins1 = nearestObject [[14520,16705,18],"Land_Airport_Tower_ruins_F"];		
deleteVehicle _ruins1;

______________________________________________________________________*/

private ["_airTower","_urbanMarkers","_uav1Hangar","_uav2Hangar","_ugvHangar","_jetHangar"];

_urbanMarkers =["sm1","sm2","sm3","sm4","sm5","sm6","sm7","sm8","sm9","sm10","sm11","sm12","sm13","sm14","sm15","sm16","sm17","sm18","sm19"];
{ _x setMarkerAlpha 0; } count _urbanMarkers;

/*---------- Delete the airport tower beside terminal building

sleep 10;

_airTower = [14520,16705,18] nearestObject 523286;
{ _x setDamage 1 } forEach [_airTower];
*\

sleep 1;

//======= preserve these buildings
/* doesn't work in MP environment .. thanks BIS
_uav1Hangar = [14342,16294,20] nearestObject 524211; 
_uav2Hangar = [14342,16294,20] nearestObject 524212;
_ugvHangar = [14342,16294,20] nearestObject 524433;
_jetHangar = [14342,16294,20] nearestObject 526049;

{ _x allowDamage false; } forEach [_uav1Hangar,_uav2Hangar,_ugvHangar,_jetHangar];
*/
sleep 1;

crossroad disableAI "ANIM";




