/*
author: stanhope

description: executes the function that controlls the AA
*/

remoteExec ["AW_fnc_mainBaseAA", 2];

if ((not Base_AA_Cooldown) && (not Base_AA_Active)) then {
	[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'>Activating base AA ...</t>"], true, nil, 2, 0.5, 0.3] spawn BIS_fnc_textTiles;	
};

if (Base_AA_Active) then {
	[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'>Base AA is already active</t>"], true, nil, 4, 1, 0.3] spawn BIS_fnc_textTiles;
};

if (Base_AA_Cooldown) then {
	[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'>Base AA is cooling down</t>"], true, nil, 4, 1, 0.3] spawn BIS_fnc_textTiles;
};
