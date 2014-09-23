/*
| Coded by: 
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
| How to use: 
|	
|	Search below for the diary entries you would like to edit. 
|	DiarySubjects appear in descending order when player map is open.
|	DiaryRecords appear in ascending order when selected.
|______________________________________________________________*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["rules", "Правила серверов Russian War"];		// edit to your liking, commented out with /* */ as our server rules may be different.
player createDiarySubject ["mods", "Mods"];						// edit to your liking
player createDiarySubject ["teamspeak", "Teamspeak"];			// edit to your liking
player createDiarySubject ["faq", "FAQ"];						// edit to your liking
player createDiarySubject ["changelog", "Change Log"];			
player createDiarySubject ["credits", "Credits"];				// do not edit

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
<br />5. Запрещено играть "без ника".
<br />6. Сервер, это не тренировочная база. Для этого есть редактор.
<br />7. Запрещена реклама других серверов и ресурсов.
<br />
<br />Права и обязанности администратора
<br />
<br />Главное: Администратор сервера должен быть честным, справедливым, вежливым, внимательным и отзывчивым. Не поддаваться на любые заумные провокации, пресекать их достойно и спокойно(да, бывает и такое). При наказании, игрок должен чётко понимать за что он был наказан. Если администратор наказал кого-либо по ошибке, стоит принести извинения. 
<br />
<br />Часть 1. Администратор сервера(форума) НЕ имеет право наказать перманентным(бессрочный блок) баном: 
<br />[u] п.1. За любое неумышленное и даже неоднократное нарушение.(тимкил, уничтожение техники или любое другое нарушение, которое было по неосторожности, администратор сам должен это выявить).
<br />п.2. Администратор не имеет права принижать достоинство игроков или третьих лиц, также и на форуме или любом стороннем интернет ресурсе, оскорбления на основе личной неприязни тем более недопустимы.
<br />п.3. Администратор не имеет права превышать данные ему полномочия для преимуществ в игре над игроками, т.е. администратор - это точно такой же обычный игрок, но наделённый полномочиями только для поддержания порядка или для поддержки игроков на сервере/форуме. Исключения составляют только технические или другие тесты на карте и т.п., при этом администратор должен вежливо предупредить об этом игрока(ов).
<br />п.4. За нарушение п.1,2 и 3 ч.1, администратор сам может быть снят с админ.должности и даже может быть заблокирован на все серверы Russian War.
<br />п.5. Любой администратор серверов может быть снят с админ.должности в любое время без его уведомления, например, по причине "в связи с утратой доверия" или по причине его долговременного отсутствия на сервере или форуме.
<br />
<br />Часть 2. Администратор сервера(форума) имеет право наказать киком/баном до полной блокировки на серверы:
<br />п.1. За оскорбление, за любое грубое высказывание в адрес любого игрока, тем более администрации. За любую умышленную провокацию, разжигающуюю любой конфликт.
<br />п.2. За любое умышленное нарушение, мешающее людям играть, например:
умышленное вредительство(уничтожение техники или оборудования дружественных войск без согласования с ними), намеренное убийство своих(teamkill) без их согласия, захват техники игрока, который её уже занял, тем более с помощью убийства.
<br />п.3. За игнорирование игроком запросы для поддержки, предусмотренных его специальностью(медик, инженер). Администратор имеет право удалить такого игрока с сервера только после вразумительного предупреждения и только КИК-ом. А также имеет право удалить(КИК) игрока с сервера, который никак не реагирует на вызов по радиосвязи или по ЧАТ-у игры.
<br />п.4. За нечестную игру в любой форме, например, реверсный перезаход за разные команды на играх ПВП(синие, красные и т.д.) для получения тактической информации о команде противника. А также, играя за одну команду, передавая информацию другой с помощью сторонних средств связи(Скайп, Тимспик и т.д.) Подобные нарушения пресекаются временным или перм.баном.(на усмотрение администратора, который должен точно выявить, пользовался игрок перезаходом за другую команду для получения информации или нет, при серьёзных сомнениях наказывать перм.БАН-ом запрещено(может быть, что игрок теперь захотел поиграть за другую команду и перезашёл 1 раз) а при обращении наказанного игрока за нарушение правил п.4 части 2 стоит разобраться в этом детально, а при отсутствии каких-либо доказательств в этом нарушении - разбанить). Примечание: администратор имеет право пресекать "прыжки" за разные команды КИК-ом или временным БАН-ом, но только после предупреждения, рецидивисты могут наказываться более строго.
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

<br />- Community Base addons.
		http://tehgam.com/viewtopic.php?f=5&t=21 <br /><br />

<br />- JSRS. (Community Base addons нужен обязательно)
		http://tehgam.com/viewtopic.php?f=5&t=19&p=19#p19 <br /><br />

<br />- VTS Simple weapon resting (Сошки).
		http://tehgam.com/viewtopic.php?f=5&t=49 <br /><br />		

<br />
"
]];



//-------------------------------------------------- Teamspeak


player createDiaryRecord ["teamspeak",
[
"TS3",
"
<br /> Teamspeak:<br /><br />
<br /> http://www.teamspeak.com/?page=downloads
"
]];

player createDiaryRecord ["teamspeak",
[
"Наш teamspeak",
"
<br /> Адрес: 213.21.12.135

"
]];

//-------------------------------------------------- FAQ

player createDiaryRecord ["faq",
[
"UAVs",
"
<br /><font size='16'>Q:</font> Can I use the UAVs?<br />
<br /><font size='16'>A:</font> Yes, however you must be in the UAV Operator role and you must have a UAV Terminal.
<br />
<br />
<br /><font size='16'>Q:</font> Why do the UAVs keep exploding?<br />
<br /><font size='16'>A:</font> When the bomb-equipped UAVs are first connected to, the Gunner AI fires its weapons. Until it's fixed, here is a guide for you.<br />
<br /> To safely connect to the MQ4A Greyhawk UAV:<br />
<br />	1. Enter action menu (mouse scroll), click 'Open UAV Terminal'.
<br />	2. Right-click on the UAV you wish to control, on the terminal map.
<br />	3. Click 'Connect Terminal to UAV'.
<br /><br /> [IMPORTANT] Do NOT click 'Take Control' button in UAV Terminal.<br />
<br />	4. Esc out of the UAV terminal.
<br />	5. Enter action menu (mouse scroll) again.
<br />	6. [IMPORTANT] Select 'Take UAV TURRET controls'.<br />
<br />
<br />	It is now safe to 'Take Control' of the UAV.
<br />
<br />
<br /><font size='16'>Q:</font> Why can't I connect to the UAV?<br />
<br /><font size='16'>A:</font> Sometimes the UAVs are still connected to the prior Operators Terminal. If he disconnects or dies, sometimes the Terminal does not delete properly. The only solution at this time is to destroy the UAV, and you yourself must respawn.
"
]];

player createDiaryRecord ["faq",
[
"Squads",
"
<br /><font size='16'>Q:</font> How do I join a squad?<br />
<br /><font size='16'>A:</font> 
<br /> 1. Hold 'T'.
<br /> 2. While holding T, use your scroll wheel to interact.
<br /> 3. You can interact with the person you are looking at, or those within a 5m radius.
<br />
<br /> * Xeno's Squad Management tool had to be removed at request of the script author.
"
]];

player createDiaryRecord ["faq",
[
"FOBs",
"
<br /><font size='16'>Q:</font> How do I get to a FOB?<br />
<br /><font size='16'>A:</font> 
<br /> 1. Find the whiteboard Map of Altis at main base.
<br /> 2. Scroll action menu while looking at it.
<br /> 3. Select desired FOB.
<br />
<br /> * This is one-way transportation.
"
]];

player createDiaryRecord ["faq",
[
"Bipod",
"
<br /><font size='16'>Q:</font> How do I deploy bipod?<br />
<br /><font size='16'>A:</font> Open the Mods tab and look for VTS weaponresting. 
<br /> 1. Download and follow the instructions.
<br /> 2. Use when you are in a stable firing position.
<br /> 3. Default keys: Ctrl + Spacebar
<br />
<br /> ArmA 3 does not have integrated bipod function, so we have to use community-created mods to simulate.
"
]];

player createDiaryRecord ["faq",
[
"Medics",
"
<br /><font size='16'>Q:</font> Why can't I heal him?<br />
<br /><font size='16'>A:</font> There are three conditions you must pass in order to revive a fallen comrade. 
<br /> 1. You must be in a Medic / Paramedic role.
<br /> 2. You must have a Medkit.
<br /> 3. You must have at least one First Aid Kit.
"
]];

//-------------------------------------------------- Change Log

player createDiaryRecord ["changelog",
[
"2.70.2",
"
<br />- [UPDATED]=BTC= Revive.
<br />- [UPDATED] Realistic airlift system.
<br />- [ADDED] SCUBA missions.
<br />- [ADDED] Defend AO.
<br />- [ADDED] AO Air Reinforcements.
<br />- [ADDED] Greater variety of enemy soldiers and vehicles at the AO and side missions.
<br />- [ADDED] FFIS mod.
<br />- [ADDED] Easter eggs!
<br />- [ADDED] A-143 Buzzard spawn at base (CAS).
<br />- [ADDED] UH-80 Ghost Hawk door animation added.
<br />- [ADDED] Recon Team added to role assignments.
<br />- [ADDED] Clear Inventory script added to vehicles, for easy clearing of stock inventory to facilitate custom loading.
<br />- [CHANGED] Spawn area and base layout adjusted to increase frame rate performance and mitigate griefing.
<br />- [CHANGED] HEMTT Mobile Ammo Box (VAS) Truck now respawns.
<br />- [CHANGED] Lots of subtle adjustments to AI strengths, weaknesses, and actions.
<br />- [CHANGED] UAVs adjusted to mitigate spontaneous explosion.
<br />- [FIXED] Fire-related frame-drop and crash-to-desktop bug fixed.
<br />- [FIXED] Plenty of behind-the-scenes scripts and code adjustments for performance, realism and fun!
"
]];

player createDiaryRecord ["changelog",
[
"2.70.3",
"
<br />- [UPDATED] EOS v1.95
<br />- [ADDED] New Side Missions.
<br />- [ADDED] OPFOR Static weapons.
<br />- [ADDED] UAV Connection instructions added to map Diary entry.
<br />- [CHANGED] Improved AI garrison scripts.
<br />- [CHANGED] Modified FFIS.
<br />- [CHANGED] OPFOR Artillery range reduced.
<br />- [CHANGED] AI vehicle crew behavior.
<br />- [CHANGED] Refined AO locations.
<br />- [CHANGED] Refined OPFOR behavior and waypoints.
"
]];

player createDiaryRecord ["changelog",
[
"2.70.4",
"
<br />- [UPDATED] EOS v1.96.
<br />- [UPDATED] FFIS v1.25.
<br />- [ADDED] Urban missions.
<br />- [ADDED] Medic markers and Revive tweaks.
<br />- [ADDED] UGV Stomper added.
<br />- [REMOVED] AH-9 Pawnee removed from CAS spawn.
<br />- [FIXED] Behind-the-scenes bug fixes, code adjustments and performance-related tweaks.
"
]];

player createDiaryRecord ["changelog",
[
"2.71.0",
"
<br />- [UPDATED] EOS v1.97.
<br />- [UPDATED] TAW View Distance v1.2
<br />- [UPDATED] VAS v2.3
<br />- [CHANGED] Refined urban missions and AO counterattack.
<br />- [REMOVED] Old code.
<br />- [REMOVED] Skip Time parameter.
<br />- [FIXED] De-sync associated with Skip Time.
<br />- [FIXED] Bug fixes and code adjustments aimed at improving performance and frame rate.
"
]];

player createDiaryRecord ["changelog",
[
"2.71.1",
"
<br />- [UPDATED] Map Markers.
<br />- [UPDATED] Admin tools.
<br />- [ADDED] MBT-52 Kuma to vehicle spawn.
<br />- [ADDED] VAS to unarmed UGV Stomper.
<br />- [CHANGED] Fast-Rope.
<br />- [CHANGED] Map marker color to grey, to improve clarity.
<br />- [REMOVED] Duplicate group manager (assigned to 'T' key).
<br />- [REMOVED] Global chat.
<br />- [FIXED] UI errors associated with last patch.
<br />- [FIXED] UAV spawn. Maybe. Ok, not quite.
<br />- [FIXED] Players couldn't be dragged or revived.
"
]];

player createDiaryRecord ["changelog",
[
"2.71.2",
"
<br />- [UPDATED] EOS v1.97.2. (Defend sequence).
<br />- [UPDATED] Vehicle hud (tweaked by QS).
<br />- [ADDED] FOB Gori, FOB Kali, FOB Delfinaki. Currently unmarked and not operational.
<br />- [ADDED] 
<br />- [CHANGED] AO Defend sequence, slightly. Attempt at increasing enemy aggression.
<br />- [REMOVED] Most easter eggs.
<br />- [REMOVED] Some aircraft service locations.
<br />- [REMOVED] A couple vehicles from base. Outsourced to under-construction FOBs.
<br />- [REMOVED] Personal UAV.
<br />- [FIXED] All UI errors.
<br />- [FIXED] 
"
]];

player createDiaryRecord ["changelog",
[
"2.71.3",
"
<br />- [UPDATED] 
<br />- [ADDED] T-100 to side mission rewards.
<br />- [ADDED] Radio tower minefield.
<br />- [ADDED] AA Buzzard instead of CAS (reduced respawn time!).
<br />- [CHANGED] OPFOR patrol logic, to increase performance and realism. 
<br />- [CHANGED] OPFOR skill refined, based on unit type and location.
<br />- [REMOVED] More old and inefficient code.
<br />- [FIXED] Some side mission errors.
<br />- [FIXED] AO unit spawn problems.
<br />- [FIXED] Enemy snipers smarter.
"
]];

player createDiaryRecord ["changelog",
[
"2.71.35",
"
<br />- [UPDATED]
<br />- [ADDED] Enemy UAV [currently disabled].
<br />- [ADDED] Airbase AA.
<br />- [ADDED] Weather script test.
<br />- [CHANGED] OPFOR patrol logic. They like the high ground too!
<br />- [REMOVED] More old code.
<br />- [FIXED] Enemy CAS spawn limit.
<br />- [FIXED]
"
]];

player createDiaryRecord ["changelog",
[
"2.74.3",
"
<br />- [UPDATED] =BTC= Revive v0.97 [reverted to 0.95 temporarily]
<br />- [UPDATED] EOS v1.98
<br />- [UPDATED] VAS v2.40
<br />- [ADDED] A-164 Wipeout and To-199 Neophron jets.
<br />- [ADDED] FOB Gori
<br />- [ADDED] Jet spawn at base.
<br />- [ADDED] Easier selection of VAS box (no scroll needed).
<br />- [CHANGED] Code refinement for FPS increase.
<br />- [CHANGED] Testing performance capacity, for future content expansion. 
<br />- [CHANGED] UH-80 door animation parameters (speed instead of altitude).
<br />- [CHANGED] Airlift speed increased slightly.
<br />- [REMOVED] Enemy AAF Buzzard.
<br />- [FIXED] VAS scroll menu bug
<br />- [FIXED] Clear Inventory only clears Ammo and Items. Backpacks/weapons will remain.
<br />- [Coming soon] Zeus module integration.
<br />- [Coming soon] More side missions.
<br />- [Coming soon] Enemy CAS and JTAC cooperation.
<br />- [Coming soon] More cool stuff and adjustments.
"
]];

player createDiaryRecord ["changelog",
[
"2.75.1",
"
<br />- [UPDATED]
<br />- [ADDED] Easter egg locations.
<br />- [ADDED] A couple new AOs.
<br />- [CHANGED] AO initialization (faster mission load times).
<br />- [CHANGED] Radio tower marker now rough location instead of exact.
<br />- [CHANGED] Side mission HQs now have guards.
<br />- [CHANGED] 
<br />- [REMOVED] AA Cheetah at base no longer has missiles, only autocannon.
<br />- [FIXED] Binoculars being removed when killed. [attempted fix, may cause other issues].
<br />- [FIXED] Enemy artillery.
<br />- [FIXED] Enemy CAS, slightly more effective now.
<br />- [Coming soon] ZEUS integration.
<br />- [Coming soon] See 2.74.3 for Coming Soon features.
<br />- [Next update] Added content. Such as FOB-defense missions, convoy reinforcements, etc.
"
]];

//-------------------------------------------------- Credits

player createDiaryRecord ["credits",
[
"I & A",
"
<br />Mission authors:<br /><br />
		- <font size='16'>Rarek</font> - Ahoy World (ahoyworld.co.uk)<br />
		- <font size='16'>Quiksilver</font> - All FPS (allfps.com.au)<br /><br />
		
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
		- wildw1ng
"
]];