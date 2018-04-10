god = 1;
tele = 1;
hide = 1;

VONWarning = 	parseText "<t align='center' font='PuristaBold' ><t size='1.4' color='#ff0000'>WARNING to ALL</t><t size='0.9'><br />No VON in SIDE, COMMAND, GLOBAL.<br />Constant VON in these channels will result in kick. <br />Use Direct, Vehicle or Group channel for VON chat or type it.</t></t>";
TSAdress = 		parseText "<t align='center' font='PuristaBold' ><t size='1.4'>AHOY TEAMSPEAK</t><t size='0.9'><br />ts.ahoyworld.net</t></t>";
FFWarning = 	parseText "<t align='center' font='PuristaBold' ><t size='1.4' color='#ff0000'>WARNING to ALL</t><t size='0.9'><br /> Check your targets,<br />Continued FF will result in Kick or Ban.<br />Not sure? Dont fire! </t></t>";
WhatsUp = 		parseText "<t align='center' font='PuristaBold' ><t size='1.4'>ADMIN</t><t size='0.9'><br />What's the issue?</t></t>";
ZeusSpam = 		parseText "<t align='center' font='PuristaBold' ><t size='1.4' color='#ff0000'>WARNING to ALL</t><t size='0.9'><br />Do not spam the zeus key (Y)<br /> This will result in either a lightning bolt landing on your head, a kick or a ban.</t></t>";
ZeusActive = 	parseText "<t align='center' font='PuristaBold' ><t size='1.2'>Message from zeus</t><t size='0.8'><br />Zeus is now active, AI is no longer dumb.<br />They now see tracers, IR lasers, hear gunshots, ...</t></t>";

AAT = player addAction ["<t color='#FF9D00'>Admin tools V10.1</t>",{ 

MMOPEN = 
[    
	["Admin tools",true],  
	["Global hints",   	[2], "#USER:MMHints", 	-5, [["expression", ""]], "1", ""], 
	["Invade and annex",[3], "#USER:MMIA",  	-5, [["expression", ""]], "1", ""],
	["Object",  	 	[4], "#USER:MMObject",	-5, [["expression", ""]], "1", ""],  
	["Admin",   		[5], "#USER:MMAdmin",   -5, [["expression", ""]], "1", ""],   
	["Abilites", 	 	[6], "#USER:MMPlayer",  -5, [["expression", ""]], "1", ""], 
	["World",  			[7], "#USER:MMWorld",   -5, [["expression", ""]], "1", ""], 
	["Group",   	 	[8], "#USER:MMGroup",  	-5, [["expression", ""]], "1", ""], 
	["MYOWN",   	 	[9], "#USER:MYOWN",  	-5, [["expression", ""]], "1", ""],
	["Tools off", 	 	[10], "",				-5, [["expression", "player removeAction AAT; player removeAction ADDIDTool; player removeAction REMIDTool; player removeEventHandler ['Respawn', RESIDTool]; "]], "1", ""]
]; 

MMHints = [  
	["Hints",true], 
	["VON Warning",   [2], "",  -5, [["expression", "[VONWarning] remoteExec ['hint', 0, false];"]],"", ""],
	["TS Address",    [3], "",  -5, [["expression", "[TSAdress] remoteExec ['hint', 0, false];"]],"", ""],
	["FF Warning",    [4], "",  -5, [["expression", "[FFWarning] remoteExec ['hint', 0, false];"]],"", ""],
	["Admin Issue?",  [5], "",  -5, [["expression", "[WhatsUp] remoteExec ['hint', 0, false];"]],"", ""],
	["Zeus Spam",     [6], "",  -5, [["expression", "[ZeusSpam] remoteExec ['hint', 0, false];"]],"", ""],
	["Zeus active",   [7], "",  -5, [["expression", "[ZeusActive] remoteExec ['hint', 0, false];"]],"", ""],
	["Server UpTime", [8], "",  -5, [["expression", "uptime = round(serverTime/60/60); GHINT   = { hint format ['Server up for %1 hours',uptime];};publicVariable 'GHINT';remoteExecCall ['GHINT'];"]],"", ""],
	["Clear Hints",   [9], "",  -5, [["expression", "[''] remoteExec ['hint', 0, false];"]],"", ""],
	["Back",          [10],"",  -4, [["expression", ""]], "1", ""]
];

MMIA = [  
	["Invade and annex",true],  
	["Main AO related",   		[2], "#USER:MMIAMainAO",  -5, [["expression", ""]], "1", ""],
	["Side mission related",   	[3], "#USER:MMIASide",  -5, [["expression", ""]], "1", ""],
	["prio mission related",   	[4], "#USER:MMIAPrio",  -5, [["expression", ""]], "1", ""],
	["Spawn FOBs",   			[5], "#USER:MMFOBLIST",  -5, [["expression", ""]], "1", ""],
	["Other",   				[6], "#USER:MMIAOther",  -5, [["expression", ""]], "1", ""],
	["spawn reward",			[7], "#USER:MMRewards", -5, [["expression", ""]], "1", ""], 
	["Back",    				[8], "", -4,[["expression", "" ]], "1", ""]
];

MMIAMainAO = [
	["Main AO reltated",true],   
	["List of completed AOs",   		[2], "", -5, [["expression", "publicVariable 'controlledZones';hint str controlledZones;" ]],"", ""],
	["Count amount of completed AOs",	[3], "", -5, [["expression", "publicVariable 'controlledZones';hint str count controlledZones;" ]],"", ""],
	["Kill subobjective",   			[4], "", -5, [["expression", "subObjComplete = 1; publicVariable 'subObjComplete'; Tersub = {terminate subObjScript;}; publicVariable 'Tersub';  remoteExecCall ['Tersub',0];  cutText['Terminating subobj', 'PLAIN'];" ]],"", ""],
	["Stop main AOs",					[5], "", -5, [["expression", "_shutDownIandA = { if !(isNull mainObjScript) then {terminate mainObjScript; diag_log 'admin terminated mainObjScript';};
		};[[], _shutDownIandA] remoteExec ['spawn', 2, false];cutText['Main AOs stopped', 'PLAIN'];"]], "1", ""],
	["Start main AOs",					[6], "", -5, [["expression", "_restartIandA = { if (isNull mainObjScript) then {mainObjScript = [] execVM 'Missions\Main\Main_Machine.sqf'; diag_log 'admin started mainObjScript';};
		};	[[], _restartIandA] remoteExec ['spawn', 2, false];cutText['Main AOs started', 'PLAIN'];"]], "1", ""],
	["Back",    						[7], "", -4, [["expression", "" ]], "1", ""]
];

MMIASide = [
	["Side obj related",true],   
	["End current side",	[2], "", -5, [["expression","sideMissionUp = false;  publicVariable 'sideMissionUp'; cutText['ENDING SIDE', 'PLAIN'];"]],"", ""],
	["Stop side missions",	[3], "", -5, [["expression", "_shutDownIandA = {
		if !(isNull sideObjScript) then {terminate sideObjScript; diag_log 'admin terminated sideObjScript';};
	};[[], _shutDownIandA] remoteExec ['spawn', 2, false];cutText['Side missions stopped', 'PLAIN'];"]], "1", ""],
	["Start side missions",	[4], "", -5, [["expression", "_restartIandA = {
		if (isNull sideObjScript) then {sideObjScript = [] execVM 'Missions\Side\MissionControl.sqf';diag_log 'admin started sideObjScript';};
	};	[[], _restartIandA] remoteExec ['spawn', 2, false];cutText['Side missions started', 'PLAIN'];"]], "1", ""],
	["Back",    			[5], "", -4, [["expression","" ]], "1", ""]
];

MMIAPrio = [
	["Prio obj related",true],   
	["Stop prio missions",	[2], "", -5, [["expression", "_shutDownIandA = {
		if !(isNull prioObjScript) then {terminate prioObjScript; diag_log 'admin terminated prioObjScript';};
	};[[], _shutDownIandA] remoteExec ['spawn', 2, false];cutText['prio missions stopped', 'PLAIN'];"]], "1", ""],
	["Start Prio missions",	[3], "", -5, [["expression", "_restartIandA = {
		if (isNull prioObjScript) then {prioObjScript = [] execVM 'Missions\Priority\MissionControl.sqf';diag_log 'admin started prioObjScript';};
	};	[[], _restartIandA] remoteExec ['spawn', 2, false];cutText['Prio missions started', 'PLAIN'];"]], "1", ""],
	["Back",    						[4], "", -4, [["expression", "" ]], "1", ""]
];

MMIAOther = [
	["Other IandA related",true],   
	["Add me to admin channel",[2], "", -5, [["expression", "adminChannelID radioChannelAdd [player];"]], "1", ""],
	["Admin channel is bugged for everyone",[3], "", -5, [["expression", "AdminChannelUnbug = {adminChannelID = radioChannelCreate [[0.8, 0, 0, 1], 'Admin Channel', '%UNIT_NAME', [], true];publicVariable 'adminChannelID';}; publicVariable 'AdminChannelUnbug'; remoteExecCall ['AdminChannelUnbug',2]; AdminChannelAddDude = {adminChannelID radioChannelAdd [Quartermaster];}; publicVariable 'AdminChannelAddDude'; remoteExecCall ['AdminChannelAddDude',0]; adminChannelID radioChannelAdd [player];"]], "1", ""],
	
	["Stop Invade and Annex",[4], "", -5, [["expression", "_shutDownIandA = {
		if !(isNull mainObjScript) then {terminate mainObjScript; diag_log 'admin terminated mainObjScript';};
		if !(isNull prioObjScript) then {terminate prioObjScript; diag_log 'admin terminated prioObjScript';};
		if !(isNull sideObjScript) then {terminate sideObjScript; diag_log 'admin terminated sideObjScript';};
	};[[], _shutDownIandA] remoteExec ['spawn', 2, false];cutText['I and A stopped', 'PLAIN'];"]], "1", ""],
	["Restart Invade and Annex",[5], "", -5, [["expression", "_restartIandA = {
		if (isNull mainObjScript) then {mainObjScript = [] execVM 'Missions\Main\Main_Machine.sqf'; diag_log 'admin started mainObjScript';};
		if (isNull prioObjScript) then {prioObjScript = [] execVM 'Missions\Priority\MissionControl.sqf';diag_log 'admin started prioObjScript';};
		if (isNull sideObjScript) then {sideObjScript = [] execVM 'Missions\Side\MissionControl.sqf';diag_log 'admin started sideObjScript';};
	};	[[], _restartIandA] remoteExec ['spawn', 2, false];cutText['I and A restarted', 'PLAIN'];"]], "1", ""],
	
	["Restart server after this AO",[6], "", -5, [["expression", "restartServerAfterThisAO = true; publicVariableServer 'restartServerAfterThisAO';cutText['Restarting server after this AO', 'PLAIN'];"]], "1", ""],
	["Save I and A progression",[7], "", -5, [["expression", "[['saveProgress'], 'Scripts\RestartScript.sqf'] remoteExec ['execVM', 2, false];"]], "1", ""],
	
	
	
	["Back", [8], "", -4, [["expression", "" ]], "1", ""]
];

MMFOBLIST = [
	["FOB list",true],   
	["Altis FOBs",  [2], "#USER:MMFOBAltis",  -5, [["expression", ""]], "1", ""],
	["Malden FOBs", [3], "#USER:MMFOBMalden",  -5,[["expression", ""]], "1", ""],
	/*["Tanoa FOBs",  [4], "#USER:MMFOBTanoa",  -5, [["expression", ""]], "1", ""],*/
	["Back",    	[4], "", -4,[["expression", "" ]], "1", ""]
];

MMFOBAltis = [
	["Altis FOBs",true],  
	["AAC_Airfield",   	[2], "", -5, [["expression", "newBase = 'AAC_Airfield';	 if !(newBase in controlledZones) then {publicVariable 'newBase'; FobName = {controlledZones pushBack newBase;}; publicVariable 'FobName'; remoteExecCall ['FobName',0]; FI2 = {[newBase] call AW_fnc_BaseManager;}; publicVariable 'FI2'; remoteExecCall ['FI2',2]; cutText['FOB spawned', 'PLAIN'];} else {cutText['FOB has already been spawned', 'PLAIN'];};" ]],"", ""],
	["Stadium",   		[3], "", -5, [["expression", "newBase = 'Stadium';		 if !(newBase in controlledZones) then {publicVariable 'newBase'; FobName = {controlledZones pushBack newBase;}; publicVariable 'FobName'; remoteExecCall ['FobName',0]; FI2 = {[newBase] call AW_fnc_BaseManager;}; publicVariable 'FI2'; remoteExecCall ['FI2',2]; cutText['FOB spawned', 'PLAIN'];} else {cutText['FOB has already been spawned', 'PLAIN'];};" ]],"", ""],
	["Molos_Airfield",	[4], "", -5, [["expression", "newBase = 'Molos_Airfield';if !(newBase in controlledZones) then {publicVariable 'newBase'; FobName = {controlledZones pushBack newBase;}; publicVariable 'FobName'; remoteExecCall ['FobName',0]; FI2 = {[newBase] call AW_fnc_BaseManager;}; publicVariable 'FI2'; remoteExecCall ['FI2',2]; cutText['FOB spawned', 'PLAIN'];} else {cutText['FOB has already been spawned', 'PLAIN'];};" ]],"", ""],
	["Terminal",   		[5], "", -5, [["expression", "newBase = 'Terminal';		 if !(newBase in controlledZones) then {publicVariable 'newBase'; FobName = {controlledZones pushBack newBase;}; publicVariable 'FobName'; remoteExecCall ['FobName',0]; FI2 = {[newBase] call AW_fnc_BaseManager;}; publicVariable 'FI2'; remoteExecCall ['FI2',2]; cutText['FOB spawned', 'PLAIN'];} else {cutText['FOB has already been spawned', 'PLAIN'];};" ]],"", ""],
	["Back",    		[6], "", -4, [["expression", "" ]], "1", ""]
];
/*
MMFOBTanoa = [
	["Tanoa FOBs",true],  
	["Tuvanaka_Airbase",[2], "", -5, [["expression", "newBase = 'Tuvanaka_Airbase';publicVariable 'newBase'; FobName = {controlledZones pushBack newBase;}; publicVariable 'FobName';  remoteExecCall ['FobName',0];FI2 = {[newBase] call AW_fnc_BaseManager;};  publicVariable 'FI2';  remoteExecCall ['FI2',2];" ]],"", ""],
	["Lijnhaven",   	[3], "", -5, [["expression", "newBase = 'Lijnhaven';publicVariable 'newBase'; FobName = {controlledZones pushBack newBase;}; publicVariable 'FobName';  remoteExecCall ['FobName',0];FI2 = {[newBase] call AW_fnc_BaseManager;};  publicVariable 'FI2';  remoteExecCall ['FI2',2];" ]],"", ""],
	["Abandoned_Mine",  [4], "", -5, [["expression", "newBase = 'Abandoned_Mine';publicVariable 'newBase'; FobName = {controlledZones pushBack newBase;}; publicVariable 'FobName';  remoteExecCall ['FobName',0];FI2 = {[newBase] call AW_fnc_BaseManager;};  publicVariable 'FI2';  remoteExecCall ['FI2',2];" ]],"", ""],
	["Int_Airport",   	[5], "", -5, [["expression", "newBase = 'Int_Airport';publicVariable 'newBase'; FobName = {controlledZones pushBack newBase;}; publicVariable 'FobName';  remoteExecCall ['FobName',0];FI2 = {[newBase] call AW_fnc_BaseManager;};  publicVariable 'FI2';  remoteExecCall ['FI2',2];" ]],"", ""],
	["Back",    		[6], "", -4, [["expression", "" ]], "1", ""]
];
*/
MMFOBMalden = [
	["Malden FOBs",true],  
	["Corton, FOB neptune", [2], "", -5, [["expression", "newBase = 'corton';	if !(newBase in controlledZones) then {publicVariable 'newBase'; FobName = {controlledZones pushBack newBase;}; publicVariable 'FobName'; remoteExecCall ['FobName',0]; FI2 = {[newBase] call AW_fnc_BaseManager;}; publicVariable 'FI2'; remoteExecCall ['FI2',2]; cutText['FOB spawned', 'PLAIN'];} else {cutText['FOB has already been spawned', 'PLAIN'];};" ]],"", ""],
	["Back",    			[3], "", -4, [["expression", "" ]], "1", ""]
];

MMRewards = [
	["Spawn reward",true],  
	["jet rewards",				[2], "#USER:MMJetRewards", 	-5, [["expression", ""]], "1", ""],
	["attack heli rewards",		[3], "#USER:MMAHeliRewards",-5, [["expression", ""]], "1", ""], 	
	["transport heli rewards",	[4], "#USER:MMTHeliRewards",-5, [["expression", ""]], "1", ""], 
	["UAV/UGV rewards",			[5], "#USER:MMUAVRewards",	-5, [["expression", ""]], "1", ""],
	["MBT rewards",				[6], "#USER:MMMBTRewards",	-5, [["expression", ""]], "1", ""],
	["IFV rewards",				[6], "#USER:MMIFVRewards",	-5, [["expression", ""]], "1", ""],
	["APC/AA rewards",			[7], "#USER:MMAPCRewards",	-5, [["expression", ""]], "1", ""],
	["MRAP rewards",			[8], "#USER:MMMRAPRewards",	-5, [["expression", ""]], "1", ""],
	["Car rewards",				[9], "#USER:MMCarRewards",	-5, [["expression", ""]], "1", ""],
	["Random reward",   		[10],"", -5, [["expression", "[[nil,-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",    				[11],"", -4, [["expression", "" ]], "1", ""]
];

MMJetRewards = [
	["Spawn jets",true],  
	["Wipeout",   			[2],"", -5, [["expression", "[[['an A-164 Wipeout (CAS)', 'B_Plane_CAS_01_dynamicLoadout_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Blackfish gunship",   [3],"", -5, [["expression", "[[['a V-44 X Blackfish Gunship', 'B_T_VTOL_01_armed_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["black wasp",   		[4],"", -5, [["expression", "[[['an F/A-181 Black/ Wasp II', 'B_Plane_Fighter_01_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["stealth black wasp",  [5],"", -5, [["expression", "[[['an F/A-181 Black Wasp II (Stealth)', 'B_Plane_Fighter_01_Stealth_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Gryphon",   			[6],"", -5, [["expression", "[[['an A-149 Gryphon', 'I_Plane_Fighter_04_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",    			[7],"", -4, [["expression", "" ]], "1", ""]
];
MMAHeliRewards = [
	["Spawn armed heli",true],  
	["kajman",   [2],"", -5, [["expression", "[[['an MI-48 Kajman', 'O_Heli_Attack_02_dynamicLoadout_black_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["blackfoot",[3],"", -5, [["expression", "[[['an AH-99 Blackfoot', 'B_Heli_Attack_01_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Orca",   	 [4],"", -5, [["expression", "[[['a PO-30 Orca', 'O_Heli_Light_02_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["pawnee",   [5],"", -5, [["expression", "[[['an AH-9 Pawnee', 'B_Heli_Light_01_dynamicLoadout_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["hellcat",  [6],"", -5, [["expression", "[[ ['a WY-55 Hellcat', 'I_Heli_light_03_dynamicLoadout_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",     [7],"", -4, [["expression", "" ]], "1", ""]
];
MMTHeliRewards = [
	["Spawn transport heli",true],  
	["Taru (Transport)",   	[2],"", -5, [["expression", "[[['an MI-290 Taru (Transport)', 'O_Heli_Transport_04_covered_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Taru (bench)",   		[3],"", -5, [["expression", "[[['an MI-290 Taru (Bench)', 'O_Heli_Transport_04_bench_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Taru (heavy lifter)", [4],"", -5, [["expression", "[[['an MI-290 Taru (heavy lifter)', 'O_Heli_Transport_04_black_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["xian inf transport",  [5],"", -5, [["expression", "[[['an Y-32 (Infantry Transport, unarmed)', 'O_T_VTOL_02_infantry_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",    			[6],"", -4, [["expression", "" ]], "1", ""]
];
MMUAVRewards = [
	["Spawn UAV/UGV reward",true],  
	["UCAV",   		[2],"", -5, [["expression", "[[['a UCAV Sentinel', 'B_UAV_05_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Praetorian",  [3],"", -5, [["expression", "[[['a hemtt mounted Praetorian 1C', 'Land_VR_CoverObject_01_kneelHigh_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Spartan",     [4],"", -5, [["expression", "[[['a hemtt mounted Mk49 Spartan', 'Land_VR_CoverObject_01_standHigh_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",    	[5],"", -4, [["expression", "" ]], "1", ""]
];
MMMBTRewards = [
	["Spawn MBT reward",true],  
	["T100",   		 		[2],"", -5, [["expression", "[[['a T-100 Varsuk', 'O_MBT_02_cannon_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["enhanced T100",		[3],"", -5, [["expression", "[[['an enhanced T-100 Varsuk', 'Land_W_sharpStone_01'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Kuma",   		 		[4],"", -5, [["expression", "[[['an MBT-52 Kuma', 'I_MBT_03_cannon_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Enhanced kuma",		[5],"", -5, [["expression", "[[['an enhanced MBT-52 Kuma', 'Land_BluntStones_erosion'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["slammer",   	 		[6],"", -5, [["expression", "[[['an M2A4 Slammer', 'B_T_MBT_01_cannon_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["slammer UP",   		[7],"", -5, [["expression", "[[['an M2A4 Slammer (Urban Purpose)', 'B_MBT_01_TUSK_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["enhanced slammer UP",	[8],"", -5, [["expression", "[[['an enhanced M2A4 Slammer (Urban Purpose)', 'Land_W_sharpStone_02'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",    		 	[9],"", -4, [["expression", "" ]], "1", ""]
];
MMIFVRewards = [
	["Spawn IFV reward",true],  
	["Mora",   				[2],"", -5, [["expression", "[[['an FV-720 Mora', 'I_APC_tracked_03_cannon_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["enhanced mora",   	[3],"", -5, [["expression", "[[['an enhanced FV-720 Mora', 'Land_PipeWall_concretel_8m_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Gorgon",   			[4],"", -5, [["expression", "[[['an AFV-4 Gorgon', 'I_APC_Wheeled_03_cannon_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["enhanced Gorgon",   	[5],"", -5, [["expression", "[[['an enhanced AFV-4 Gorgon', 'Land_Net_Fence_pole_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["marshall",   			[6],"", -5, [["expression", "[[['an AMV-7 Marshall', 'B_APC_Wheeled_01_cannon_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["enhanced marshall",   [7],"", -5, [["expression", "[[['an enhanced AMV-7 Marshall', 'Land_Pipe_fence_4m_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",    			[8],"", -4, [["expression", "" ]], "1", ""]
];
MMAPCRewards = [
	["Spawn APC/AA reward",true],  
	["Cheetah",   		[2],"", -5, [["expression", "[[['an IFV-6a Cheetah', 'B_APC_Tracked_01_AA_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Bobcat",   		[3],"", -5, [["expression", "[[['a CRV-6e Bobcat', 'B_APC_Tracked_01_CRV_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["minigun bobcat",  [4],"", -5, [["expression", "[[['a minigun Bobcat', 'OfficeTable_01_new_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",    		[5],"", -4, [["expression", "" ]], "1", ""]
];
MMMRAPRewards = [
	["Spawn MRAP reward",true],  
	["Strider HMG",   	[2],"", -5, [["expression", "[[['a Strider HMG', 'I_MRAP_03_hmg_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Strider GMG",   	[3],"", -5, [["expression", "[[['a Strider GMG', 'I_MRAP_03_gmg_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Strider lynx",   	[4],"", -5, [["expression", "[[['a Strider (Lynx)', 'Land_Graffiti_02_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Strider minigun", [5],"", -5, [["expression", "[[['a Strider (Minigun)', 'OfficeTable_01_old_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["hunter minigun",  [6],"", -5, [["expression", "[[['a Hunter (Minigun)', 'Land_RattanTable_01_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",    		[7],"", -4, [["expression", "" ]], "1", ""]
];
MMCarRewards = [
	["Spawn car reward",true],  
	["Offroad AT",   	[2],"", -5, [["expression", "[[['an Offroad (AT)', 'Sign_Arrow_Blue_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Offroad AA",   	[3],"", -5, [["expression", "[['an Offroad (AA)', 'Sign_Arrow_Cyan_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Offroad .50",   	[4],"", -5, [["expression", "[[['an Offroad (Armed .50 cal)', 'B_G_Offroad_01_armed_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Offroad minigun", [5],"", -5, [["expression", "[[['an Offroad (Armed minigun)', 'Land_TableDesk_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Qilin armad",   	[6],"", -5, [["expression", "[[['a Qilin (Armed)', 'O_T_LSV_02_armed_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Service offroad", [7],"", -5, [["expression", "[[['an Offroad (Repair)', 'C_Offroad_01_repair_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Service van",   	[8],"", -5, [["expression", "[[['a service van', 'C_Van_02_service_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Mobile mortar",   [9],"", -5, [["expression", "[[['a Mobile Mortar Truck', 'B_G_Offroad_01_repair_F'],-1], AW_fnc_SMhintSUCCESS] remoteExec ['call', 2, false];" ]],"", ""],
	["Back",    		[10],"", -4, [["expression", "" ]], "1", ""]
];

MMAdmin = [  
	["Admin",true],  
	["ObjectID",    [2], "",      -5, [["expression", " 
		hint '';
		IDS = { ehServerAdminFnc = {['_array','_cursorObj','_AdminObj','_AdminID','_client'];  
		_array = _this select 1;    
		_cursorObj = _array select 0;   
		_AdminObj = _array select 1;      
		_AdminID = owner _AdminObj;    
		_client = owner _cursorObj;       
		ehGlobalAdmin01 = [_AdminID];
		_client publicVariableClient 'ehGlobalAdmin01';  };  
		'ehServerAdmin01' addPublicVariableEventHandler ehServerAdminFnc; }; publicVariable 'IDS'; remoteExecCall ['IDS',2];
		IDG = { ehGlobalAdminFnc = {       ['_array'];      
		_array = _this select 1;     
		_Admin = _array select 0;   
		_name = name player;     
		_uid = getPlayerUID player;           
		ehClientAdmin01 = [_name,_uid]; _Admin publicVariableClient 'ehClientAdmin01';   };
		if (!isDedicated) then {  'ehGlobalAdmin01' addPublicVariableEventHandler ehGlobalAdminFnc;  }; }; publicVariable 'IDG'; remoteExecCall ['IDG'];
		ehClientAdminFnc = {       ['_array','_client','_uid','_name'];   _array = _this select 1;      _name = _array select 0;      _uid = _array select 1;   hint format ['NAME: %1 - UID: %2',_name,_uid];  }; 
		'ehClientAdmin01' addPublicVariableEventHandler ehClientAdminFnc;
		ADDIDTool = player addAction ['<t color=''#FF0000''>OBJECT OWNER</t>',{ remoteExecCall ['IDG']; ehServerAdmin01 = [cursorTarget,player]; publicVariableServer 'ehServerAdmin01'; },[true],100]; 
		REMIDTool = player addAction ['<t color=''#FF0000''>Remove ID Tool</t>',{player removeAction ADDIDTool; player removeAction REMIDTool; player removeEventHandler ['Respawn', RESIDTool];},[true],0];  
		player call ADDIDTool; player call REMIDTool; player call REMIDTool;     
	"]],"", ""],

	["Ares modules",   	         [3], "#USER:MMAres",  -5, [["expression", ""]], "1", ""],
	["Who's left gunner?",       [4], "", -5, [["expression", "GHleftgunner = cursorTarget turretUnit [1];  hint name GHleftgunner;"]],"", ""],
	["Who's right gunner?",  	 [5], "", -5, [["expression", "GHrightgunner = cursorTarget turretUnit [2];  hint name GHrightgunner;"]],"", ""],
	["Force Time-Out",   	     [6], "#USER:MMTimeOut",  -5, [["expression", ""]], "1", ""],
	["Put TKArray in server RPT",[7], "", -5, [["expression", "_arrayLenght = count TKArray; diag_log 'TK array printed here by an admin:';for '_i' from 0 to _arrayLenght do {diag_log (TKArray select _i);};diag_log 'End TK array'; hint'TK array logged in RPT';"]],"", ""],
	["Back",      		         [8], "", -4, [["expression", ""]], "1", ""]
]; 

MMTimeOut = [
	["Time-out",true], 
	["30 seconds",  [2], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then { BIND = 'RoadCone_F' CreateVehicle (position BADBOY); BIND setPos getPos BADBOY; BADBOY attachTo [BIND,[0,0,0]]; ['You have been put on a 30 second timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 30; detach BADBOY; deleteVehicle BIND; hint 'You can move again';}; } else {hint'No unit found.';};"]],"", ""],
	["1 minute",    [3], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then { BIND = 'RoadCone_F' CreateVehicle (position BADBOY); BIND setPos getPos BADBOY; BADBOY attachTo [BIND,[0,0,0]]; ['You have been put on a 60 second timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 60; detach BADBOY; deleteVehicle BIND; hint 'You can move again';}; }else {hint'No unit found.';};"]],"", ""],
	["2 minute",    [4], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then { BIND = 'RoadCone_F' CreateVehicle (position BADBOY); BIND setPos getPos BADBOY; BADBOY attachTo [BIND,[0,0,0]]; ['You have been put on a 2 minute timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 120; detach BADBOY; deleteVehicle BIND; hint 'You can move again'; }; }else {hint'No unit found.';};"]],"", ""],
	["Back",        [5], "",  -4, [["expression", ""]], "1", ""]
];

MMAres = [  
	["Ares",true],  
	["LockAresCode",    [2], "",  -5, [["expression", "LAC = {missionNamespace setVariable ['Ares_Allow_Zeus_To_Execute_Code',false];}; publicVariable 'LAC'; remoteExecCall ['LAC',0];"]],"", ""],
	["AllowAresCode",   [3], "",  -5, [["expression", "LAC = {missionNamespace setVariable ['Ares_Allow_Zeus_To_Execute_Code',true];}; publicVariable 'LAC'; remoteExecCall ['LAC',0];"]],"", ""],
	["Back",    		[4], "", -4,[["expression", "" ]], "1", ""]
]; 

MMPlayer = [  
	["Abilities",true], 
	["TeleToCursor",        [2], "", -5, [["expression", "myloc = player; myloc setPos screenToWorld [.5,.5];"]],"", ""],  
	["Teleport Toggle",     [3], "", -5, [["expression", "switch (tele) do {  
		case 1: { tele = 2; onMapSingleClick 'vehicle player setPos _pos'; cutText['TelePort ON', 'PLAIN']; };
		case 2: { tele = 1; onMapSingleClick ''; cutText[' TelePort OFF', 'PLAIN'];  };	 };" ]],"", ""],
	["GODMODE Toggle",      [4], "", -5, [["expression", "switch (god) do { 
		case 1: { god = 2; player allowDamage false; vehicle player allowDamage false; cutText['GOD MODE - Vehicle and Player', 'PLAIN']; };
		case 2: { god = 1; player allowDamage true; vehicle player allowDamage true; cutText['GOD MODE OFF - Vehicle and Player', 'PLAIN']; };};" ]],"", ""], 
	["Fix YOU (Cur)",  		[5], "", -5, [["expression", "ATF = cursorTarget;   publicVariable 'ATF';   FI2 = {ATF setFuel 1};  publicVariable 'FI2';  remoteExecCall ['FI2',0]; vehicle cursorTarget setDamage 0; cursorTarget setVariable ['BTC_need_revive',0,true];"]],"", ""],  
	["Fix ME",              [6], "", -5, [["expression", "vehicle player setDamage 0; player setDamage 0; vehicle player setFuel 1; vehicle player setVehicleAmmo 1;"]],"", ""],    
	["Hide ME (T)",         [7], "", -5, [["expression", "switch (hide) do { 
		case 1: { hide = 2; hideme = [getPosATL player, 0, 'C_man_1', civilian] call BIS_fnc_spawnVehicle;  createVehicleCrew (hideme select 0);
		 [player] joinSilent (hideme select 0); DeleteVehicle (hideme select 0);  cutText['Hidden - World and Map', 'PLAIN']; Munit = player; publicVariable 'Munit'; Mhide = {Munit hideObjectGlobal true;}; publicVariable 'Mhide'; remoteExecCall ['Mhide'];  };
		case 2: { hide = 1; hideme = [getPosATL player, 0, 'C_man_1', west] call BIS_fnc_spawnVehicle;  createVehicleCrew (hideme select 0);  
		 [player] joinSilent (hideme select 0); DeleteVehicle (hideme select 0);  cutText['Visible - World and Map', 'PLAIN']; Munit = player; publicVariable 'Munit'; Mhide = {Munit hideObjectGlobal false;}; publicVariable 'Mhide'; remoteExecCall ['Mhide'];  }; };" ]],"", ""], 
	["Grass setting",       [8], "#USER:MMGrass", -5, [["expression", ""]], "1", ""], 
	["Night Vision",        [9], "#USER:MMNV", -5, [["expression", ""]], "1", ""],
	["Arsenal",        [10], "", -5, [["expression", "['Open',true ] spawn BIS_fnc_arsenal;"]],"", ""],  
	["Back",                [11], "", -4, [["expression", ""]], "1", ""]
]; 

MMGrass = [  
	["Grass settings",true],  
	["Grass OFF", [2], "", -5, [["expression", "setTerrainGrid 50;"]],"", ""], 
	["Grass Low", [3], "", -5, [["expression", "setTerrainGrid 30;"]],"", ""], 
	["Grass Norm",[4], "", -5, [["expression", "setTerrainGrid 12.5;"]],"", ""], 
	["Grass High",[5], "", -5, [["expression", "setTerrainGrid 3.125;"]],"", ""], 
	["Back",      [6], "", -4, [["expression", ""]], "1", ""]
];

MMNV = [  
	["night vission",true],  
	["NV low" ,[2], "", -5,[["expression","TINT = ppEffectCreate ['colorInversion', 2555];TINT ppEffectEnable true;TINT ppEffectAdjust [0,0,0];TINT ppEffectCommit 0; setaperture 1.5;"]],"", ""], 
	["NV Mid" ,[3], "", -5,[["expression","TINT = ppEffectCreate ['colorInversion', 2555];TINT ppEffectEnable true;TINT ppEffectAdjust [0,0,0];TINT ppEffectCommit 0; setaperture 0.8;"]],"", ""], 
	["NV Full",[4], "", -5,[["expression","TINT = ppEffectCreate ['colorInversion', 2555];TINT ppEffectEnable true;TINT ppEffectAdjust [0,0,0];TINT ppEffectCommit 0; setaperture 0.4;"]],"", ""], 
	["All OFF",[5], "", -5,[["expression","TINT = ppEffectCreate ['colorInversion', 2555];TINT ppEffectEnable true;TINT ppEffectAdjust [0.1,0.1,0.1];TINT ppEffectCommit 0;  setaperture -1;  ppEffectDestroy TINT;"]],"", ""], 
	["Back",   [6], "",   -4, [["expression", ""]], "1", ""]
];

MMWorld = [  
	["World",true],  
	["Remove smoke",   	[2], "#USER:MMKillSmoke",  -5, [["expression", ""]], "1", ""], 
	["Remove mines",   	[3], "#USER:MMDeleteMines",  -5, [["expression", ""]], "1", ""],
	["CleanUpScript",   [4], "", -5, [["expression", "{deleteVehicle _x;} count allDead;{deleteVehicle _x;} count (allMissionObjects 'CraterLong');{deleteVehicle _x;} count (allMissionObjects 'WeaponHolder');{deleteVehicle _x;} count (allMissionObjects 'WeaponHolderSimulated');
		_ejectionItems = [    'B_Ejection_Seat_Plane_Fighter_01_F',    'B_Ejection_Seat_Plane_CAS_01_F',    'O_Ejection_Seat_Plane_CAS_02_F',    'O_Ejection_Seat_Plane_Fighter_02_F',    'I_Ejection_Seat_Plane_Fighter_04_F',    'I_Ejection_Seat_Plane_Fighter_03_F',    'plane_fighter_01_canopy_f',    'plane_fighter_02_canopy_f',    'plane_fighter_03_canopy_f',    'plane_fighter_04_canopy_f',    'Plane_CAS_01_Canopy_f','Plane_CAS_02_Canopy_f'];
		{if ( speed _x == 0 ) then{    deleteVehicle _x; }; } forEach (entities [_ejectionItems, []]);"]],"", ""], 
	["Time acceleration ",[5], "#USER:MMTime",  -5, [["expression", ""]], "1", ""],
	["Back",           	  [6], "",   -4, [["expression", ""]], "1", ""]
];
 
MMKillSmoke = [
	["Remove smoke",true], 
	["25m",    [2], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 25]); "]],"", ""],
	["50m",    [3], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 50]); "]],"", ""],
	["100m",   [4], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 100]); "]],"", ""],
	["200m",   [5], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 200]); "]],"", ""],
	["500m",   [6], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 500]); "]],"", ""],
	["Back",   [7], "",  -4, [["expression", ""]], "1", ""]
];

MMDeleteMines = [
	["Delete mines",true], 
	["25m",    [2], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['MineBase', 25]); {deleteVehicle _x;} forEach (player nearObjects ['TimeBombCore', 25]);"]],"", ""],
	["50m",    [3], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['MineBase', 50]); {deleteVehicle _x;} forEach (player nearObjects ['TimeBombCore', 50]);"]],"", ""],
	["100m",   [4], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['MineBase', 100]); {deleteVehicle _x;} forEach (player nearObjects ['TimeBombCore', 100]);"]],"", ""],
	["200m",   [5], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['MineBase', 200]); {deleteVehicle _x;} forEach (player nearObjects ['TimeBombCore', 200]);"]],"", ""],
	["500m",   [6], "",  -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['MineBase', 500]); {deleteVehicle _x;} forEach (player nearObjects ['TimeBombCore', 500]);"]],"", ""],
	["Back",   [7], "",  -4, [["expression", ""]], "1", ""]
];

MMObject = [  
	["Object",true],  
	["MoveThis",  [2], "", -5, [["expression", "
		cutText['MoveMent keys ON -  [NUM 1-3] = Rotate , [NUM 5-8] = DOWN UP, [NUM 0] = hold to carry, [Num .] = MOVE TO CURSOR [SpaceBar] to exit', 'PLAIN'];   
		OTM = cursorTarget; 
		move_up = (findDisplay 46) displayAddEventHandler ['KeyDown', {if (_this select 1 == 72) then { OTM setPos [getPos OTM select 0,getPos OTM select 1, (getPos OTM select 2) + 0.5]; }}];
		move_down = (findDisplay 46) displayAddEventHandler ['KeyDown', {if (_this select 1 == 76) then {OTM setPos [getPos OTM select 0,getPos OTM select 1, (getPos OTM select 2) - 0.5]; }}];
		move_RotL = (findDisplay 46) displayAddEventHandler ['KeyDown', {if (_this select 1 == 79) then {OTM setDir (getDir OTM) - 5; }}];
		move_RotR = (findDisplay 46) displayAddEventHandler ['KeyDown', {if (_this select 1 == 81) then {OTM setDir (getDir OTM) + 5; }}];
		move_temp = (findDisplay 46) displayAddEventHandler ['KeyDown', {if (_this select 1 == 82) then {cdir = getDir OTM;  OTM attachTo [player,[-0.3,5,(getPosATL player select 2) + 1.5],'weapon'];  detach OTM;  OTM setDir cdir; }}];
		move_mouse = (findDisplay 46) displayAddEventHandler ['KeyDown',{if (_this select 1 == 83) then {cdir = getDir OTM; OTM setPos screenToWorld [.5,.5];}}];
		MOVEOFF = (findDisplay 46) displayAddEventHandler ['KeyDown', {if (_this select 1 == 57) then { 
		(findDisplay 46) displayRemoveEventHandler ['KeyDown', move_up];
		(findDisplay 46) displayRemoveEventHandler ['KeyDown', move_down];
		(findDisplay 46) displayRemoveEventHandler ['KeyDown', move_RotL];
		(findDisplay 46) displayRemoveEventHandler ['KeyDown', move_RotR];
		(findDisplay 46) displayRemoveEventHandler ['KeyDown', move_temp];
		(findDisplay 46) displayRemoveEventHandler ['KeyDown', move_mouse];
		(findDisplay 46) displayRemoveEventHandler ['KeyDown', MOVEOFF];
		cutText['MoveMent keys OFF', 'PLAIN'];
	}}];
	 "]],"", ""],
	["clone ",  		[3], "", -5, [["expression", "_clip = typeOf cursorTarget; hint format ['%1', _clip]; CPO = _clip; CPO CreateVehicle (position player);"]],"", ""],  
	["Disable damage",  [4], "", -5, [["expression", "TargetVehicle = cursorTarget; [TargetVehicle, false] remoteExec ['allowDamage', 0]; cutText['Damage disabled', 'PLAIN'];" ]],"", ""],
	["Enable damage",   [5], "", -5, [["expression", "TargetVehicle = cursorTarget; [TargetVehicle, false] remoteExec ['allowDamage', 0]; cutText['Damage enabled', 'PLAIN'];" ]],"", ""],   
	["Kill this",   	[6], "", -5, [["expression", "cursorTarget setDamage 1; cutText['Target killed', 'PLAIN'];" ]],"", ""],
	["Delete that", 	[7], "", -5, [["expression", "_target = cursorTarget; deleteVehicle _target"]],"", ""], 
	["unflip this",   	[8], "", -5, [["expression", "cursorTarget setVectorUp [0,0,1];cursorTarget setPos [getPos cursorTarget select 0, getPos cursorTarget select 1, 0.1]; cutText['set right way up', 'PLAIN'];" ]],"", ""],
	["Back",     		[9], "", -4, [["expression", ""]], "1", ""]
];  	

MMGroup = [  
	["Group",true],  
	["I Join Him",   	[2], "", -5, [["expression", "[player] join cursorTarget;"]],"", ""], 
	["Leave my Group",	[3], "", -5, [["expression", "[player] join grpNull;"]],"", ""],
	["Take Lead",   	[4], "", -5, [["expression", "(group player) selectLeader player;"]],"", ""],
	["25m GroupUp",   	[5], "", -5, [["expression", "{ [_x] join player} forEach nearestObjects [player,['allVehicles'],25];"]],"", ""],
	["You Join Me",   	[6], "", -5, [["expression", "[cursorTarget] join player;"]],"", ""],
	["Back",     		[7], "", -4, [["expression", ""]], "1", ""]
];

MMTime = [  
	["Time",true],  
	["half Time",      [2], "",  -5, [["expression", "NORMTIME = {setTimeMultiplier 0.5;}; publicVariable 'NORMTIME'; remoteExecCall ['NORMTIME',2];"]],"", ""],
	["Normal Time",    [3], "",  -5, [["expression", "NORMTIME = {setTimeMultiplier 1;}; publicVariable 'NORMTIME'; remoteExecCall ['NORMTIME',2];"]],"", ""],
	["10x normal Time",[4], "",  -5, [["expression", "QTIME = {setTimeMultiplier 10;}; publicVariable 'QTIME'; remoteExecCall ['QTIME',2];"]],"", ""],
	["60x normal Time",[5], "",  -5, [["expression", "HYPETIME = {setTimeMultiplier 60;}; publicVariable 'HYPETIME'; remoteExecCall ['HYPETIME',2];"]],"", ""],
	["Back",      	   [6], "",  -4, [["expression", ""]], "1", ""]
]; 

MYOWN = [  
	["Other",true],  
	["Back",    	 [2], "", -4,[["expression", "" ]], "1", ""],
	["Animations",   [4], "#USER:MMAnim",  -5, [["expression", ""]], "1", ""],
	["EMPTY",   	 [5], "", -5, [["expression", "" ]],"", ""],
	["Situation Cam",[6], "", -5, [["expression", "cam = 'camConstruct' camCreate (player modelToWorld [0,-3,3]);
	cam cameraEffect ['external', 'FRONT'];
	cam camCommand 'MANUAL ON';
	(findDisplay 46) displayRemoveEventHandler ['KeyDown', cam_kill];
	cam_kill = (findDisplay 46) displayAddEventHandler ['KeyDown', {if (_this select 1 == 57) then {cam cameraEffect ['terminate','back']; camDestroy cam; (findDisplay 46) displayRemoveEventHandler ['KeyDown', cam_kill];}}]; 
	cutText['[SpaceBar] = Exit Cam', 'PLAIN'];" ]],"", ""]
];


MMAnim = [
	["Animations",true], 
	["Play animition on me",   	      [2], "#USER:MMAnimMe",  -5, [["expression", ""]], "1", ""],
	["Play animation on someone else",[3], "#USER:MMAnimYou",  -5, [["expression", ""]], "1", ""],
	["Back",        [4],"",  -4, [["expression", ""]], "1", ""]
];

MMAnimMe = [
	["Animations (me)",true], 
	["Clear animation", [2], "",  -5, [["expression", "player switchMove'';"]],"", ""],
	["Captive (loop)",	[3], "",  -5, [["expression", "if ( currentWeapon player != '') then{ player action ['SwitchWeapon', player, player, 99];}; player playMoveNow 'Acts_AidlPsitMstpSsurWnonDnon_loop';"]],"", ""],
	["Take a piss", 	[4], "",  -5, [["expression", "if ( currentWeapon player != '') then{ player action ['SwitchWeapon', player, player, 99];}; player playMoveNow 'Acts_AidlPercMstpSlowWrflDnon_pissing';"]],"", ""],
	["Dance", 			[5], "",  -5, [["expression", "if ( currentWeapon player != '') then{ player action ['SwitchWeapon', player, player, 99];}; player playMoveNow 'AmovPercMstpSnonWnonDnon_exerciseKata';"]],"", ""],
	["Briefing (loop)", [6], "",  -5, [["expression", "if ( currentWeapon player != '') then{ player action ['SwitchWeapon', player, player, 99];}; player playMoveNow 'Acts_Briefing_SA_Loop';"]],"", ""],
	["Captive 2 (loop)",[7], "",  -5, [["expression", "if ( currentWeapon player != '') then{ player action ['SwitchWeapon', player, player, 99];}; player playMoveNow 'Acts_ExecutionVictim_Loop';"]],"", ""],
	["Back",        	[8], "",  -4, [["expression", ""]], "1", ""]
];

MMAnimYou = [
	["Animations (you)",true], 
	["Clear animation",	[2], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then { [BADBOY, ''] remoteExec ['switchMove', BADBOY, false]; }else { hint'No unit found.';};"]],"", ""],
	["Captive",			[3], "#USER:MMAnimCaptive",  -5, [["expression", ""]], "1", ""],
	["Captive 2",		[4], "#USER:MMAnimCaptive2", -5, [["expression", ""]], "1", ""],
	["Dance", 			[5], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then { [BADBOY, 'AmovPercMstpSnonWnonDnon_exerciseKata'] remoteExec ['switchMove', BADBOY, false]; }else { hint'No unit found.';};"]],"", ""],
	["Back",   			[6], "",  -4, [["expression", ""]], "1", ""]
];

MMAnimCaptive = [
	["captive",true], 
	["30 seconds",    		[2], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_AidlPsitMstpSsurWnonDnon_loop'] remoteExec ['switchMove', BADBOY, false];  ['You have been put on a 30 second timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 30;[BADBOY, ''] remoteExec ['switchMove', BADBOY, false]; ['You can move again'] remoteExec ['hint', BADBOY, false];}; }else { hint'No unit found.';};"]],"", ""],
	["1 minute",    		[3], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_AidlPsitMstpSsurWnonDnon_loop'] remoteExec ['switchMove', BADBOY, false];  ['You have been put on a 1 minute timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 60;[BADBOY, ''] remoteExec ['switchMove', BADBOY, false]; ['You can move again'] remoteExec ['hint', BADBOY, false];}; }else { hint'No unit found.';};"]],"", ""],
	["2 minutes",    		[4], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_AidlPsitMstpSsurWnonDnon_loop'] remoteExec ['switchMove', BADBOY, false];  ['You have been put on a 2 minute timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 120;[BADBOY, ''] remoteExec ['switchMove', BADBOY, false]; ['You can move again'] remoteExec ['hint', BADBOY, false];}; }else { hint'No unit found.';};"]],"", ""],
	["Till the end of time",[5], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_AidlPsitMstpSsurWnonDnon_loop'] remoteExec ['switchMove', BADBOY, false];  }else { hint'No unit found.';};"]],"", ""],
	["Back",        		[6], "",  -4, [["expression", ""]], "1", ""]
];

MMAnimCaptive2 = [
	["captive",true], 
	["30 seconds",    		[2], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_ExecutionVictim_Loop'] remoteExec ['switchMove', BADBOY, false];  ['You have been put on a 30 second timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 30;[BADBOY, 'Acts_ExecutionVictim_Unbow'] remoteExec ['playMoveNow', BADBOY, false]; ['You can move again'] remoteExec ['hint', BADBOY, false];}; }else { hint'No unit found.';};"]],"", ""],
	["1 minute",    		[3], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_ExecutionVictim_Loop'] remoteExec ['switchMove', BADBOY, false];  ['You have been put on a 1 minute timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 60;[BADBOY, 'Acts_ExecutionVictim_Unbow'] remoteExec ['playMoveNow', BADBOY, false]; ['You can move again'] remoteExec ['hint', BADBOY, false];}; }else { hint'No unit found.';};"]],"", ""],
	["2 minutes",    		[4], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_ExecutionVictim_Loop'] remoteExec ['switchMove', BADBOY, false];  ['You have been put on a 2 minute timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 120;[BADBOY, 'Acts_ExecutionVictim_Unbow'] remoteExec ['playMoveNow', BADBOY, false]; ['You can move again'] remoteExec ['hint', BADBOY, false];}; }else { hint'No unit found.';};"]],"", ""],
	["Till the end of time",[5], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_ExecutionVictim_Loop'] remoteExec ['switchMove', BADBOY, false];  }else { hint'No unit found.';};"]],"", ""],
	["Back",        		[6], "",  -4, [["expression", ""]], "1", ""]
];
   
showCommandingMenu "#USER:MMOPEN"; },[],-400, false, true];