/*
	Author: stanhope
	Description: saves relevant information and then shuts the server down

	last edited: 7/01/17 by stanhope
	edited: /
*/
	//Before anything else check if we're allowed to auto restart the server
	
	private _saveProgressCode = {
		[Quartermaster, [adminChannelID, "Save progress script triggered"]] remoteExecCall ["customChat", 0, false];
		
		[Quartermaster, [adminChannelID, "Printing TK array in server RPT"]] remoteExecCall ["customChat", 0, false];
		private _arrayLenght = count TKArray;
		diag_log "Printing TK array because of save:";
		for '_i' from 0 to _arrayLenght do {
			diag_log (TKArray select _i);
		};
		diag_log 'End TK array';
		
		[Quartermaster, [adminChannelID, "Saving FOBs and main AOs"]] remoteExecCall ["customChat", 0, false];
		profileNamespace setVariable ["capturedFOBs", capturedFOBs];
		sleep 0.1;
		profileNamespace setVariable ["controlledZones", controlledZones];
		sleep 0.1;
		saveProfileNamespace;
		sleep 1;
		[Quartermaster, [adminChannelID, "main AOS and FOBs saved"]] remoteExecCall ["customChat", 0, false];
	};
	
	private _restartCode = {
		[Quartermaster, [adminChannelID, "Restart script triggered"]] remoteExecCall ["customChat", 0, false];
		sleep 0.1;
		
		[Quartermaster, [adminChannelID, "Printing TK array in server RPT"]] remoteExecCall ["customChat", 0, false];
		private _arrayLenght = count TKArray;
		diag_log "Printing TK array because of restart:";
		for '_i' from 0 to _arrayLenght do {
			diag_log (TKArray select _i);
		};
		diag_log 'End TK array';
		sleep 0.1;
		
		[Quartermaster, [adminChannelID, "Saving FOBs and main AOs"]] remoteExecCall ["customChat", 0, false];
		profileNamespace setVariable ["capturedFOBs", capturedFOBs];
		sleep 0.1;
		profileNamespace setVariable ["controlledZones", controlledZones];
		sleep 0.1;
		saveProfileNamespace;
		sleep 1;
		[Quartermaster, [adminChannelID, "main AOS and FOBs saved"]] remoteExecCall ["customChat", 0, false];
		sleep 0.1;
		[Quartermaster, [adminChannelID, "Restart in 5 seconds"]] remoteExecCall ["customChat", 0, false];
		diag_log 'server restart in 5 seconds';
		sleep 5;
		[] call serverRestart;
	};
	
	
	autoRestartEnabled = profileNamespace getVariable ["autoRestartEnabled", true];
	if (!autoRestartEnabled) exitWith {
		[Quartermaster, [adminChannelID, "Automated server restart has been disabled by an admin"]] remoteExecCall ["customChat", 0, false];
		sleep 0.1;
	    [Quartermaster, [adminChannelID, "Server restart not executed, saving progress instead"]] remoteExecCall ["customChat", 0, false];
		sleep 0.1;
		[] spawn _saveProgressCode;
	};
	
	params ["_typeOfRestart"];
	switch (_typeOfRestart) do {
		case "timedRestart": { 
			/*
			triggered by the cleanupscript
			wait a preset amount of time here before restarting and give hints etc every x amount of seconds
			when the actual time is reached restart the server
			
			should be triggered 1 hour before restart should happen
			*/
			[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Server message: </t><t size='1.0'><br />The server will restart in 1 hour<br />All progress will be saved</t>"], true, nil, 20, 0.5, 0.3] remoteExec ["BIS_fnc_textTiles", 0];
			sleep 1800; /*sleep half an hour*/
			
			[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Server message: </t><t size='1.0'><br />The server will restart in 30 minutes<br />All progress will be saved</t>"], true, nil, 20, 0.5, 0.3] remoteExec ["BIS_fnc_textTiles", 0];
			sleep 1200; /*sleep 10 minutes*/

			[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Server message: </t><t size='1.0'><br />The server will restart in 10 minutes<br />All progress will be saved</t>"], true, nil, 20, 0.5, 0.3] remoteExec ["BIS_fnc_textTiles", 0];
			[["RespawnAdded",["server message","Server restart in 10 minutes"]], BIS_fnc_showNotification] remoteExec ["call", 0];
			sleep 480; /*sleep 8 minutes*/
			
			[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Server message: </t><t size='1.0'><br />The server will restart in 2 minutes<br />All progress will be saved</t>"], true, nil, 20, 0.5, 0.3] remoteExec ["BIS_fnc_textTiles", 0];
			[["RespawnAdded",["server message","Server restart in 2 minutes"]], BIS_fnc_showNotification] remoteExec ["call", 0];
			sleep 120; /*sleep 2 minutes*/
			
			[["RespawnAdded",["server message","Server is about to restart"]], BIS_fnc_showNotification] remoteExec ["call", 0];
			[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Server message: </t><t size='1.0'><br />Server restarting<br />All progress will be saved</t>"], true, nil, 20, 0.5, 0.3] remoteExec ["BIS_fnc_textTiles", 0];
			[] spawn _restartCode;
		};
		case "afterAO": { 
			/*
			triggered by an admin
			as it's triggered by an admin the restart should happen rather quickly after this case is triggered
			*/
			[parseText format ["<br /><t align='center' font='PuristaBold' size='1.4'><t color='#0090ff'>Server message: </t><br />The server is about to restart.  </t>"], true, nil, 20, 0.5, 0.3] remoteExec ["BIS_fnc_textTiles", 0];
			[["RespawnAdded",["server message","Server is about to restart"]], BIS_fnc_showNotification] remoteExec ["call", 0];
			[] spawn _restartCode;
		};
		case "saveProgress": {
			[] spawn _saveProgressCode;
		};
		default {
		    diag_log "ERROR: RestartScript.sqf: type of restart not recognized";
		    [Quartermaster, [adminChannelID, "Error: type of restart not recognized, progress saved instead"]] remoteExecCall ["customChat", 0, false];
			[] spawn _saveProgressCode;
        };
	};
	
	
	
	