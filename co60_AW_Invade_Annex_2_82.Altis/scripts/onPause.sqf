/*
@filename: onPauseScript.sqf
Author: 

	Quiksilver
	
Last modified:

	11/09/2014 ArmA 1.28 by Quiksilver
	
Description:

	Executed when player opens the pause menu.
__________________________________________________*/

disableSerialization;
_0 = (findDisplay 49) displayCtrl 122; _0 ctrlEnable FALSE;