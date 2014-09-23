// admin_uid.sqf
waitUntil {(getPlayerUID player) != ""};

_uid = getPlayerUID player;

switch(_uid)do
{
 	case "76561198053877632": 
 	{
		player addAction ["<t color='#FF2626'>Наблюдать</t>", "scripts\spectator\specta.sqf", "", 0, false, true, "", ""];
		player addAction ["<t color='#FF2626'>Приборы</t>", "scripts\admin\tools.sqf", "", 1, false, true, "", ""];
 	};
	case "76561198017758762": 
 	{
		player addAction ["<t color='#FF2626'>Наблюдать</t>", "scripts\spectator\specta.sqf", "", 0, false, true, "", ""];
		player addAction ["<t color='#FF2626'>Приборы</t>", "scripts\admin\tools.sqf", "", 1, false, true, "", ""];
 	};
	case "76561198074604871": 
 	{
		player addAction ["<t color='#FF2626'>Наблюдать</t>", "scripts\spectator\specta.sqf", "", 0, false, true, "", ""];
		player addAction ["<t color='#FF2626'>Приборы</t>", "scripts\admin\tools.sqf", "", 1, false, true, "", ""];
 	};
	
 	default
	{
 	};
};
