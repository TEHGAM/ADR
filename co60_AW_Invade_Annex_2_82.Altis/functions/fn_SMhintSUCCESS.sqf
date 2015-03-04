	private ["_veh","_vehName","_vehVarname","_completeText","_reward","_GAU","_rabbit","_mortar"];

smRewards =
[
 ["То-199 «Неофрон» (штурмовик)", "O_Plane_CAS_02_F"],
  ["А-164 «Вайпаут» (штурмовик)", "B_Plane_CAS_01_F"],
  ["A-143 «Буззард» (штурмовик)", "I_Plane_Fighter_03_CAS_F"],
  ["MQ4A «Грейхок»", "B_UAV_02_F"],
  ["Ми-48 «Кайман»", "O_Heli_Attack_02_black_F"],
  ["AH-99 «Блэкфут»", "B_Heli_Attack_01_F"],
  ["ПО-30 «Касатка»", "O_Heli_Light_02_F"],
  ["WY-55 «Хеллкэт»", "I_Heli_light_03_F"],
  ["FV-720 «Мора»", "I_APC_tracked_03_cannon_F"],
  ["AFV-4 «Горгона»", "I_APC_Wheeled_03_cannon_F"],
  ["IFV-6a «Гепард»", "B_APC_Tracked_01_AA_F"],
  ["T-100 «Варсук»", "O_MBT_02_cannon_F"],
  ["MBT-52 «Кума»", "I_MBT_03_cannon_F"],
  ["M2A4 «Сламмер» UP ", "B_MBT_01_TUSK_F"]
];
smMarkerList =
["smReward1","smReward2","smReward3","smReward4","smReward5","smReward6","smReward7","smReward8","smReward9","smReward10","smReward11","smReward12","smReward13","smReward14","smReward15","smReward16","smReward17","smReward18","smReward19","smReward20","smReward21","smReward22","smReward23","smReward24","smReward25","smReward26","smReward27"];

_veh = smRewards call BIS_fnc_selectRandom;

_vehName = _veh select 0;
_vehVarname = _veh select 1;

_completeText = format[
"<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#08b000'>COMPLETE</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>We've given you %1 to help with the fight. You'll find it at base.<br/><br/>Focus on the main objective for now; we'll relay this success to the intel team and see if there's anything else you can do for us. We'll get back to you in 10-15 minutes.</t>",_vehName];

_reward = createVehicle [_vehVarname, getMarkerPos "smReward1",smMarkerList,0,"NONE"];
waitUntil {!isNull _reward};

_reward setDir 284;

GlobalHint = _completeText; publicVariable "GlobalHint"; hint parseText _completeText;
showNotification = ["CompletedSideMission", sideMarkerText]; publicVariable "showNotification";
showNotification = ["Reward", format["Your team received %1!", _vehName]]; publicVariable "showNotification";

if (_reward isKindOf "O_Plane_CAS_02_F") exitWith { 
	_reward removeMagazine "120Rnd_CMFlare_Chaff_Magazine";
	_reward addMagazine "60Rnd_CMFlare_Chaff_Magazine";
};
if (_reward isKindOf "B_Plane_CAS_01_F") exitWith { 
	_reward removeMagazine "120Rnd_CMFlare_Chaff_Magazine";
	_reward addMagazine "60Rnd_CMFlare_Chaff_Magazine";
};
if (_reward isKindOf "B_Heli_Light_01_armed_F") exitWith { 
	_reward setObjectTexture[0, 'A3\Air_F\Heli_Light_01\Data\skins\heli_light_01_ext_digital_co.paa'];
};
if (_reward isKindOf "Rabbit_F") exitWith {
	_GAU = createVehicle ["B_Heli_Light_01_armed_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_GAU setDir 284;
	_reward setDamage 1;
	_GAU removeMagazine ("5000Rnd_762x51_Belt");
	_GAU removeWeapon ("M134_minigun");
	_GAU addWeapon ("HMG_127_APC");
	_GAU addMagazine ("500Rnd_127x99_mag_Tracer_Red");
	{_x addCuratorEditableObjects [[_GAU], false];} foreach adminCurators;
};
if (_reward isKindOf "B_G_Offroad_01_repair_F") exitWith {
	_mortar = createVehicle ["B_Mortar_01_F", getMarkerPos "smReward1",smMarkerList,0,"NONE"];
	_mortar attachTo [_reward,[0,-2.5,.3]];
};
{
	_x addCuratorEditableObjects [[_reward], false];
} foreach adminCurators;
