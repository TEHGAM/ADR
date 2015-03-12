/*
	File: fn_updateViewDistance.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Updates the view distance dependant on whether the player is on foot, a car or an aircraft.
*/
switch (true) do
{
	case ((vehicle player) isKindOf "Man"): {
		setViewDistance tawvd_foot;
		enableEnvironment TRUE;
	};
	case ((vehicle player) isKindOf "LandVehicle"): {
		setViewDistance tawvd_car;
		enableEnvironment TRUE;
	};
	case ((vehicle player) isKindOf "Ship"): {
		setViewDistance tawvd_car;
		enableEnvironment TRUE;
	};
	case ((vehicle player) isKindOf "Air"): {
		setViewDistance tawvd_air;
		enableEnvironment FALSE;
	};
};