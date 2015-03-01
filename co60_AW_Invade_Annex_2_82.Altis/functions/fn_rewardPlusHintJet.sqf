private ["_completeTextJet"];

/*
_completeTextJet = "<t align='center'><t size='2.2'>Priority Target</t><br/><t size='1.5' color='#08b000'>Enemy CAS Neutralized</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>Focus on the main objective for now.</t>";
GlobalHint = _completeTextJet; publicVariable "GlobalHint"; hint parseText _completeTextJet;
*/
showNotification = ["EnemyJetDown", "Enemy CAS is down. Well Done!"]; publicVariable "showNotification";