
private ["_smDelay","_urbanSidemkrArray","_urbanSmType","_answer","_smCount","_smLimit","_sideActive","_currentSM","_objectListArray","_currentSMType","_object","_enemyType","_EOSspawnDistance"];
if (!isServer) exitwith {};

_smDelay=(_this select 0);

_urbanSidemkrArray=["sm1","sm2","sm3","sm4","sm5","sm6","sm7","sm8","sm9","sm10","sm11","sm12","sm13","sm14","sm15","sm16","sm17","sm18","sm19","sm20"];
{ _x setMarkerAlpha 0; } count _urbanSidemkrArray;
_objectListArray=[smUrbanObject1,smUrbanObject2];
_urbanSmType=["mission\side\UrbanDestroy.sqf"];
_answer=[true,false];

_smCount = 0;
_smLimit = (count _urbanSidemkrArray);//SET IN DESCRIPTION

_sideActive=true;

while {_sideActive} do {
sleep _smDelay;

		if ((count _urbanSidemkrArray) == 0) exitwith {_sideActive=false; };
		if (_smCount == _smLimit) exitwith {_sideActive=false;};
			_currentSMType=_urbanSmType select (floor(random(count _urbanSmType)));
			_currentSM=_urbanSidemkrArray select (floor(random(count _urbanSidemkrArray)));
			_urbanSidemkrArray=_urbanSidemkrArray - [_currentSM];
			_object=_objectListArray select (floor(random(count _objectListArray)));
		SM_COMPLETE=false;
		null =[_currentSM,_object] execVM
                        _currentSMType;
			_enemyType=0;
			_EOSspawnDistance=1000;
			
		[[_currentSM],[6,1],[7,1],[0,0],[0],[0],[0,0],[5,1,1200,EAST,FALSE,FALSE]] call EOS_Spawn;
		sleep 5;
		[[_currentSM],[3,1],[4,1],[0,0],[0],[0],[0,0],[3,1,1200,EAST,FALSE,FALSE]] call EOS_Spawn;

	waituntil {SM_COMPLETE};
		[] call QS_fnc_rewardPlusHint;
		_smCount=_smCount + 1;
			"SM_Marker" setMarkerPos [-10000,-10000,-10000];
			{
			_x setpos [0,0,0];
			}foreach _objectListArray;
			
			sleep 120;
			[[_currentSM]] call EOS_deactivate;
};
