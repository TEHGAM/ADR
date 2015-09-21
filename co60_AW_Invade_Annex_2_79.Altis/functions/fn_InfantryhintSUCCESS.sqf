/*
Author:	ToxaBes
Description: Set reward for successfully completed infantry mission
*/
private ["_infRewards","_veh","_vehName","_vehVarname","_vehPosition","_completeText","_reward","_gun"];
_infRewards =
[   
	["AH-99 «Блэкфут»", "B_Heli_Attack_01_F", [14884,16678.5,0.2]],
	["AFV-4 «Горгона»", "I_APC_Wheeled_03_cannon_F", [14870.5,16666.5,0.2]],
	["MRAP «Ифрит» с пулеметом", "O_MRAP_02_hmg_F", [14859.5,16654.5,0.2]],
	["MRAP «Ифрит» с гранатометом", "O_MRAP_02_gmg_F", [14846.5,16648.5,0.2]],
	["MSE-3 «Марид»", "O_APC_Wheeled_02_rcws_F", [14831.5,16626.5,0.2]],
	["БТР-К «Камыш»", "O_APC_Tracked_02_cannon_F", [14818.5,16613.5,0.2]],
	["T-100 «Варсук»", "O_MBT_02_cannon_F", [14805.5,16600.5,0.2]],
	["Грузовик «Темпест» (медицинский)", "O_Truck_03_medical_F", [14791.5,16583.5,0.2]],
	["Страйдер с пулеметом", "I_MRAP_03_hmg_F", [14776.5,16568.5,0.2]],	
	["FV-720 «Мора»", "I_APC_tracked_03_cannon_F", [14761.5,16552.5,0.2]],
	["ATV AM-1 «Тульчанка»", "B_G_Quadbike_01_F", [14704.5,16486.5,0.2]]
];
_veh = _infRewards call BIS_fnc_selectRandom;
_vehName = _veh select 0;
_vehVarname = _veh select 1;
_vehPosition = _veh select 2;
_completeText = format ["<t align='center'><t size='2.2'>Спецоперация</t><br/><t size='1.5' color='#08b000'>Завершена</t><br/>____________________<br/>За успешное проведение, непосредственные участники операции получают в награду:<br/><br/>%1.<br/><br/>Выдвигайтесь обратно на базу или прямиком на точку захвата.</t>",_vehName];
_reward = createVehicle [_vehVarname,_vehPosition,[],0,"NONE"];
_reward setDir 330;

GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
showNotification = ["CompletedInfantryMission", infantryMarkerText]; publicVariable "showNotification";
showNotification = ["Reward", format ["Ваша команда получила %1!", _vehName]]; publicVariable "showNotification";

if (_reward isKindOf "B_G_Quadbike_01_F") exitWith {
	_gun = createVehicle ["B_GMG_01_high_F",[10,10,10],[],0,"NONE"];
	_gun attachTo [_reward, [0.18,-0.45,1.1]];
};