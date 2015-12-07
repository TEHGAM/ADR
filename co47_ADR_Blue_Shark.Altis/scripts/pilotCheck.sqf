/* 
Обновление 24.07.15 версия миссии 3.5
Изменена система блокировки вертолетов
*/

_uid = getPlayerUID player;
_whitelist = [
	"76561198053877632",	// tim
	"76561198017758762",	// [K]STELS
	"76561198074604871",	// vosur
	"76561198062030976",	// Noart
	"76561197994763606",	// DeD Pikhto =rus=
	"76561198015092620",	// Rembo
	"76561198163722032",	// Swat
	"76561198001830065"		// evil_c0okie
];

if (_uid in _whitelist) exitWith {};

_pilots = ["B_soldier_repair_F"];	//Специализация пилота

//---------- Место 2-го пилота заблокировано
_aircraft_nocopilot = [
"B_Heli_Transport_03_F",				//Хурон
"O_Heli_Transport_04_covered_F",		//Тару транспортный
"O_Heli_Transport_04_F",				//Тару грузовой
"O_Heli_Light_02_unarmed_F",			//Касатка транспортная
"O_Heli_Light_02_F",					//Касатка боевая
"B_Heli_Transport_01_F",				//Гостхок
"B_Heli_Transport_01_camo_F",			//Гостхок кам
"I_Heli_Transport_02_F",				//Мохаук
"I_Heli_light_03_unarmed_F",			//Хелкат транспортный
"B_Heli_Light_01_armed_F",				//Пауни
"B_Heli_Light_01_F"						//Хамингберд
];

//---------- Место пилота заблокировано
_aircraft_nopilot = [
//--- Вертолеты
"B_Heli_Transport_03_F",				//Хурон
"O_Heli_Transport_04_covered_F",		//Тару транспортный
"O_Heli_Transport_04_F",				//Тару грузовой
"O_Heli_Light_02_unarmed_F",			//Касатка транспортная
"O_Heli_Light_02_F",					//Касатка боевая
"B_Heli_Attack_01_F",					//Блэкфут
"O_Heli_Attack_02_F",					//Кайман
"O_Heli_Attack_02_black_F",				//Кайман черный
"B_Heli_Transport_01_F",				//Гостхок
"B_Heli_Transport_01_camo_F",			//Гостхок кам
"I_Heli_Transport_02_F",				//Мохаук
"I_Heli_light_03_unarmed_F",			//Хелкат транспортный
"I_Heli_light_03_F",					//Хелкат боевой
"B_Heli_Light_01_armed_F",				//Пауни
"B_Heli_Light_01_F",					//Хамингберд

//--- Самолеты
"B_Plane_CAS_01_F",						//А10
"O_Plane_CAS_02_F",						//Неофрон
"I_Plane_Fighter_03_CAS_F",				//Буззард
"I_Plane_Fighter_03_AA_F"				//Буззард АА
];

//---------- Место loadmaster заблокировано
_aircraft_noloadmaster = [
"O_Heli_Transport_04_covered_F",	//Тару транспортный
"O_Heli_Transport_04_F"				//Тару грузовой	
];

waitUntil {player == player};

_iampilot = ({typeOf player == _x} count _pilots) > 0;

while { true } do {
	_oldvehicle = vehicle player;
	waitUntil {vehicle player != _oldvehicle};

	if(vehicle player != player) then {
		_veh = vehicle player;
		
		if((_veh isKindOf "Helicopter" || _veh isKindOf "Plane") && !(_veh isKindOf "ParachuteBase")) then {
			if(!_iampilot && ({typeOf _veh == _x} count _aircraft_nocopilot) > 0) then {
				_forbidden = [_veh turretUnit [0]];
				if(player in _forbidden) then {
					systemChat "Вы должны быть пилотом, чтобы занять место 2-го пилота";
					player action ["getOut", _veh];
				};
			};
			if(!_iampilot && ({typeOf _veh == _x} count _aircraft_nopilot) > 0) then {
				_forbidden = [driver _veh];
				if(player in _forbidden) then {
					systemChat "Вы должны быть пилотом, чтобы летать на этой технике.";
					player action ["getOut", _veh];
				};
			};
			if(!_iampilot && ({typeOf _veh == _x} count _aircraft_noloadmaster) > 0) then {
				_forbidden = [gunner _veh];
				if(player in _forbidden) then {
					systemChat "Вы должны быть пилотом.";
					player action ["getOut", _veh];
				};
			};
		};
	};
};