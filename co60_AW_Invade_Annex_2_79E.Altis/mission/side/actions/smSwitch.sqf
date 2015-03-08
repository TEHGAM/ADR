/*
@filename: smSwitch.sqf
Author:

	Quiksilver
	
Description:

	Actioning the character triggers mission cycle.
	
_______________________________________________________*/
	
if (SM_SWITCH) exitWith {
	hint "No side objective available, please wait."
};

//-------------------- Send hint to player that he's planted the bomb

hint "Дополнительное задание выявлено, ждите подробных инструкций.";

sleep 1;

SM_SWITCH = true; publicVariable "SM_SWITCH";