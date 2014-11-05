/*
| Author: 
|
|	Quiksilver.
|_____
|
| Description: 
|	
|	Created: 26/11/2013.
|	Last modified: 9/04/2014.
|	Coded for I&A and hosted on allfps.com.au servers.
|	You may use and edit the code.
|	You may not remove any entries from Credits without first removing the relevant author's contributions, 
|	or asking permission from the mission authors/contributors.
|	You may not remove the Credits tab, without consent of Ahoy World or allFPS.
| 	Feel free to re-format or make it look better.
|_____
|
| Usage: 
|	
|	Search below for the diary entries you would like to edit. 
|	DiarySubjects appear in descending order when player map is open.
|	DiaryRecords appear in ascending order when selected.
|_____
|
| Credit:
|
|	Invade & Annex 2.00 was developed by Rarek [ahoyworld.co.uk] with hundreds of hours of work 
|	The current version was developed by Quiksilver with hundreds more hours of work.
|	
|	Contributors: Razgriz33 [AW], Jester [AW], Kamaradski [AW], David [AW], chucky [allFPS].
|	
|	Please be respectful and do not remove credits.
|______________________________________________________________*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["rules", "Правила"];
player createDiarySubject ["mods", "Моды"];
player createDiarySubject ["teamspeak", "TeamSpeak"];
player createDiarySubject ["changelog", "История"];
player createDiarySubject ["credits", "Создатели"];

//-------------------------------------------------- Rules

player createDiaryRecord ["rules",
[
"Правила",
"
<br />Целью правил является обеспечение непринужденной атмосферы для всех игроков.
<br />
<br />Правила сервера служат исключительно достижению этой цели.
<br />
<br />Права и обязанности игрока
<br />
<br />1. Запрещено уничтожение своей техники на базе.
<br />2. Мат возможен, но в ограниченных масштабах.
<br />3. Оскорбление администрации или других игроков запрещены!
<br />4. Запрещено наносить какой-либо вред члену своей команды.
<br />5. Запрещено играть 'без ника'.
<br />6. Сервер, это не тренировочная база. Для этого есть редактор.
<br />7. Запрещена реклама других серверов и ресурсов.
<br />
<br />Права и обязанности администратора
<br />
<br />Главное: Администратор сервера должен быть честным, справедливым, вежливым, внимательным и отзывчивым. Не поддаваться на любые заумные провокации, пресекать их достойно и спокойно(да, бывает и такое). При наказании, игрок должен чётко понимать за что он был наказан. Если администратор наказал кого-либо по ошибке, стоит принести извинения. 
<br />
<br />Часть 1. Администратор сервера(форума) НЕ имеет право наказать перманентным(бессрочный блок) баном: 
<br />п.1. За любое неумышленное и даже неоднократное нарушение.(тимкил, уничтожение техники или любое другое нарушение, которое было по неосторожности, администратор сам должен это выявить).
<br />п.2. Администратор не имеет права принижать достоинство игроков или третьих лиц, также и на форуме или любом стороннем интернет ресурсе, оскорбления на основе личной неприязни тем более недопустимы.
<br />п.3. Администратор не имеет права превышать данные ему полномочия для преимуществ в игре над игроками, т.е. администратор - это точно такой же обычный игрок, но наделённый полномочиями только для поддержания порядка или для поддержки игроков на сервере/форуме. Исключения составляют только технические или другие тесты на карте и т.п., при этом администратор должен вежливо предупредить об этом игрока(ов).
<br />п.4. За нарушение п.1,2 и 3 ч.1, администратор сам может быть снят с админ.должности и даже может быть заблокирован на все серверы Russian War.
<br />п.5. Любой администратор серверов может быть снят с админ.должности в любое время без его уведомления, например, по причине 'в связи с утратой доверия' или по причине его долговременного отсутствия на сервере или форуме.
<br />
<br />Часть 2. Администратор сервера(форума) имеет право наказать киком/баном до полной блокировки на серверы:
<br />п.1. За оскорбление, за любое грубое высказывание в адрес любого игрока, тем более администрации. За любую умышленную провокацию, разжигающуюю любой конфликт.
<br />п.2. За любое умышленное нарушение, мешающее людям играть, например:
умышленное вредительство(уничтожение техники или оборудования дружественных войск без согласования с ними), намеренное убийство своих(teamkill) без их согласия, захват техники игрока, который её уже занял, тем более с помощью убийства.
<br />п.3. За игнорирование игроком запросы для поддержки, предусмотренных его специальностью(медик, инженер). Администратор имеет право удалить такого игрока с сервера только после вразумительного предупреждения и только КИК-ом. А также имеет право удалить(КИК) игрока с сервера, который никак не реагирует на вызов по радиосвязи или по ЧАТ-у игры.
<br />п.4. За нечестную игру в любой форме, например, реверсный перезаход за разные команды на играх ПВП(синие, красные и т.д.) для получения тактической информации о команде противника. А также, играя за одну команду, передавая информацию другой с помощью сторонних средств связи(Скайп, Тимспик и т.д.) Подобные нарушения пресекаются временным или перм.баном.(на усмотрение администратора, который должен точно выявить, пользовался игрок перезаходом за другую команду для получения информации или нет, при серьёзных сомнениях наказывать перм.БАН-ом запрещено(может быть, что игрок теперь захотел поиграть за другую команду и перезашёл 1 раз) а при обращении наказанного игрока за нарушение правил п.4 части 2 стоит разобраться в этом детально, а при отсутствии каких-либо доказательств в этом нарушении - разбанить). Примечание: администратор имеет право пресекать 'прыжки' за разные команды КИК-ом или временным БАН-ом, но только после предупреждения, рецидивисты могут наказываться более строго.
<br />п.5. За агитацию или рекламу других серверов, которые не имеют отношения к серверам Russian War, за плагиат.
<br />п.6. За флуд в радиоэфире(разговоры не по делу, мешающие игрокам, а значит и процессу игры) игроки могут наказываться КИК-ом или кратковременным БАН-ом только после предупреждения. Примечание: игроки, умышленно вносящие дестабилизицию в процесс игры с помощью флуда, могут наказываться временным или даже перманентным БАН-ом.
<br />п.7. За использование любых сторонних хак.программ, дающих неоспоримое преимущество над другими игроками, а именно: чит-коды, модульные чит-моды и т.д. Такие игроки наказываются полной блокировкой(перм.БАН) на все серверы Russian War, без права обжалования.
<br />
<br />Ban Perm - бан перманентный - это самая серьёзная мера наказания, т.е. блокировка на сервер/форум на неопределённый срок. Такой бан администрация может снять только на своё усмотрение.
<br />
"
]];

//-------------------------------------------------- Mods

player createDiaryRecord ["mods",
[
"Моды",
"
<br /> Разрешенные моды на сервере:<br /><br />

<br />- Community Base Аddons (CBA).
		http://tehgam.com/viewtopic.php?f=5&amp;t=21 <br /><br />

<br />- JSRS (CBA обязателен).
		http://tehgam.com/viewtopic.php?f=5&amp;t=19&amp;p=19 <br /><br />

<br />- VTS Simple weapon resting (сошки).
		http://tehgam.com/viewtopic.php?f=5&amp;t=49 <br /><br />		

<br />
"
]];

//-------------------------------------------------- TeamSpeak

player createDiaryRecord ["teamspeak",
[
"Скачать TS3",
"
<br /> TeamSpeak:<br /><br />
<br /> http://www.teamspeak.com/?page=downloads
"
]];

player createDiaryRecord ["teamspeak",
[
"Наш TeamSpeak",
"
<br /> Адрес: 213.21.12.135
"
]];

//-------------------------------------------------- Change Log

player createDiaryRecord ["changelog",
[
"Версия 3.3",
"<br />- Добавили три вертолета из нового официального дополнения;
<br />- Перенесли ящики со снаряжением и экипировкой для игроков в терминал;
<br />- Добавили библиотеку RotorLib на сервер."
]];

//-------------------------------------------------- Credits

player createDiaryRecord ["credits",
[
"Invade & Annex",
"
<br />Mission authors:<br /><br />

		- <font size='16'>Quiksilver</font> - All FPS (allfps.com.au)<br /><br />
		- <font size='16'>Rarek</font> - Ahoy World (ahoyworld.co.uk)<br />
		
<br />Contributors:<br /><br />
		- Jester - Ahoy World (ahoyworld.co.uk)<br />
		- Razgriz33 - Ahoy World (ahoyworld.co.uk)<br />
		- Kamaradski - Ahoy World (ahoyworld.co.uk)<br />
		- chucky - All FPS (allfps.com.au)<br /><br />
		
<br />Other:<br /><br />
		VAS<br />
		- Kronzky<br />
		- Sa-Matra<br />
		- Dslyecxi<br /><br />
		=BTC= Revive<br />
		- Giallustio<br /><br />
		EOS<br />
		- BangaBob<br /><br />
		Squad Manager<br />
		- aeroson<br /> <br />
		TAW View Distance<br />
		- Tonic<br /> <br />
		aw_fnc<br />
		- Alex Wise<br /><br />
		Vehicle Respawn<br />
		- Tophe<br /><br />
		SHK Taskmaster<br />
		- Shuko<br /><br />
		Fast rope<br />
		- Zealot<br /><br />
		Map markers<br />
		- aeroson<br /><br />
		Jump<br />
		- ProGamer<br /><br />
		Gear restrictions<br />
		- wildw1ng<br /><br />
		Safe zone<br />
		- Bake<br />
"
]];

player createDiaryRecord ["credits",
[
"TEHGAM.COM",
"
<br />Разработчики миссии:<br /><br />

		- <font size='16'>mexan</font><br /><br />
		- <font size='16'>Cleric</font><br /><br />
		- <font size='16'>tym32167</font><br />			
		
<br />Активные участники:<br /><br />
		- Tourorist <br />
		- KaMeG <br />		
		
<br />Благодарности:<br /><br />
		Мы благодарим всех игроков которые уделяют своё время проекту оставляя нам отзывы и коментарии на форуме. Тем самым Вы способствуете в исправлении текущих неполадок и разработке дальнейших улучшений данной миссии. Огромное спасибо!<br />
"
]];
`
