private ["_completeTextJet"];

_completeTextJet = "<t align='center'><t size='2.2'>Priority Target</t><br/><t size='1.5' color='#08b000'>Вражеская авиаподдержа нейтрализована.</t><br/>____________________<br/>Отличная работа, парни! Вражеские силы не смогут устоять если вы продолжите!<br/><br/>Теперь сосредоточьтесь на основном задании.</t>";
GlobalHint = _completeTextJet; publicVariable "GlobalHint"; hint parseText _completeTextJet;
showNotification = ["Вражеский самолёт сбит", "Вражеская воздушная поддержка уничтожена. Отличная работа!"]; publicVariable "showNotification";
