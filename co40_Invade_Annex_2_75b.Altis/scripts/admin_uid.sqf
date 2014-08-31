// admin_uid.sqf
waitUntil {(getPlayerUID player) != ""};

_uid = getPlayerUID player;

switch(_uid)do
{
 	case "76561198020796103": // Cleric
 	{
	player addAction ["<t color='#900000'></t>", "scripts\spectator\specta.sqf"];
 	};

 	case "76561198017758762": // [K]STELS
 	{
	player addAction ["<t color='#900000'></t>", "scripts\spectator\specta.sqf"];
 	};

        case "76561198001377614": // Mexan
 	{
	player addAction ["<t color='#900000'></t>", "scripts\spectator\specta.sqf"];
 	};

        
default
  {
 	};
};



player addAction [
		("<t color='#04cc6b'>" + localize "STRD_squadm" + "</t>"), 
		Compile preprocessFileLineNumbers "scripts\DOM_squad\open_dialog.sqf", [], -80, false
	];