if (playerSide == west) then {
_handle=createdialog "AW_INTRO";
};

if (playerSide == west) then {
	sleep 1800;
	_Ts_Hint = "<t align='center'><t size='2'><t color='#00B2EE'>Заходите на наш сервер Тимспика</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>TS.TEHGAM.COM<br/></t>";
	TsHint = _Ts_Hint; publicVariable "TsHint"; hint parseText TsHint;
	TsHintLoop = false; publicVariable "TsHintLoop";
	sleep 1800;
	_Ts_Hint = "<t align='center'><t size='1.5'><t color='#00ffff'>Игровой чат не лучший способ общения</t><br/>  <t size='1.5'><br/>Присоединяйтесь к нам в Тимспике<br/>  <br/><t color='#ff0000'>TS.TEHGAM.COM<br/></t>";
	TsHintLoop = _Ts_Hint; publicVariable "TsHintLoop"; hint parseText TsHintLoop;
	sleep 1800;
	_Ts_Hint = "<t align='center'><t size='2'><t color='#00B2EE'>Заходите на наш сервер Тимспика</t><br/><br/>_____________<br/><br/><t size='1.5'><t color='#ff0000'>TS.TEHGAM.COM<br/></t>";
	TsHint = _Ts_Hint; publicVariable "TsHint"; hint parseText TsHint;
	TsHintLoop = false; publicVariable "TsHintLoop";
	sleep 1800;
	_Ts_Hint = "<t align='center'><t size='1.5'><t color='#00ffff'>Игровой чат не лучший способ общения</t><br/>  <t size='1.5'><br/>Присоединяйтесь к нам в Тимспике<br/>  <br/><t color='#ff0000'>TS.TEHGAM.COM<br/></t>";
	TsHintLoop = _Ts_Hint; publicVariable "TsHintLoop"; hint parseText TsHintLoop;
};
