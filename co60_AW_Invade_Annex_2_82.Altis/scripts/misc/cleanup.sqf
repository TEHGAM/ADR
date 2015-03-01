private ["_canDeleteGroup","_group","_groups","_units"];

while {true} do {
	sleep 480 + (random 240);
	{deleteVehicle _x;} count allDead;
	sleep 1;
	{deleteVehicle _x;} count (allMissionObjects "CraterLong");
	sleep 1;
	{deleteVehicle _x;} count (allMissionObjects "WeaponHolder");
	sleep 1;
	{deleteVehicle _x;} count (allMissionObjects "WeaponHolderSimulated");
	sleep 1;
	{if (!isPlayer _x) then {_x enableFatigue FALSE;};} count allUnits;
	{if ((count units _x) == 0) then {deleteGroup _x;};} count allGroups;
	if (!(AW_ammoDropAvail)) then {
		if (!(ammocheck_switch)) then {
			ammocheck_switch = true;
			[] spawn {
				sleep 480;
				if (!isNull ammoDropCrate) then {
					deleteVehicle ammoDropCrate;
				};
				pvBroadcast = [WEST,"AirBase"] sideChat "UH-80 Supply Drop is available."; publicVariable "pvBroadcast";
				AW_ammoDropAvail = true; publicVariable "AW_ammoDropAvail";
				ammocheck_switch = false;
			};
		};
	};
	if (!isNull heliFuelTruck) then {
		heliFuelTruck setFuelCargo 1;
	};
};


