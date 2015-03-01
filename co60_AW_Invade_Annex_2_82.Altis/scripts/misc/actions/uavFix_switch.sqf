if (UAVFIX_SWITCH) exitWith {
	hint "UAV crew recycle unavailable, please wait ..."
};

sleep 1;

hint "Recycling UAV crews, please wait ...";

sleep 3;

UAVFIX_SWITCH = true; publicVariable "UAVFIX_SWITCH";