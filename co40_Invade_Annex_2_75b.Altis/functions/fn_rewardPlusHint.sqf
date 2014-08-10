

private ["_veh","_vehName","_vehVarname","_completeText","_reward"];
_veh = smRewards call BIS_fnc_selectRandom;
	_vehName = _veh select 0;
	_vehVarname = _veh select 1;

	_completeText = format[
	"<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#00B2EE'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>We've given you %1 to help with the fight. You'll find it at base.<br/><br/>Focus on the main objective for now; we'll relay this success to the intel team and see if there's anything else you can do for us. We'll get back to you in 15 - 30 minutes.</t>",_vehName];

	_reward = createVehicle [_vehVarname, getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	if (_reward isKindOf "UAV") then {createVehicleCrew _reward;} else {sleep 1;};
	waitUntil {!isNull _reward};
	_reward setDir 284;

	GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
	showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
	showNotification = ["Reward", format["Your team received %1!", _vehName]]; publicVariable "showNotification";