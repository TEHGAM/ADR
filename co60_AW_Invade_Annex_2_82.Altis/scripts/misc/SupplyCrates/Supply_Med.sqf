private ["_heli", "_reloadtime"];

if (!(BACO_ammoSuppAvail)) exitWith {
	hint "Supply Crate is not currently available"
};

BACO_ammoSuppAvail = FALSE; publicVariable "BACO_ammoSuppAvail";

//------------------------------------------------------- CONFIG

_heli = _this select 0;
_crateType =  "B_Slingload_01_Medevac_F";	//ammocrate class for blufor, feel free to change to whichever box you desire
_reloadtime = 960;  						// time before next ammo drop is available to use, default 600 or 480



//--------------------------------------------------------- MEAT AND POTATOES

Supply_Ammo = _crateType createVehicle (getMarkerPos "Ammo_Supply_drop");; publicVariable "Supply_Ammo"; 

sleep _reloadtime; BACO_ammoSuppAvail = TRUE; publicVariable "BACO_ammoSuppAvail";

