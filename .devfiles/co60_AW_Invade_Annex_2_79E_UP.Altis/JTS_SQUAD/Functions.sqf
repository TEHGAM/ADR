//ALL FUNCTIONS MADE BY JTS

waitUntil {!isNull player}; // Do not remove that



// EDITABLE VARIABLES (BEGIN)

JTS_SquadSize = 40;			// Set the maximum number of units in one squad. Attention! If you have more units in your squad than the limit - a unit will be removed from your squad, until the squad-limit and amount of units in your squad will not be the same as variable JTS_SquadSize. Do NOT use values lower than 3. Value 5 means, 5 units. Also commander + his units = 5. His units = 4. Maximum: 50
JTS_PROHIBIT_INVITES = 0; 		// if 0 - invitations are allowed on mission-start. If 1 - invitations are prohibited on mission-start
JTS_RND_PASS = 0; 			// if 0 - players don't have password on mission-start. If 1 - random password will be created for every player on mission-start
JTS_REQ_STATS = 1;			// if 0 - requesting the status of player is not possible at mission start. if 1 - every player can check the status of any player at mission start.

// EDITABLE VARIABLES (END)



private ["_PassGen","_PassChars"];

if (typeName JTS_SquadSize != "SCALAR") then {JTS_SquadSize = 5};
if (typeName JTS_PROHIBIT_INVITES != "SCALAR") then {JTS_PROHIBIT_INVITES = 0};
if (typeName JTS_RND_PASS != "SCALAR") then {JTS_RND_PASS = 0};
if (typeName JTS_REQ_STATS != "SCALAR") then {JTS_REQ_STATS = 1};

if (JTS_SquadSize < 3 || JTS_SquadSize > 50) then {JTS_SquadSize = 5};
if (JTS_PROHIBIT_INVITES < 0 || JTS_PROHIBIT_INVITES > 1) then {JTS_PROHIBIT_INVITES = 0};
if (JTS_RND_PASS < 0 || JTS_RND_PASS > 1) then {JTS_RND_PASS = 0};
if (JTS_REQ_STATS < 0 || JTS_REQ_STATS > 1) then {JTS_REQ_STATS = 1};

if (JTS_RND_PASS > 0) then
{
	_PassGen = "";
	_PassChars = ["q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","l","0","1","2","3","4","5","6","7","8","9"];

	for "_i" from 0 to 3 + (floor (random 4)) do
	{
		_PassGen = _PassGen + (_PassChars select (floor (random (count _PassChars))));
	};
}

else
{
	_PassGen = "";
};

player setVariable ["JTS_PASS",_PassGen,true];
player setVariable ["JTS_INVITES",JTS_PROHIBIT_INVITES,true];
player setVariable ["JTS_REQ",JTS_REQ_STATS,true];
JTS_DLGS = 0;

if (player != leader (group player) && !isPlayer (leader (group player))) then {[player] joinSilent grpnull};

JTS_FNC_BROADCAST =
{
	_Person = _this select 0;
	_Message = _this select 1;
	
	_Person groupchat _Message;

	[] spawn JTS_FNC_ADD
};

JTS_FNC_SWITCH =
{
	for "_i" from 0 to (count _this -1) do
	{
		_id = (_this select _i) select 0;
		_bool = (_this select _i) select 1;
		_show = (_this select _i) select 2;
		_str = (_this select _i) select 3;
	
		ctrlEnable [_id, _bool];
		ctrlShow [_id, _show];
		ctrlsettext [_id, _str];
	};
};

JTS_FNC_ADD =
{
	private ["_Path","_Find","_R","_G","_B","_A"];

	JTS_UNP = allUnits;
	JTS_DLGS = 1;

	lbClear 0001;
	lbClear 0002;
	ctrlEnable [0001, false];
	ctrlEnable [0009, false];
	ctrlEnable [0010, false];
	ctrlEnable [0011, false];
	ctrlEnable [0012, false];
	ctrlEnable [0013, false];
	ctrlEnable [0014, false];
	ctrlEnable [0017, false];

	_R = (profilenamespace getvariable ['GUI_BCG_RGB_R',0]);
	_G = (profilenamespace getvariable ['GUI_BCG_RGB_G',1]);
	_B = (profilenamespace getvariable ['GUI_BCG_RGB_B',1]);
	_A = (profilenamespace getvariable ['GUI_BCG_RGB_A',1]);

	_Find = 0;
	{
     		if (!isNull _x) then
     		{
          		if (alive _x && _x == leader group _x && isPlayer _x && Side _x == Side player) then
          		{
               		lbAdd [0001, name _x];
				lbSetPicture [0001, (lbSize 0001) - 1, [_x, "texture"] call BIS_fnc_rankParams];
				lbSetPictureColor [0001, (lbSize 0001) - 1, [_R, _G, _B, _A]];
				lbSetPictureColorSelected [0001, (lbSize 0001) - 1, [_R, _G, _B, _A]];
               		lbSetValue [0001, (lbSize 0001) - 1, _Find];
        		};	_Find = _Find + 1;
     		};
	} forEach JTS_UNP;

	lbsetcursel [0001, 0];

	for "_i" from 0 to (lbSize 0001) do
	{
		if (player in units group (JTS_UNP select (lbValue [0001, _i]))) then
		{
			lbsetcursel [0001, _i];
			_i = (lbSize 0001);
		};
	};			[[0003,true,true,""],[0004, false,false,""],[0005,false,false,""],[0008,true,false,""]] call JTS_FNC_SWITCH;ctrlEnable [0001, true];JTS_DLGS = 0;
				ctrlEnable [0009, true];
				ctrlEnable [0010, true];
				ctrlEnable [0011, true];
				ctrlEnable [0012, true];
				ctrlEnable [0013, true];
				ctrlEnable [0014, true];
				ctrlEnable [0017, true];
};

JTS_FNC_PERMISSIONS =
{
	{lbAdd [0007, _x]} foreach ["Разрешить отправку приглашений","Избегать приглашения"];
	{lbSetValue [0007, (lbSize 0007) - 1, _x]} foreach [(lbSize 0007) - 1];
	lbsetcursel [0007, player getVariable "JTS_INVITES"];
};

JTS_FNC_PLAYERS =
{
	private ["_R","_G","_B","_A","_Find"];

	lbClear 0002;

	JTS_UNITS = units group (allUnits select _this);

	_R = (profilenamespace getvariable ['GUI_BCG_RGB_R',0]);
	_G = (profilenamespace getvariable ['GUI_BCG_RGB_G',1]);
	_B = (profilenamespace getvariable ['GUI_BCG_RGB_B',1]);
	_A = (profilenamespace getvariable ['GUI_BCG_RGB_A',1]);

	_Find = 0;
	{
		if (!isNull _x) then
		{
			if (alive _x && _x != leader group _x) then
			{
				lbAdd [0002, name _x];
				lbSetValue [0002, (lbSize 0002) - 1, _Find];
				lbSetPicture [0002, (lbSize 0002) - 1, [_x, "texture"] call BIS_fnc_rankParams];
				lbSetPictureColor [0002, (lbSize 0002) - 1, [_R, _G, _B, _A]];
				lbSetPictureColorSelected [0002, (lbSize 0002) - 1, [_R, _G, _B, _A]];
			};

			_Find = _Find + 1;
		};
	} foreach JTS_UNITS;lbSetCursel [0002, 0];
};

JTS_FNC_JOIN =
{
	private ["_Commander","_Access","_str"];

	_Commander = _this select 0;
	_Access = _this select 1;
	_str = "Вы не можете взаимодействовать с этим человеком из-за следующих причин:\n\n1. Этот человек не в игре.\n2. Он мертв\n3. Это бот\n4. Он враг\n5. Вы мертвы";

	if (lbSize 0001 < 1) exitWith {ctrlsettext [0006, "Вы не выбрали ни одного игрока"]};

	if (!(JTS_UNP select _Commander call JTS_FNC_STATS) || !isPlayer (JTS_UNP select _Commander)) exitWith
	{
		ctrlsettext [0006, _str];
		[[0003,true,true,""],[0004, false,false,""],[0005,false,false,""],[0008,true,false,""]] call JTS_FNC_SWITCH;
		[] spawn JTS_FNC_ADD;
	};

	if (count (units group (JTS_UNP select _Commander)) >= JTS_SquadSize) exitWith
	{
		ctrlsettext [0006, Format ["%1 достигнуто максимальное кол-во игроков в его отряде.\n\nИгроки: %2 of %3", name (JTS_UNP select _Commander), count (units group (JTS_UNP select _Commander)) - 1, JTS_SquadSize - 1]];
		[[0003,true,true,""],[0004, false,false,""],[0005,false,false,""],[0008,true,false,""]] call JTS_FNC_SWITCH;
	};

	if (side (JTS_UNP select _Commander) != side player) exitWith
	{
		ctrlsettext [0006, _str];
	};

	if (_Access > 0) then
	{
		if (JTS_UNP select _Commander != player) then
		{
			if (JTS_UNP select _Commander == leader group (JTS_UNP select _Commander)) then
			{
				if (!(player in units group (JTS_UNP select _Commander))) then
				{
					[player] joinSilent (JTS_UNP select _Commander);
					ctrlsettext [0006, Format ["You joined to %1", name (JTS_UNP select _Commander)]];

					ctrlEnable [0009, false];
					ctrlEnable [0010, false];
					ctrlEnable [0011, false];
					ctrlEnable [0012, false];
					ctrlEnable [0013, false];
					ctrlEnable [0014, false];

					sleep 0.15;
					[[(JTS_UNP select _Commander),Format ["%1 Присоединился к вашей команде", toUpper (name player)]],"JTS_FNC_BROADCAST",(JTS_UNP select _Commander),false] spawn BIS_fnc_MP;

					[] spawn JTS_FNC_ADD;
				}

				else
				{
					ctrlsettext [0006, "Вы уже в этом отряде"];
				}
			}

			else
			{
				ctrlsettext [0006, "Этот игрок не командир отряда"];
			};
		}

		else
		{
			ctrlsettext [0006, "Вы не можете присоединиться к себе"];
		};	[[0003,true,true,""],[0004, false,false,""],[0005,false,false,""],[0008,true,false,""]] call JTS_FNC_SWITCH
	}

	else
	{
		if (_Access <= 0 && (JTS_UNP select _Commander) getVariable "JTS_PASS" != "") then
		{
			"Enter" spawn JTS_FNC_PASSWORD
		}

		else
		{
			[lbValue [0001, lbCursel 0001],1] spawn JTS_FNC_JOIN
		}
	};
};

JTS_FNC_LEAVE =
{
	if (!alive player) exitWith {closedialog 0};

	_Leader = leader (group player);

	if (player == leader group player) then
	{
		ctrlsettext [0006, "Вы уже лидер отряда"];
	}

	else
	{
		[player] joinSilent grpnull;

		ctrlEnable [0009, false];
		ctrlEnable [0010, false];
		ctrlEnable [0011, false];
		ctrlEnable [0012, false];
		ctrlEnable [0013, false];
		ctrlEnable [0014, false];

		sleep 0.1;
		[[_Leader,Format ["%1 покинул свой отряд", toUpper (name player)]],"JTS_FNC_BROADCAST",_Leader,false] spawn BIS_fnc_MP;

		ctrlsettext [0006, "Вы вышли из отряда и стали лидером"];
		[] spawn JTS_FNC_ADD;
	};
};

JTS_FNC_KICK =
{
	if (!alive player) exitWith {closedialog 0};

	if (lbSize 0002 < 1) then
	{
		ctrlsettext [0006, "Вы не выбрали ни одного игрока"]
	}

	else
	{
		if (!(JTS_UNITS select _this call JTS_FNC_STATS)) exitWith {ctrlsettext [0006, "Вы не можете взаимодействовать с этим игроком из-за следующих причин:\n\n1. Игрок не в игре.\n2. Он мертв\n3. Вы мертвы"];[] spawn JTS_FNC_ADD};

		if (player != leader group player || (!(JTS_UNITS select _this in units (group player)))) then
		{
			ctrlsettext [0006, "Вы не лидер или игрок не в вашем отряде"];
		}

		else
		{
			if (JTS_UNITS select _this == leader group (JTS_UNITS select _this)) then
			{
				ctrlsettext [0006, Format ["%1 уже командир отряда", name (JTS_UNITS select _this)]];
			}

			else
			{
				[JTS_UNITS select _this] joinSilent grpnull;
				ctrlEnable [0009, false];
				ctrlEnable [0010, false];
				ctrlEnable [0011, false];
				ctrlEnable [0012, false];
				ctrlEnable [0013, false];
				ctrlEnable [0014, false];
				sleep 0.1;
				[[(JTS_UNITS select _this),Format ["%1 Выгнал вас из своего отряда", toUpper (name player)]],"JTS_FNC_BROADCAST",(JTS_UNITS select _this),false] spawn BIS_fnc_MP;
				
				ctrlsettext [0006, Format ["Вас выгнал '%1' из отряда", name (JTS_UNITS select _this)]];
				[] spawn JTS_FNC_ADD;
			};
		};
	};
};

JTS_FNC_INVITE =
{
	if (!alive player) exitWith {closedialog 0};

	if (lbSize 0001 < 1) then
	{
		ctrlsettext [0006, "You have not selected any player"];
	}

	else
	{
		if (!(JTS_UNP select _this call JTS_FNC_STATS)) exitWith {ctrlsettext [0006, "Вы не можете взаимодействовать с этим человеком из-за следующих причин:\n\n1. Этот человек не в игре.\n2. Он мертв\n3. Это бот\n4. Он враг\n5. Вы мертвы"]};
		
		if (JTS_UNP select _this == player) exitWith {ctrlsettext [0006, "Вы не можете приглашать сами себя"]};

		if (JTS_UNP select _this != leader group (JTS_UNP select _this)) then
		{
			ctrlsettext [0006, Format ["%1 не лидер отряда", name (JTS_UNP select _this)]];
		}

		else
		{
			if (JTS_UNP select _this getVariable "JTS_INVITES" < 1) then
			{
				[[(JTS_UNP select _this),Format ["%1 Пригласил тебя в свой отряд", toUpper (name player)]],"JTS_FNC_BROADCAST",(JTS_UNP select _this),false] spawn BIS_fnc_MP;

				ctrlsettext [0006, Format ["Приглашение отправлено %1", name (JTS_UNP select _this)]];
				[[0003,true,true,""],[0004, false,false,""],[0005,false,false,""],[0008,true,false,""]] call JTS_FNC_SWITCH
			}

			else
			{
				ctrlsettext [0006, Format ["%1 не получает приглашений", name (JTS_UNP select _this)]]
			};
		};
	};
};

JTS_FNC_VERIFY = 
{
	private ["_Verify","_cmd"];

	_Verify = toArray (_this);
	_cmd = 0;

	while {count _Verify > _cmd} do
	{
		if ((_Verify select _cmd < 48 || _Verify select _cmd > 57) && (_Verify select _cmd < 65 || _Verify select _cmd > 90) && (_Verify select _cmd < 97 || _Verify select _cmd > 122) && (_Verify select _cmd != 45)) then
		{
			_cmd = count _Verify;
		};

		_cmd = _cmd + 1;
	};	if (count _Verify == _cmd) then {true} else {false};
};

JTS_FNC_PASSWORD =
{
	switch (_this) do
	{
		case ("Create"):
		{
			[[0003,true,true,'Введите пароль:'],[0004, true,true,''],[0005,true,true,'ACCEPT'],[0008,true,true,'']] call JTS_FNC_SWITCH;
			buttonSetAction [0005, "if (!(ctrlText 0004 call JTS_FNC_VERIFY) || count (toArray ctrltext 0004) > 8 || count (toArray ctrltext 0004) < 1) then {if (count (toArray ctrltext 0004) < 1) then {ctrlsettext [0006, 'Вы успешно удалили пароль'];player setVariable ['JTS_PASS','',true];[[0003,true,true,''],[0004, false,false,''],[0005,false,false,'']] call JTS_FNC_SWITCH;[] spawn JTS_FNC_ADD} else {ctrlsettext [0006, Format ['Ваш апроль не должен содерать пробелов и символов !@#$%^&*()). Максимальная длинна пароля 8 символов.\n\nCharacters: %1 of 8',count (toArray ctrltext 0004)]]}} else {player setVariable ['JTS_PASS', ctrlText 0004, true];ctrlsettext [0006, format ['Вы успешно создали пароль для вашей команды: %1', ctrlText 0004]];[[0003,true,true,''],[0004, false,false,''],[0005,false,false,'']] call JTS_FNC_SWITCH;[] spawn JTS_FNC_ADD}"];
			ctrlsettext [0006, "Чтобы удалить пароль, оставьте поле ввода пустым"];
		};

		case ("Enter"):
		{
			[[0003,true,true,'Введите пароль:'],[0004, true,true,''],[0005,true,true,'ACCEPT'],[0008,true,true,'']] call JTS_FNC_SWITCH;
			ctrlsettext [0006, "Этот игрок создал пароль для своего отряда. Чтобы попасть в его отряд вам нужно ввести пароль."];
			buttonSetAction [0005,"if (JTS_UNP select (lbValue [0001, lbCursel 0001]) getVariable 'JTS_PASS' != '') then {if (ctrltext 0004 == JTS_UNP select (lbValue [0001, lbCursel 0001]) getVariable 'JTS_PASS') then {[(lbValue [0001, lbCursel 0001]), 1] spawn JTS_FNC_JOIN} else {ctrlsettext [0006, 'Password does not match']}} else {[(lbValue [0001, lbCursel 0001]), 1] spawn JTS_FNC_JOIN}"]
		};
	}
};

JTS_FNC_STATS =
{
	if (isNull _this || !alive player) then 
	{
		false
	}

	else
	{
		if (!alive _this || !alive player) then
		{
			false
		}

		else
		{
			true
		}
	}
};

JTS_FNC_STATUS =
{
	private "_Man";

	_Man = JTS_UNP select _this;

	if (lbSize 0001 < 1) exitWith {ctrlsettext [0006, "Вы не выбрали ни одного игрока"]};

	if (_Man getVariable "JTS_REQ" < 1) then
	{
		ctrlsettext [0006, "Этот игрок запретил отправлть запросы о его статусе"];
	}

	else
	{
		if (isNull _Man) then
		{
			ctrlsettext [0006, "Этот игрок не существует, обновите список"];
		}

		else
		{
			ctrlsettext [0006, Format ["Статус: %1\nЗдоровье: %2%3\nРазмер: %4\nПозиция: %5\nРанг: %6\nЛидер: %7", if (alive (_Man)) then {"Жив"} else {"Мертв"}, ceil ((1 - getDammage _Man) * 100), "%", count (units _Man) -1, mapGridPosition _Man, rank _Man, toUpper (name (_Man))]];
		}
	}
};

JTS_FNC_LEADERSHIP =
{
	private ["_Man","_str"];

	_Man = JTS_UNITS select _this;
	_str = "Вы не можете взаимодействовать с этим игроком т.к.:\n\n1. Он не в игре.\n2. Он мертв\n3. Это бот\n4. Он противник\n5. Вы мертвы";

	if (!(_Man call JTS_FNC_STATS)) exitWith {ctrlsettext [0006, _str]};

	if (player != leader (group player) || (!(_Man in units (group player)))) then
	{
		ctrlsettext [0006, "Вы не являетесь командиром отряда или выбранный игрок в другом отряде"];
	}

	else
	{
		if (!isPlayer _Man) then
		{
			ctrlsettext [0006, format ["%1 is not a player", name _Man]];
		}

		else
		{
			[[_Man,Format ["%1 Дал вам руководство", toUpper (name player)]],"JTS_FNC_BROADCAST",_Man,false] spawn BIS_fnc_MP;
			(group player) selectLeader _Man;
			[] spawn JTS_FNC_ADD;
		};
	};
};

JTS_FNC_REQUESTS =
{
	switch (player getVariable "JTS_REQ") do
	{
		case 0: {player setVariable ["JTS_REQ",1,true]};
		case 1: {player setVariable ["JTS_REQ",0,true]};
	};
		private ["_Leader","_Pass","_Stat"];

		if (leader (group player) == player) then {_Leader = "Вы"} else {_Leader = Format ["%1", name (leader (group player))]};
		if (player getVariable "JTS_PASS" == "") then {_Pass = "Нет"} else {_Pass = player getVariable "JTS_PASS"};
		if (player getVariable "JTS_REQ" == 0) then {_Stat = "Не позволять"} else {_Stat = "Позволять"};

		_str = Format ["*** Наведите курсор мыши на кнопку, для информации ***\n\nНе забывайте иногда обновлять список игроков (отряд)\n\nТекущий командир отделения: %1\nВаш текущий пароль: %2\nЗапрашивать ваш статус: %3", _Leader, _Pass, _Stat];
		[[0003,true,true,""],[0004, false,false,""],[0005,false,false,""],[0006,true,true, _str],[0008,true,false,""]] call JTS_FNC_SWITCH;
};

[] spawn
{
	while {true} do
	{
		waitUntil {alive player};
		_act = player addaction ["<t color='#00FF00'>Меню группы</t>","JTS_SQUAD\JTS_GroupMenu.sqf",[],-1];
		waitUntil {!alive player};
		vehicle player removeaction _act;
		player removeaction _act;
		sleep 0.5;
	};
};

[] spawn
{
	sleep 2;
	while {true} do
	{
		if (player == leader (group player) && count (units (group player)) > JTS_SquadSize) then
		{
			for [{_i = 0}, {count (units (group player)) > JTS_SquadSize}, {_i = _i + 1}] do
			{
				if (units (group player) select _i != player) then
				{
					player groupchat format ["%1 был удален из вашей команды", toUpper (name (units (group player) select _i))];
					[units (group player) select _i] joinSilent grpnull
				};
			};

			if (alive player && dialog) then
			{
				[] spawn JTS_FNC_ADD
			};
		};		sleep 1.2
	};
};

// MADE BY JTS