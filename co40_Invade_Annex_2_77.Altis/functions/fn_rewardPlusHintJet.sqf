private ["_completeTextJet"];

_completeTextJet = "<t align='center'><t size='2.2'>Важная цель</t><br/><t size='1.5' color='#08b000'>НЕЙТРАЛИЗОВАНА</t><br/>____________________<br/>Вражеский штурмовик уничтожен! Такими темпами осталось ещё не долго ждать прежде чем враг будет полностью подавлен под натиском наших войск.<br/><br/>Возвращайтесь к основному заданию.</t>";
GlobalHint = _completeTextJet; publicVariable "GlobalHint"; hint parseText _completeTextJet;
showNotification = ["EnemyJetDown", "Вражеская авиаподдержа нейтрализована."]; publicVariable "showNotification";
