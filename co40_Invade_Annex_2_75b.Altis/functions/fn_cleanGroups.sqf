if(!isServer) exitWith{};
	{
		if(count (units _x) == 0) then {deleteGroup _x};
	} forEach allGroups;
