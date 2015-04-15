/*

0004 - RscEdit
0003 - Infotext
0005 - Activetext

*/

private ["_Leader","_Pass","_Stat"];

if (!alive player) exitWith {closedialog 0};
if (JTS_DLGS > 0) exitWith {closedialog 0;hint "Please, wait..."};

createDialog "JTS_Squad";

		if (leader (group player) == player) then {_Leader = "Вы"} else {_Leader = Format ["%1", name (leader (group player))]};
		if (player getVariable "JTS_PASS" == "") then {_Pass = "Нет"} else {_Pass = player getVariable "JTS_PASS"};
		if (player getVariable "JTS_REQ" == 0) then {_Stat = "Не позволять"} else {_Stat = "Позволять"};

_str = Format ["*** Наведите курсор мыши на кнопку, для информации ***\n\nНе забывайте иногда обновлять список игроков (отряд)\n\nТекущий командир отделения: %1\nВаш текущий пароль: %2\nЗапросы о вашем статусе: %3", _Leader, _Pass, _Stat];
[[0003,true,true,""],[0004, false,false,""],[0005,false,false,""],[0006,true,true, _str],[0008,true,false,""]] call JTS_FNC_SWITCH;

{[] spawn _x} foreach [JTS_FNC_ADD,JTS_FNC_PERMISSIONS];