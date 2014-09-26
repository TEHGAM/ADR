private ["_completeTextJet"];

_completeTextJet = "<t align='center'><t size='2.2'>Важная цель</t><br/><t size='1.5' color='#08b000'>Вражеская авиаподдержа нейтрализована.</t><br/>____________________<br/>Отличная работа! Вражеские силы не смогут долго устоять перед натиском наших войск!<br/><br/>Возвращайтесь к основному заданию.</t>";
GlobalHint = _completeTextJet; publicVariable "GlobalHint"; hint parseText _completeTextJet;
showNotification = ["EnemyJetDown", "Вражеская авиаподдержа нейтрализована."]; publicVariable "showNotification";
