if (CLEARITEMSBASE_SWITCH) exitWith {
	hint "Base items cleanup unavailable."
};

//-------------------- Wait for player to action

sleep 1;

//-------------------- Send hint to player that he's planted the bomb

hint "Base garbage clearance initiated.";

sleep 3;

//---------- Send notice to all players that charge has been set.

CLEARITEMSBASE_SWITCH = true; publicVariable "CLEARITEMSBASE_SWITCH";