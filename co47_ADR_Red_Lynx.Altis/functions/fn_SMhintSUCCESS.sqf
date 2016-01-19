private ["_veh", "_vehName", "_vehVarname", "_completeText", "_reward", "_GAU", "_mortar", "_GMG", "_HEL"];

smRewards =
[
	["То-199 «Неофрон» (штурмовик)", "O_Plane_CAS_02_F"],
	["А-164 «Вайпаут» (штурмовик)", "B_Plane_CAS_01_F"],
	["A-143 «Буззард» (штурмовик)", "I_Plane_Fighter_03_CAS_F"],
	["Ми-48 «Кайман»", "O_Heli_Attack_02_black_F"],
	["AH-99 «Блэкфут»", "B_Heli_Attack_01_F"],
	["ПО-30 «Касатка»", "O_Heli_Light_02_F"],
	["AFV-4 «Горгона»", "I_APC_Wheeled_03_cannon_F"],
	["БТР-К «Камыш»", "O_APC_Tracked_02_cannon_F"],
	["ЗСУ-39 «Тигр»", "O_APC_Tracked_02_AA_F"],
	["То-199 «Неофрон» (штурмовик)", "O_Plane_CAS_02_F"],
	["IFV-6a «Гепард»", "B_APC_Tracked_01_AA_F"],
	["T-100 «Варсук»", "O_MBT_02_cannon_F"],
	["MBT-52 «Кума»", "I_MBT_03_cannon_F"],
	["M2A4 «Сламмер» UP", "B_MBT_01_TUSK_F"],
	["Страйдер с пулеметом", "I_MRAP_03_hmg_F"],
	["Страйдер с гранатометом", "I_MRAP_03_gmg_F"],
	["Прототип: Передвижной миномет", "B_G_Offroad_01_repair_F"],
	["WY-55 Хелкат UP", "I_Heli_light_03_F"]
];

smMarkerList =
["smReward1", "smReward2", "smReward3", "smReward4", "smReward5", "smReward6", "smReward7", "smReward8", "smReward9", "smReward10", "smReward11", "smReward12", "smReward13", "smReward14", "smReward15", "smReward16", "smReward17", "smReward18", "smReward19", "smReward20", "smReward21", "smReward22", "smReward23", "smReward24", "smReward25", "smReward26", "smReward27"];

_veh = smRewards call BIS_fnc_selectRandom;

_vehName = _veh select 0;
_vehVarname = _veh select 1;

_completeText = format[
"<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#08b000'>Выполнено</t><br/>____________________<br/>За успешное проведение, непосредственные участники задания получают в награду:<br/><br/>%1.<br/><br/>Выдвигайтесь обратно на базу или прямиком на точку захвата.</t>", _vehName];

_reward = createVehicle [_vehVarname, getMarkerPos "smReward1", smMarkerList, 0, "NONE"];
waitUntil {!isNull _reward};

_reward setDir 284;

_reward lock 3;
GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
if (count sideMarkerText == 2) then {
    sideMarkerText = sideMarkerText select 0;
};
showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
showNotification = ["Reward", format["Ваша команда получила %1!", _vehName]]; publicVariable "showNotification";


if (_reward isKindOf "B_G_Offroad_01_repair_F") exitWith {
	_mortar = createVehicle ["B_Mortar_01_F", getMarkerPos "smReward1", smMarkerList, 0, "NONE"];
	_mortar attachTo [_reward, [0, -2.5, .3]];
};

if (_reward isKindOf "I_Heli_light_03_F") exitWith {
	_HEL = createVehicle ["I_Heli_light_03_F", getMarkerPos "smReward1", smMarkerList, 0, "NONE"];
	_HEL setDir 284;
	_reward setPos [(random 1000), (random 1000), (10000 + (random 20000))];
	_reward setDamage 1;
	_HEL addWeapon ("autocannon_35mm");
	_HEL addMagazine ("680Rnd_35mm_AA_shells_Tracer_Yellow");
};
waitUntil { sleep 600; _reward lock 0;};