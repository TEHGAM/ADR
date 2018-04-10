/*
Author:

	Quiksilver

Description:

	Object is teleported to side mission location
	addAction on object executes this script
	when script is done, spawn explosion and teleport object away

	Modified for simplicity and other applications (non-destroy missions).
	BIS_fnc_MP/BIS_fnc_spawn/BIS_fnc_timetostring are all performance hogs.

To do:

	Needs re-framing for 'talk to contact' type missions [DONE]

	This code is now just a variable switch, to be sent back in order that the mission script can continue.

	Does it allow for possibility of failure? I dont know, too tired at the moment.

_______________________________________________________*/

/*

_object = _this select 0;
_actUsed = _this select 1;  	// Unit that used the Action (also _this in the addAction command)
_actID = _this select 2;  		// ID of the Action

*/

//-------------------- Send hint to player that he's done something...

[[player,"AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"],"AW_fnc_switchMoveMP",nil,false] spawn BIS_fnc_MP;

hint "Receiving data...Verifying...";

sleep 1;

_name = name player;

_sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 recovered the intel.</t>",_name];
[_sidecompleted] remoteExec ["AW_fnc_globalHint",0,false];
sleep 4;

//---------- Send notice to all players that something has been done.

[] remoteExec ["Aw_fnc_smSucSwitch",2];
