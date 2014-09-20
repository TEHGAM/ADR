private ["_failedText"];

_failedText = "<t align='center'><t size='2.2'>Дополнительное задание</t><br/><t size='1.5' color='#b60000'>ПРОВАЛЕНО</t><br/>____________________<br/>
	Вы должны работать лучше в следующий раз<br/><br/><br/>Теперь сосредоточьтесь на основной цели; мы отправим плохие новости в штаб, с небольшой долей везения мы получим следующее задание. 
	Мы вернемся через 15-30 минут</t>";

GlobalHint = _failedText; publicVariable "GlobalHint"; hint parseText _failedText;
