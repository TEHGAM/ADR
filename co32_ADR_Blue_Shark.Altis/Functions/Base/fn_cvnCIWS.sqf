/*
Author: ansin11

description: Code that handles the AA protection for the carrier.

Last modified: 19/10/2017 by stan

modified: put some more things in the forEach loop
*/

if (!(CVN_CIWS_Cooldown) && !(CVN_CIWS_Active)) then {
	
	sleep 2;
    //activate AA
    {
        _x setVehicleAmmo 1;
        _x setAutonomous true;
        _x setVehicleLock "LOCKEDPLAYER";
        createVehicleCrew _x;

    } forEach [CVN_CIWS_1,CVN_CIWS_2,CVN_CIWS_3,CVN_RAM,CVN_SAM_2,CVN_SAM_3];
    CVN_CIWS_Active = true;
	[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Crossroads: </t><br />Carrier air-defense activated.</t>"], true, nil, 3, 1, 0.3] remoteExec ["BIS_fnc_textTiles", -2];

    //deactivate and enter cooldown after 300 sec
    sleep 300;

    CVN_CIWS_Active = false;
    CVN_CIWS_Cooldown = true;

    {
        _x setVehicleAmmo 0;
        _x setVehicleLock "LOCKED";
        deleteVehicle gunner _x;

    } forEach [CVN_CIWS_1,CVN_CIWS_2,CVN_CIWS_3,CVN_RAM,CVN_SAM_2,CVN_SAM_3];

    //cooldown complete after 900 sec
	[parseText format ["<br /><t align='center' font='PuristaBold'><t size='1.4' color='#0090ff'>Crossroads: </t><t size='1.2'><br />Carrier air-defense going into cooldown.</t></t>"], true, nil, 3, 1, 0.3] remoteExec ["BIS_fnc_textTiles", -2];
    sleep 900;
    CVN_CIWS_Cooldown = false;
	[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Crossroads: </t><br />Carrier air-defense available.</t>"], true, nil, 3, 1, 0.3] remoteExec ["BIS_fnc_textTiles", -2];

};

if (CVN_CIWS_Active) then {/*player get's a local hint that AA is up*/};

if (CVN_CIWS_Cooldown) then {/*player get's a local hint that AA is cooling down*/};

