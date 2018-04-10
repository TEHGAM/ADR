/*
Author: BACONMOP
usage:
0:position to spawn
*/

_campSelect = _this select 0;
_pos = _this select 1;
_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;

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
