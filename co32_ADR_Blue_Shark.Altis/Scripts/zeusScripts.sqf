tele = 1;

VONWarning = 	parseText "<t align='center' font='PuristaBold' ><t size='1.4' color='#ff0000'>WARNING to ALL</t><t size='0.9'><br />No VON in SIDE, COMMAND, GLOBAL.<br />Constant VON in these channels will result in kick. <br />Use Direct, Vehicle or Group channel for VON chat or type it.</t></t>";
TSAdress = 		parseText "<t align='center' font='PuristaBold' ><t size='1.4'>AHOY TEAMSPEAK</t><t size='0.9'><br />ts.ahoyworld.net</t></t>";
FFWarning = 	parseText "<t align='center' font='PuristaBold' ><t size='1.4' color='#ff0000'>WARNING to ALL</t><t size='0.9'><br /> Check your targets,<br />Continued FF will result in Kick or Ban.<br />Not sure? Dont fire! </t></t>";
WhatsUp = 		parseText "<t align='center' font='PuristaBold' ><t size='1.4'>ZEUS</t><t size='0.9'><br />What's the issue?</t></t>";
ZeusSpam = 		parseText "<t align='center' font='PuristaBold' ><t size='1.4' color='#ff0000'>WARNING to ALL</t><t size='0.9'><br />Do not spam the zeus key (Y)<br /> This will result in either a lightning bolt landing on your head, a kick or a ban.</t></t>";
ZeusActive = 	parseText "<t align='center' font='PuristaBold' ><t size='1.2'>Message from zeus</t><t size='0.8'><br />Zeus is now active, AI is no longer dumb.<br />They now see tracers, IR lasers, hear gunshots, ...</t></t>";

AAT = player addAction ["<t color='#FF9D00'>Zeus tools V10.1</t>",{ 

MMOPEN = 
[    
	["Zeus tools",true],  
	["Global hints",   	[2], "#USER:MMHints", 	-5, [["expression", ""]], "1", ""], 
	["Invade and annex",[3], "#USER:MMIA",  	-5, [["expression", ""]], "1", ""],
	["Object",  	 	[4], "#USER:MMObject",	-5, [["expression", ""]], "1", ""],  
	["Zeus",   			[5], "#USER:MMAdmin",   -5, [["expression", ""]], "1", ""],   
	["Abilites", 	 	[6], "#USER:MMPlayer",  -5, [["expression", ""]], "1", ""], 
	["World",  			[7], "#USER:MMWorld",   -5, [["expression", ""]], "1", ""], 
	["Group",   	 	[8], "#USER:MMGroup",  	-5, [["expression", ""]], "1", ""], 
	["MYOWN",   	 	[9], "#USER:MYOWN",  	-5, [["expression", ""]], "1", ""],
	["Tools off", 	 	[10], "",				 -5, [["expression", "player removeAction AAT; player removeAction ADDIDTool; player removeAction REMIDTool; player removeEventHandler ['Respawn', RESIDTool]; "]], "1", ""]
]; 

MMHints = [  
	["Hints",true], 
	["VON Warning",   [2], "",  -5, [["expression", "[VONWarning] remoteExec ['hint', 0, false];"]],"", ""],
	["TS Address",    [3], "",  -5, [["expression", "[TSAdress] remoteExec ['hint', 0, false];"]],"", ""],
	["FF Warning",    [4], "",  -5, [["expression", "[FFWarning] remoteExec ['hint', 0, false];"]],"", ""],
	["Zeus Issue?",	  [5], "",  -5, [["expression", "[WhatsUp] remoteExec ['hint', 0, false];"]],"", ""],
	["Zeus Spam",     [6], "",  -5, [["expression", "[ZeusSpam] remoteExec ['hint', 0, false];"]],"", ""],
	["Zeus active",   [7], "",  -5, [["expression", "[ZeusActive] remoteExec ['hint', 0, false];"]],"", ""],
	["Clear Hints",   [8], "",  -5, [["expression", "[''] remoteExec ['hint', 0, false];"]],"", ""],
	["Back",          [9],"",   -4, [["expression", ""]], "1", ""]
];

MMIA = [  
	["Invade and annex",true],  
	["List of completed AOs",   		[2], "", -5, [["expression", "publicVariable 'controlledZones';hint str controlledZones;" ]],"", ""],
	["Count amount of completed AOs",	[3], "", -5, [["expression", "publicVariable 'controlledZones';hint str count controlledZones;" ]],"", ""],
	["spawn reward",					[4], "#USER:MMRewards", -5, [["expression", ""]], "1", ""], 
	["Back",    						[5], "", -4,[["expression", "" ]], "1", ""]
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
	["Who's left gunner?",       [2], "", -5, [["expression", "GHleftgunner = cursorTarget turretUnit [1];  hint name GHleftgunner;"]],"", ""],
	["Who's right gunner?",  	 [3], "", -5, [["expression", "GHrightgunner = cursorTarget turretUnit [2];  hint name GHrightgunner;"]],"", ""],
	["Force Time-Out",   	     [4], "#USER:MMTimeOut",  -5, [["expression", ""]], "1", ""],
	["Back",      		         [5], "", -4, [["expression", ""]], "1", ""]
]; 

MMTimeOut = [
	["Time-out",true], 
	["30 seconds",  [2], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then { BIND = 'RoadCone_F' CreateVehicle (position BADBOY); BIND setPos getPos BADBOY; BADBOY attachTo [BIND,[0,0,0]]; ['You have been put on a 30 second timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 30; detach BADBOY; deleteVehicle BIND; hint 'You can move again';}; } else {hint'No unit found.';};"]],"", ""],
	["1 minute",    [3], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then { BIND = 'RoadCone_F' CreateVehicle (position BADBOY); BIND setPos getPos BADBOY; BADBOY attachTo [BIND,[0,0,0]]; ['You have been put on a 60 second timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 60; detach BADBOY; deleteVehicle BIND; hint 'You can move again';}; }else {hint'No unit found.';};"]],"", ""],
	["Back",        [4], "",  -4, [["expression", ""]], "1", ""]
]; 

MMPlayer = [  
	["Abilities",true], 
	["TeleToCursor",        [2], "", -5, [["expression", "myloc = player; myloc setPos screenToWorld [.5,.5];"]],"", ""],  
	["Teleport Toggle",     [3], "", -5, [["expression", "switch (tele) do {  
		case 1: { tele = 2; onMapSingleClick 'vehicle player setPos _pos'; cutText['TelePort ON', 'PLAIN']; };
		case 2: { tele = 1; onMapSingleClick ''; cutText[' TelePort OFF', 'PLAIN'];  };	 };" ]],"", ""],
	["Grass setting",       [4], "#USER:MMGrass", -5, [["expression", ""]], "1", ""], 
	["Night Vision",        [5], "#USER:MMNV", -5, [["expression", ""]], "1", ""],
	["Back",                [6], "", -4, [["expression", ""]], "1", ""]
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
	["remove mines 25m",[3], "", -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['MineBase', 25]); {deleteVehicle _x;} forEach (player nearObjects ['TimeBombCore', 25]);"]],"", ""],
	["Back",           	[4], "", -4, [["expression", ""]], "1", ""]
];

MMKillSmoke = [
	["Remove smoke",true], 
	["25m",    [2], "", -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 25]); "]],"", ""],
	["50m",    [3], "", -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 50]); "]],"", ""],
	["100m",   [4], "", -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 100]); "]],"", ""],
	["200m",   [5], "", -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 200]); "]],"", ""],
	["500m",   [6], "", -5, [["expression", "{deleteVehicle _x;} forEach (player nearObjects ['smokeShell', 500]); "]],"", ""],
	["Back",   [7], "", -4, [["expression", ""]], "1", ""]
];

MMObject = [  
	["Object",true],  
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
	["Till the end of time",[5], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_AidlPsitMstpSsurWnonDnon_loop'] remoteExec ['switchMove', BADBOY, false];  }else { hint'No unit found.';};"]],"", ""],
	["Back",        		[6], "",  -4, [["expression", ""]], "1", ""]
];

MMAnimCaptive2 = [
	["captive",true], 
	["30 seconds",    		[2], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_ExecutionVictim_Loop'] remoteExec ['switchMove', BADBOY, false];  ['You have been put on a 30 second timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 30;[BADBOY, 'Acts_ExecutionVictim_Unbow'] remoteExec ['playMoveNow', BADBOY, false]; ['You can move again'] remoteExec ['hint', BADBOY, false];}; }else { hint'No unit found.';};"]],"", ""],
	["1 minute",    		[3], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_ExecutionVictim_Loop'] remoteExec ['switchMove', BADBOY, false];  ['You have been put on a 1 minute timeout'] remoteExec ['hint', BADBOY, false];  [] spawn {sleep 60;[BADBOY, 'Acts_ExecutionVictim_Unbow'] remoteExec ['playMoveNow', BADBOY, false]; ['You can move again'] remoteExec ['hint', BADBOY, false];}; }else { hint'No unit found.';};"]],"", ""],
	["Till the end of time",[5], "",  -5, [["expression", "BADBOY = cursorTarget; if (BADBOY isKindOf 'Man') then {  if ( currentWeapon player != '') then{ BADBOY action ['SwitchWeapon', BADBOY, BADBOY, 99];};[BADBOY, 'Acts_ExecutionVictim_Loop'] remoteExec ['switchMove', BADBOY, false];  }else { hint'No unit found.';};"]],"", ""],
	["Back",        		[6], "",  -4, [["expression", ""]], "1", ""]
];
   
showCommandingMenu "#USER:MMOPEN"; },[],-400, false, true];