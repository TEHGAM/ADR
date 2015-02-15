
if (!isDedicated) then {	
	player addAction [
		("<t color='#04cc6b'>" + localize "STRD_squadm" + "</t>"), 
		Compile preprocessFileLineNumbers "scripts\DOM_squad\open_dialog.sqf", [], -80, false
	];	
};
