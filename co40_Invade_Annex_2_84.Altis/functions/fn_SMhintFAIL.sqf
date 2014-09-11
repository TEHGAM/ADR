private ["_failedText"];

_failedText = "<t align='center'><t size='2.2'>Side Mission</t><br/><t size='1.5' color='#b60000'>FAILED</t><br/>____________________<br/>
	You'll have to do better than that next time!<br/><br/><br/>Focus on the main objective for now; we'll relay the bad news to HQ, with some luck we'll have another objective lined up. 
	We'll get back to you in 15 - 30 minutes.</t>";

GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;