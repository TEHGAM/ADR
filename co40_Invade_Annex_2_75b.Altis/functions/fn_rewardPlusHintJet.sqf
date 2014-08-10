

private ["_veh","_vehName","_vehVarname","_completeTextJet","_reward"];

	_completeTextJet = format[
	"<t align='center'><t size='2.2'>Priority AO Target</t><br/><t size='1.5' color='#00B2EE'>Enemy CAS Neutralized</t><br/>____________________<br/>Fantastic job, lads! The OPFOR stationed on the island won't last long if you keep that up!<br/><br/>Focus on the main objective for now.</t>"];

	GlobalHint = _completeTextJet; publicVariable "GlobalHint"; hint parseText _completeTextJet;
	showNotification = ["EnemyJetDown", "Enemy CAS is down. Well Done!"]; publicVariable "showNotification";