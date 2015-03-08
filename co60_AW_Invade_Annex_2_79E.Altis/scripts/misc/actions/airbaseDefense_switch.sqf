if (AIRBASEDEFENSE_SWITCH) exitWith {
	hint "ѕротивовоздушна€ оборона недоступна."
};

//-------------------- Wait for player to action

sleep 1;

//-------------------- Send hint to player that he's planted the bomb

hint "јктивирование противовоздушную оборону...";

sleep 3;

//---------- Send notice to all players that charge has been set.

AIRBASEDEFENSE_SWITCH = true; publicVariable "AIRBASEDEFENSE_SWITCH";