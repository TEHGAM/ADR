/* IA3_createAA.sqf
| creates 5 anti-air units randomly across the island of Altis.
| some global variables must be defined somewhere:
| spCenter defines the center of the map.
| spBlacklist defines the players' base, so units can't spawn there.
| BIS_fnc_findSafePos is a handy function for this, eg;
*/


spCenter = [16000,16000];
spBlacklist = [[[10000,13000],[13000,10000]]];

private ["_unitsToCreate", "_currentUnit", "_minDistance", "_unitPosArray", "_createUnit"];

_minDistance = 1400;
_unitsToCreate = 5;
_currentUnit = 1;
_unitPosArray = [];
_createUnit = false;


while { _currentUnit <= _unitsToCreate } do
{	_aaLoc = [ mapCent,1,-1,1,0,2,0 ] call BIS_fnc_findSafePos;
	if ( _currentUnit > 1 ) then
	{	{	if ( _x distance _aaLoc < _minDistance ) exitWith {};
		} forEach _unitPosArray;
		_unitPosArray pushBack _aaLoc;
		diag_log format ['Position of unit #%1: %2', _currentUnit, _aaLoc];
		_currentUnit = _currentUnit + 1;
		_createUnit = true;
	}
	else
	{	_unitPosArray pushBack _aaLoc;
		diag_log format ['Position of unit #1: %1', _aaLoc];
		_currentUnit = _currentUnit + 1;
		_createUnit = true;
	};
	
	if ( _createUnit ) then
	{	_unitType = floor random 3;
		switch ( _unitType ) do
		{	case 0 :
			{	
				_safePos = [_aaLoc,0,50,10,0,1,0] call BIS_fnc_findSafePos;
				_camp = [
					["Land_HBarrier_5_F",[4.03125,0.453125,-0.00371361],192,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-0.763672,1.08008,0.00265884],135,1,0,[0,-0],"","",true,false], 
					["O_static_AA_F",[-0.25,-2.74805,-0.0713024],181.127,1,0,[-0.229122,-0.24636],"","",true,false], 
					["Land_HBarrier_5_F",[-1.77832,5.55859,-0.00571632],73,1,0,[0,0],"","",true,false], 
					["O_static_AA_F",[-3.55273,2.17188,-0.0704403],293.003,1,0,[0.0118872,-0.0234264],"","",true,false], 
					["O_static_AA_F",[2.0625,3.98828,-0.0722446],62.0024,1,0,[-0.136118,0.0695288],"","",true,false], 
					["Land_CncBarrier_F",[3.2793,-3.52148,0.0191402],126.589,1,0,[0,-0],"","",true,false], 
					["Land_CncBarrier_F",[-1.14941,-4.86719,0.0108795],190.589,1,0,[0,0],"","",true,false], 
					["Land_CncBarrier_F",[1.29492,-4.85742,0.0173912],167.589,1,0,[0,-0],"","",true,false], 
					["Land_HBarrier_5_F",[4.88574,-1.88477,0.00999641],283,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-6.46484,-1.50781,0.00689888],44,1,0,[0,0],"","",true,false], 
					["Land_CncBarrier_F",[-6.83789,0.466797,-0.00420761],255.589,1,0,[0,0],"","",true,false], 
					["Land_CncBarrier_F",[5.33594,4.43555,0.00520706],74.5887,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-4.24902,6.13672,-0.00841331],342,1,0,[0,0],"","",true,false], 
					["Land_CncBarrier_F",[2.02344,7.18945,-0.00217247],357.589,1,0,[0,0],"","",true,false], 
					["Land_CncBarrier_F",[-6.91797,2.88672,-0.00841331],101.589,1,0,[0,-0],"","",true,false], 
					["Land_CncBarrier_F",[-5.70605,4.94922,-0.00841331],318.589,1,0,[0,0],"","",true,false], 
					["Land_CncBarrier_F",[4.10254,6.38281,-9.53674e-006],42.5887,1,0,[0,0],"","",true,false], 
					["Land_Razorwire_F",[11.7109,-1.13477,0.0104542],194,1,0,[0,0],"","",true,false], 
					["Land_Razorwire_F",[-9.36914,-7.72852,-7.62939e-005],316,1,0,[0,0],"","",true,false], 
					["Land_Razorwire_F",[-3.95801,13.1445,-0.00841522],74,1,0,[0,0],"","",true,false]
				];
				[_safePos,0,_camp] call BIS_fnc_ObjectsMapper;
				{
					createVehicleCrew _x;
				} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
				_grp = [_aaLoc, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA" )] call BIS_fnc_spawnGroup;
				[_grp, _safePos, 75] call bis_fnc_taskPatrol;
			};
			case 1 :
			{	
				_safePos = [_aaLoc,0,50,10,0,1,0] call BIS_fnc_findSafePos;
				_camp = [
					["Land_CncBarrier_F",[5.83496,-0.208984,-0.00689316],279.589,1,0,[0,0],"","",true,false], 
					["Land_CncBarrier_F",[5.39844,-2.73438,-0.0074749],279.589,1,0,[0,0],"","",true,false], 
					["Land_CncBarrier_F",[6.27441,2.32227,-0.00335693],279.589,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_3_F",[-2.33594,6.49414,-0.00540733],339.505,1,0,[0,0],"","",true,false], 
					["Land_CncBarrier_F",[4.97363,-5.25977,-0.0109158],279.589,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-3.37207,6.08008,-0.018919],159.533,1,0,[0,-0],"","",true,false], 
					["RoadCone_F",[6.64258,4.4668,1.90735e-005],11.2083,1,0.0096546,[-0.0878033,0.0639857],"","",true,false], 
					["Land_HBarrier_3_F",[-2.9541,-7.73047,-0.0223255],218.634,1,0,[0,0],"","",true,false], 
					["O_Truck_03_ammo_F",[8.24512,-1.07813,-0.0351105],9.06846,1,0,[-0.459333,0.537398],"","",true,false], 
					["Land_HBarrier_5_F",[-5.58691,-5.62695,-0.0223255],219.472,1,0,[0,0],"","",true,false], 
					["RoadCone_F",[4.65234,-7.41406,1.52588e-005],11.2045,1,0.0106619,[-0.102036,0.138681],"","",true,false], 
					["O_APC_Tracked_02_AA_F",[-9.33398,0.96875,-0.0542088],281.582,1,0,[0.89593,0.00810015],"","",true,false], 
					["Land_HBarrier_5_F",[0.771484,11.9141,-0.00248909],100.677,1,0,[0,-0],"","",true,false], 
					["Land_HBarrier_5_F",[-2.86914,-7.87305,-0.0223255],100.677,1,0,[0,-0],"","",true,false], 
					["Land_HBarrier_5_F",[-8.29395,4.48242,-0.0154495],190.214,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-9.6123,-2.52539,-0.0258408],190.214,1,0,[0,0],"","",true,false], 
					["Land_HBarrierBig_F",[12.1719,1.56445,0.00715446],280.097,1,0,[0,0],"","",true,false], 
					["Land_HBarrierBig_F",[10.9453,-6.81641,-0.000255585],280.097,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-12.8105,3.9375,-0.0231266],100.677,1,0,[0,-0],"","",true,false], 
					["Land_HBarrier_Big_F",[11.4453,9.24414,0.0125713],253.803,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_Big_F",[7.73242,-13.7109,-0.0142441],132.981,1,0,[0,-0],"","",true,false], 
					["Land_Razorwire_F",[-0.702148,14.6836,0.0176296],244,1,0,[0,0],"","",true,false], 
					["Land_Razorwire_F",[-8.42383,-16.6914,-0.0145702],316,1,0,[0,0],"","",true,false], 
					["Land_Razorwire_F",[8.9043,15.7207,0.0296154],244,1,0,[0,0],"","",true,false], 
					["Land_Razorwire_F",[0.661133,-21.0527,-0.0167427],316,1,0,[0,0],"","",true,false]
				];
				[_safePos,0,_camp] call BIS_fnc_ObjectsMapper;
				{
					createVehicleCrew _x;
					_x setFuel 0;
				} forEach nearestObjects [_safePos, ["APC_Tracked_02_base_F"], 50];
				_grp = [_aaLoc, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Mechanized" >> "OIA_MechInf_AA" )] call BIS_fnc_spawnGroup;
				[_grp, _safePos, 75] call bis_fnc_taskPatrol;
			};
			case 2 :
			{	
				_safePos = [_aaLoc,0,50,10,0,1,0] call BIS_fnc_findSafePos;
				_camp = [
					["Land_HBarrier_5_F",[1.33301,4.79785,0],159.533,1,0,[0,-0],"","",true,false], 
					["Land_HBarrier_5_F",[4.45117,-3.35449,0],309.727,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-3.96484,2.80859,0],159.533,1,0,[0,-0],"","",true,false], 
					["Land_HBarrier_5_F",[0.916992,-7.69238,0],309.727,1,0,[0,0],"","",true,false], 
					["Box_East_AmmoVeh_F",[-1.06543,-7.21289,0],38.987,1,0,[0,0],"","",true,false], 
					["Box_East_AmmoVeh_F",[-2.44434,-8.91504,0.0007267],38.987,1,0,[0,0],"","",true,false], 
					["Land_Razorwire_F",[1.55859,8.02539,-0.00403786],281.51,1,0,[0,0],"","",true,false], 
					["O_APC_Tracked_02_AA_F",[-9.92773,-2.30566,-0.0541286],281.581,1,0,[0.869591,-0.0951148],"","",true,false], 
					["Land_HBarrier_5_F",[-2.64258,-11.9922,-0.0033474],309.727,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-6.17871,-8.90137,0.00652122],219.472,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-8.8877,1.21094,0],190.214,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_3_F",[-3.54688,-11.0039,0.00553513],218.634,1,0,[0,0],"","",true,false], 
					["Land_Razorwire_F",[10.3975,-0.0400391,-0.00900078],0,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-10.2031,-5.7959,0.0117664],190.214,1,0,[0,0],"","",true,false], 
					["Land_HBarrier_5_F",[-13.4033,0.667969,0.00956154],100.677,1,0,[0,-0],"","",true,false]
				];
				[_safePos,0,_camp] call BIS_fnc_ObjectsMapper;
				{
					createVehicleCrew _x;
					_x setFuel 0;
				} forEach nearestObjects [_safePos, ["APC_Tracked_02_base_F"], 50];
				_grp = [_aaLoc, EAST, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Armored" >> "OIA_TankPlatoon_AA" )] call BIS_fnc_spawnGroup;
				[_grp, _safePos, 75] call bis_fnc_taskPatrol;
			};
		};
		_createUnit = false;
	};
};