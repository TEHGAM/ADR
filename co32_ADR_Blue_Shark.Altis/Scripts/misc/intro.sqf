if (playerSide == west) then {
_handle=createdialog "AW_INTRO";
};

if (playerSide == west) then {
	sleep 1800;
	_Ts_Hint = "<t align='center'><t size='2'><t color='#00B2EE'>Join us on TeamSpeak</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>Ts.AhoyWorld.Co.Uk<br/></t>";
	[_Ts_Hint] remoteExec ["AW_fnc_globalHint",0,false];
	sleep 1800;
	_Ts_Hint = "<t align='center'><t size='1.5'><t color='#00ffff'>Side Chat doesn't work well</t><br/>  <t size='1.5'><br/>So instead join us on Teamspeak<br/>  <br/><t color='#ff0000'>Ts.AhoyWorld.Co.Uk<br/></t>";
	[_Ts_Hint] remoteExec ["AW_fnc_globalHint",0,false];
	sleep 1800;
	_Ts_Hint = "<t align='center'><t size='2'><t color='#00B2EE'>Join us on TeamSpeak</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>Ts.AhoyWorld.Co.Uk<br/></t>";
	[_Ts_Hint] remoteExec ["AW_fnc_globalHint",0,false];
	sleep 1800;
	_Ts_Hint = "<t align='center'><t size='1.5'><t color='#00ffff'>Side Chat doesn't work well</t><br/>  <t size='1.5'><br/>So instead join us on Teamspeak<br/>  <br/><t color='#ff0000'>Ts.AhoyWorld.Co.Uk<br/></t>";
	[_Ts_Hint] remoteExec ["AW_fnc_globalHint",0,false];
};
