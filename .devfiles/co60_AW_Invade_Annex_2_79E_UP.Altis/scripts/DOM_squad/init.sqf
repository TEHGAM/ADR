// Init functions
call Compile preprocessFileLineNumbers "scripts\DOM_squad\x_netinit.sqf";
if (!isDedicated) then {
	call Compile preprocessFileLineNumbers "scripts\DOM_squad\x_uifuncs.sqf";
	
	/*
	squad_mgmt_action = player addAction [
		("<t color='#04cc6b'>" + localize "STRD_squadm" + "</t>"), 
		Compile preprocessFileLineNumbers "scripts\DOM_squad\open_dialog.sqf", [], -80, false
	];


	player addEventHandler ["respawn",  {_this execVM "scripts\DOM_squad\initAction.sqf"}]; 	

	*/
};
