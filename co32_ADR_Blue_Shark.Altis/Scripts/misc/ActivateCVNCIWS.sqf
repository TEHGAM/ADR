/*
author: stanhope

description: executes the function that controlls the AA

*/

remoteExec ["AW_fnc_cvnCIWS", 2];

if ((not CVN_CIWS_Cooldown) && (not CVN_CIWS_Active)) then {
[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'>Activating carrier AA ...</t>"], true, nil, 2, 0.5, 0.3] spawn BIS_fnc_textTiles;	
};

if (CVN_CIWS_Active) then {
[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'>Carrier AA is already active</t>"], true, nil, 4, 1, 0.3] spawn BIS_fnc_textTiles;
};

if (CVN_CIWS_Cooldown) then {
[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'>Carrier AA is cooling down</t>"], true, nil, 4, 1, 0.3] spawn BIS_fnc_textTiles;
};
