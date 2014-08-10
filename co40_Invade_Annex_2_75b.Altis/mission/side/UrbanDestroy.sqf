if (!isServer) exitwith {};

private ["_ID","_smHint","_smMkr","_smPos","_object","_disname","_objectListArray","_objectType","_taskTitle","_SideMissionComplete","_taskDescription"];

	_smMkr=(_this select 0);
	_smPos=markerpos _smMkr;
	_object=(_this select 1);
// SET MISSION	
	_object setPosATL _smPos;
	"SM_Marker" setMarkerPos markerpos _smMkr;

	_objectType= ["weapons crate","weapons cache","weapons shipment"];
	_disname= _objectType call BIS_fnc_selectRandom;
	
// SET HINT
	_taskTitle="Destroy the " + _disname;
	_smHint=floor (random 3);
	
SWITCH(_smHint)do 
{
case 0:{
_taskDescription = format ["OPFOR are selling explosives to insurgents. Take them out and neutralize the cache.",_disname];
};
case 1:{
_taskDescription = format ["The enemy is supplying insurgents with advanced weapons and explosives. Neutralize them!",_disname];
};
case 2:{
_taskDescription = format ["Locals are reporting CSAT forces supplying the insurgency with explosives. Don't let the deal go through!",_disname];
};
};

_ID=format ["%1%2",_disname,_smHint];
				
	_SideMissionComplete = format ["<t color='#2159D1' size='1.6' shadow='1' shadowColor='#000000' align='center'>Side Mission</t><br/><br/><t color='#FFF700' size='1.6' shadow='1' shadowColor='#000000' align='center'>%1</t><br/><br/><t color='#EEEEEE' size='1.3' shadow='1' shadowColor='#000000' align='center'>%2</t><br/><br/><t color='#EEEEEE' size='1.3' shadow='1' shadowColor='#000000' align='center'>Get your CQB gear on!</t><br/><br/>",_taskTitle,_taskDescription];
	
GlobalHint = _SideMissionComplete; publicVariable "GlobalHint"; hintsilent parseText _SideMissionComplete;
		