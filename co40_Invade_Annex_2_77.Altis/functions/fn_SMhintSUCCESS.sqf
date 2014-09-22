private ["_veh","_vehName","_vehVarname","_completeText","_reward"];

smRewards =
[
	["a To-199 Neophron (CAS)", "O_Plane_CAS_02_F"],
	["an A-164 Wipeout (CAS)", "B_Plane_CAS_01_F"],
	["an Mi-48 Kajman", "O_Heli_Attack_02_black_F"],
	["an AH-99 Blackfoot", "B_Heli_Attack_01_F"],
	["a PO-30 Orca", "O_Heli_Light_02_F"],
	["a WY-55 Hellcat", "I_Heli_light_03_F"],
	["an AH-9 Pawnee", "B_Heli_Light_01_armed_F"],
	["an FV-720 Mora", "I_APC_tracked_03_cannon_F"],
	["an FV-720 Mora", "I_APC_tracked_03_cannon_F"],
	["an AFV-4 Gorgon", "I_APC_Wheeled_03_cannon_F"],
	["an AFV-4 Gorgon", "I_APC_Wheeled_03_cannon_F"],
	["an IFV-6a Cheetah", "B_APC_Tracked_01_AA_F"],
	["an IFV-6a Cheetah", "B_APC_Tracked_01_AA_F"],
	["an AMV-7 Marshall", "B_APC_Wheeled_01_cannon_F"],
	["a T-100 Varsuk", "O_MBT_02_cannon_F"],
	["an MBT-52 Kuma", "I_MBT_03_cannon_F"],
	["an M2A4 Slammer (Urban Purpose)", "B_MBT_01_TUSK_F"]
];
smMarkerList =
["smReward1","smReward2","smReward3","smReward4","smReward5","smReward6","smReward7","smReward8","smReward9","smReward10","smReward11","smReward12","smReward13","smReward14","smReward15","smReward16","smReward17","smReward18","smReward19","smReward20","smReward21","smReward22","smReward23","smReward24","smReward25","smReward26","smReward27"];

_veh = smRewards call BIS_fnc_selectRandom;

_vehName = _veh select 0;
_vehVarname = _veh select 1;

_completeText = format[
"<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#08b000'>ВЫПОЛНЕНО</t><br/>____________________<br/>Отличная работа, так держать! Такими темпами вражеские силы не смогут долго устоять перед вашим натиском.<br/><br/>В награду, мы отправляем вам на базу %1.<br/><br/Возвращайтесь к основному заданию, командование оповестит вас о новых развитиях по ходу текущей разведки. До связи через 15-30 минут!</t>",_vehName];

_reward = createVehicle [_vehVarname, getMarkerPos "smReward1",smMarkerList,0,"NONE"];
waitUntil {!isNull _reward};

_reward setDir 284;

{
	_x addCuratorEditableObjects [[_reward], false];
} foreach adminCurators;

GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
showNotification = ["Reward", format["Ваша команда получила %1!", _vehName]]; publicVariable "showNotification";
