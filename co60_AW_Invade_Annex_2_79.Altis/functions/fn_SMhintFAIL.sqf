private ["_failedText"];

_failedText = "<t align='center'><t size='2.2'>Допзадание</t><br/><t size='1.5' color='#d63333'>Провалено</t><br/>____________________<br/>Впредь будьте бдительней и работайте сообща.<br/><br/>Выдвигайтесь на базу или прямиком на точку захвата.<br/><br/>Новое дополнительное задание будет доступно в течение 15 - 30 минут.</t>";

GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;