private ["_canDeleteGroup","_group","_groups","_units"];
while { true } do {
	sleep 480 + (random 240);

	{
		deleteVehicle _x;
	} forEach allDead;
	
	sleep 1;
	{deleteVehicle _x;} count (allMissionObjects "Ruins");
	sleep 1;
	{deleteVehicle _x;} count (allMissionObjects "CraterLong");
	sleep 1;

	_groups = allGroups;

	for "_c" from 0 to ((count _groups) - 1) do {
		_canDeleteGroup = true;
		_group = (_groups select _c);
		if (!isNull _group) then {
			_units = (units _group);
			{
				if (alive _x) then { _canDeleteGroup = false; };
			} forEach _units;
		};
		if (_canDeleteGroup && !isNull _group) then { 
			deleteGroup _group; 
		};
	};
};


