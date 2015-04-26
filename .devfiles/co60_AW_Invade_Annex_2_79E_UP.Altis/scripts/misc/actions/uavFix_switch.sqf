if (UAVFIX_SWITCH) exitWith {
	hint "Взлом БПЛА недоступен, попробуйте позже."
};

sleep 1;

hint "Идет взлом БПЛА. Пожалуйста подождите...";

sleep 3;

UAVFIX_SWITCH = true; publicVariable "UAVFIX_SWITCH";