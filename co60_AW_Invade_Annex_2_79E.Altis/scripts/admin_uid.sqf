// admin_uid.sqf
waitUntil {(getPlayerUID player) != ""};

_uid = getPlayerUID player;

switch(_uid)do 
{  
	case "0": // Script not in use
};