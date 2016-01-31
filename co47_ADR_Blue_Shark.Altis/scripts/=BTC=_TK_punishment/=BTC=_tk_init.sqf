/*
	Created by =BTC= Giallustio
	version 0.3
	Visit us at: 
	http://www.blacktemplars.altervista.org/
	06/03/2012
*/
//Def
BTC_tk_blackscreen_punishment = 0;
BTC_tk_last_warning = 10;

BTC_fnc_tk_PVEH =
{
	//0 - first aid - create // [0,east,pos]
	//1 - first aid - delete
	_array = _this select 1;
	_name  = _array select 0;
	_punisher = _array select 1;
	hint format ["%1 убил своего и был наказан игроком %2", _name, _punisher];
	if (name player == _name) then {_spawn = [] spawn BTC_Teamkill;};
};
BTC_EH_killed =
{
	_body = _this select 0;
	_killer = _this select 1;
	_veh_body = vehicle _body;
	_veh_killer = vehicle _killer;
	_name = name _killer;
	if (_name != name _body && BTC_vip find (name _killer) == -1) then {
		if (side _killer == BTC_side && _veh_body != _veh_killer) then {
			//saving TEAMKILL info in server logs
			["//========================================", "diag_log", false] call BIS_fnc_MP;
			[format ["TEAMKILL: '%1[%3]' killed '%2[%4]'", _name, name _body, getPlayerUID _killer, getPlayerUID _body], "diag_log", false] call BIS_fnc_MP;
			_veh_crew = fullCrew _veh_killer;
			if ((count _veh_crew) > 0) then {
				{
					if (((_veh_crew select _forEachIndex) select 1) != "cargo") then {
						[format ["TEAMKILL: '%1' %2 '%3[%4]'", typeOf _veh_killer, (_veh_crew select _forEachIndex) select 1, name ((_veh_crew select _forEachIndex) select 0), getPlayerUID ((_veh_crew select _forEachIndex) select 0)], "diag_log", false] call BIS_fnc_MP;
					};
				} forEach _veh_crew;
			};
			["//========================================", "diag_log", false] call BIS_fnc_MP;

			_killer spawn {
				hint format ["Вас убил %1! Вы можете наказать игрока через меню действий (колесо мыши)", name _this];
				WaitUntil {Alive player};
				_action = player addAction [("<t color=""#EF5350""><img image='\a3\ui_f\gui\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa' size='1.0'/> ") + ("Наказать " + name _this) + "</t>","scripts\=BTC=_TK_punishment\=BTC=_punish_action.sqf",[name _this], 1, true, true, "", "true"];
				_timeout = time + 60;
				WaitUntil {sleep 1; (_timeout < time)};
				player removeAction _action;
			};
		};
	};
};
BTC_Teamkill =
{
	player addrating 9999;
	BTC_teamkiller = BTC_teamkiller + 1;
	_uid = getPlayerUID player;
	BTC_logic setVariable [_uid,BTC_teamkiller,true];
	switch (true) do
	{
		case (BTC_teamkiller <= BTC_tk_blackscreen_punishment) : 
		{
			titleText ["ПРЕКРАТИТЕ УБИВАТЬ СВОИХ! \ STOP TEAMKILLING!","BLACK FADED"];
			sleep 3;
			titleText ["ПРЕКРАТИТЕ УБИВАТЬ СВОИХ! \ STOP TEAMKILLING!","PLAIN"];
		};
		case (BTC_teamkiller > BTC_tk_blackscreen_punishment && BTC_teamkiller <= BTC_tk_last_warning) : 
		{
			private ["_n","_array_tk","_msg"];
			_msg = "";
			disableUserInput true;
			if (BTC_teamkiller == BTC_tk_last_warning) then
			{
				_msg = "STOP TEAMKILLING, LAST WARNING";
			} else {_msg = "ВАС НАКАЗАЛИ ЗА УБИЙСТВО СВОИХ \ YOU HAVE BEEN PUNISHED FOR TEAMKILLING!";};
			player setPos [0,0,0];
			_n = 0;
			while {_n < 120} do
			{
				titleText [_msg,"BLACK FADED"];
				_n = _n + 1;
				sleep 1;
			};
			disableUserInput false;
			player setDamage 1;
		};
		case (BTC_teamkiller > BTC_tk_last_warning) : 
		{

			disableUserInput true;
			titleText ["ВАС НАКАЗАЛИ ЗА УБИЙСТВО СВОИХ! \ YOU HAVE BEEN PUNISHED FOR TEAMKILLING! \ ВАМ ЗДЕСЬ БОЛЬШЕ НЕ РАДЫ \ YOU ARE NOT WELCOME ANYMORE","BLACK FADED"];
			player setPos [0,0,0];
			while {true} do
			{
				titleText ["ВАС НАКАЗАЛИ ЗА УБИЙСТВО СВОИХ \ YOU HAVE BEEN PUNISHED FOR TEAMKILLING! \ ВАМ ЗДЕСЬ БОЛЬШЕ НЕ РАДЫ \ YOU ARE NOT WELCOME ANYMORE","BLACK FADED"];
				sleep 1;
			};
			disableUserInput false;
		};
	};
};
if (isServer) then
{
	BTC_tk_PVEH = [];publicVariable "BTC_tk_PVEH";
};
if (!isDedicated) then
{
	[] spawn
	{
		private ["_uid","_array_tk"];
		waitUntil {!isNull player};
		waitUntil {player == player};
		player addEventHandler ["Killed", BTC_EH_killed];
		"BTC_tk_PVEH" addPublicVariableEventHandler BTC_fnc_tk_PVEH;
		player addrating 9999;
		BTC_side = side player;
		BTC_vip = [];
		_uid = getPlayerUID player;
		if (!isNil "BTC_logic") then {
		    if (BTC_logic getVariable _uid) then {
		    	BTC_logic setVariable [_uid,0,true];
		    	BTC_teamkiller = 0;
		    } else {
		    	BTC_teamkiller = BTC_logic getVariable _uid;
		    	if (BTC_teamkiller > BTC_tk_last_warning) then {
		    		_tk = [] spawn BTC_Teamkill;
		    	};
		    };
		};
	};
};
