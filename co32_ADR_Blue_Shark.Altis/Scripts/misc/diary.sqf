/*
| Author:
|
|	Quiksilver.
|_____
|
| Description:
|
|	Created: 26/11/2013.
|	Coded for I&A and hosted on allfps.com.au servers.
|	You may use and edit the code.
|	You may not remove any entries from Credits without first removing the relevant author's contributions,
|	or asking permission from the mission authors/contributors.
|	You may not remove the Credits tab, without consent of Ahoy World or allFPS.
| 	Feel free to re-format or make it look better.
|
|	Last edited: 28/09/2017 by stanhope
|
|	Edited: Updated changelog
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
|	Contributors: Razgriz33 [AW], Jester [AW], Kamaradski [AW], David [AW], chucky [allFPS], stanhope [AW].
|
|	Please be respectful and do not remove credit.
|*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["rules", "Rules"];
player createDiarySubject ["mods", "Mods"];
player createDiarySubject ["teamspeak", "Teamspeak"];
player createDiarySubject ["faq", "FAQ"];
player createDiarySubject ["changelog", "Change Log"];
player createDiarySubject ["Settings", "Settings"];
player createDiarySubject ["credits", "Credits"];

//-------------------------------------------------- Rules

player createDiaryRecord ["rules",
[
"Player Report",
"
<br />If you see any player breaking the rules and you can`t find an admin ingame or on Teamspeak, please use the following procedure:
<br />1. Go to forums.ahoyworld.net
<br />2. In navigation menu look for Player Tools button, it opens a drop-down menu
<br />3. Select Player report option
<br />4. Fill in a player report, be honest and provide enough evidence
"
]];

player createDiaryRecord ["rules",
[
"Enforcement",
"
<br />The purpose of the above rules are to ensure a fun and relaxing environment for public players.
<br />
<br />Server rules are in place merely as a means to that end.
<br />
<br />Guideline for enforcement:
<br />
<br />-	Innocent rule violation and disruptive behavior:
<br />
<br />		= Verbal / Written request to cease, or warning.
<br />
<br />-	Minor or first-time rule violation:
<br />
<br />		= Kick, or 0 - 3 day ban.
<br />
<br />-	Serious or repetitive rule violation:
<br />
<br />		= 3 - 7 day ban.
<br />
<br />-	Administrative ban (hack/exploit/verbal abuse/serious offense):
<br />
<br />		= permanent or 30 day.
<br />
<br />
<br />The above is subject to discretion.
"
]];

player createDiaryRecord ["rules",
[
"General",
"
<br />This is a short summary of the rules.  The full rules can be found at:
<br />1: https://forums.ahoyworld.net/topic/8378-the-rules-of-ahoyworld/
<br />2: http://www.ahoyworld.net/index/rules/
<br />
<br />Rules:
<br />1: Teamkilling in any way shape or form is not allowed
<br />2: Play the mission as intended. No bug exploiting, hacking, ...
<br />3: Play your role
<br />3.1: The role of pilots is to provide logistical support to infantry
<br />4: Consider your skill as a pilot before taking a Pilot slot.
<br />5: Do not waste assets.
<br />6: Respect game immersion.
<br />7: Trolling in any way will be dealt with swiftly and harshly.
<br />
<br />By playing on our server you agree to abide by the rules of ahoyworld. 
<br />Any breaking of the rules can result in sanction being applied by a member of staff.
"
]];

//-------------------------------------------------- Mods

player createDiaryRecord ["mods",
[
"Serverside",
"
<br /> Mods currently running on server (subject to change without notice):<br /><br />

<br />- None at this time.
"
]];

player createDiaryRecord ["mods",
[
"Mods Allowed",
"
<br /> Mods currently allowed (subject to change without notice):<br />
<br /> Note that this list might be out of date. Visit mods.ahoyworld.net for the most up to date list.<br />
<br />-CBA
<br />-DynaSound 2
<br />-Enhanced Soundscape
<br />-JSRS SOUNDMOD
<br />-ShackTac_User_Interface
<br />-outlw_magrepack
<br />-tao_foldmap_a3
<br />
"
]];

//-------------------------------------------------- Teamspeak

player createDiaryRecord ["teamspeak",
[
"TS3",
"
<br /> You can download Teamspeak here:<br />
<br /> http://www.teamspeak.com/?page=downloads
<br />
"
]];

player createDiaryRecord ["teamspeak",
[
"AHOY WORLD",
"
<br /> Teamspeak IP-address for the AW server:
<br /> ts.ahoyworld.net
<br />
<br /> Visitors and guests welcome!
"
]];

//-------------------------------------------------- FAQ

player createDiaryRecord ["faq",
[
"UAVs",
"
<br /> In the Control Tower at base, a UAV Operator can now recycle the UAV crew on one of the computer terminals.
<br /><br />
<br /><font size='16'>Q:</font> Can I use the UAVs?<br />
<br /><font size='16'>A:</font> Yes, however you must be in the UAV Operator role and you must have a UAV Terminal.
<br />
<br /><font size='16'>Q:</font> Why do i get the don't troll hint when using my UAV?<br />
<br /><font size='16'>A:</font> Because our base protection is a bit too eager to stop trolls, until we can come up with a fix for this you'll have to sit somewhere outside of base protection.
<br />
<br /><font size='16'>Q:</font> Why can't I connect to the UAV?<br />
<br /><font size='16'>A:</font> Sometimes the UAVs are still connected to the prior Operators Terminal. If he disconnects or dies, sometimes the Terminal does not delete properly. The only solution at this time is to destroy the UAV, and you yourself must respawn.
"
]];

player createDiaryRecord ["faq",
[
"Squads",
"
<br /><font size='16'>Q:</font> How do I join or create a squad?<br />
<br /><font size='16'>A:</font>
<br /> 1. Press 'U' to open BI Squad Management.
<br /> 2. If you receive a squad invite from another player, hold 'U' to accept it.
<br />
"
]];

player createDiaryRecord ["faq",
[
"Bipod",
"
<br /><font size='16'>Q:</font> How do I deploy bipod or rest my weapon?<br />
<br /><font size='16'>A:</font> Press C (default) to rest your weapon or deploy the bipod.
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

player createDiaryRecord ["faq",
[
"Mortars",
"
<br /><font size='16'>Q:</font> Can I use the Mortars?
<br /><font size='16'>A:</font> Yes, However if you are not in the mortar gunner role you will not have acess to the Artillery Computer.<br />
<br /><font size='16'>Q:</font> How do I use the Mortar without the computer?
<br /><font size='16'>A:</font> You have to manually find the target with the sight. Here are some steps to use the mortar.
<br /> 1. Press the F key to select the firing distance.
<br /> 2. If you are in line-of-sight just put the cursor on the target and use the page up and page down keys to change the elevation.
<br /> 3. Fire!<br />
<br /><font size='16'>Here is a youtube video that can explain in more detail.<br />
<br /> https://www.youtube.com/watch?v=SCCvXfwzeAU
"
]];
player createDiaryRecord ["faq",
[
"Artillery",
"
<br /><font size='16'>Q:</font> Can I use the Artillery in base?
<br /><font size='16'>A:</font> Yes and no<br />
<br /> No you cannot get in them and shoot them yourself<br /> 
<br /> Yes you can use them by buying arty strikers with your points.
<br /> Points are gained by killing enemies and can be seen by pressing P by default.
"
]];
player createDiaryRecord ["faq",
[
"Rangefinder",
"
<br /><font size='16'>Q:</font> Why doesn't my rangefinder display the range?
<br /><font size='16'>A:</font> Since the jets DLC there is a key you have to press to display the range
<br />You can find this keybind under:
<br />Esc-configure-controls-weapons-lase range
<br />
"
]];

//-------------------------------------------------- diary options
player createDiaryRecord ["Settings", 
[
"View Distance",
"
<br/>Click <execute expression = '[] spawn CHVD_fnc_openDialog;'>here</execute> to change your view distance settings.
<br/>Click <executeClose expression = '[] spawn CHVD_fnc_openDialog;'>here</executeClose> to close the map and change your view distance settings.
"
]];


//-------------------------------------------------- Change Log

player createDiaryRecord ["changelog",
[
"3.00",
"
<br /><font size='16'>- Initial Altis and Tanoa Release</font>
"
]];
player createDiaryRecord ["changelog",
[
"3.00.06",
"
<br />- Includes Changelog for versions 3.00.00 to 3.00.06
<br />
<br />- [Added] Spotters Should now be able to get Ghillies.
<br />- [Added] Some checks in Main AO for which faction is mainFaction.
<br />- [Added][Altis] Expanded Safezone to include hill north of Main Spawn.
<br />- [Fixed] Turret Control.
<br />- [Fixed] Friendly Fire Messages.
<br />- [Fixed] FOB AO's not completing.
<br />- [Fixed] Priority Arty not spawning enemies.
<br />- [Fixed] Enemy heli reinforcements for main AO.
<br />- [Fixed] FOB's not having arsenal and not spawning their Vehicles.
<br />- [Fixed] AI at main AO would trap themselves in their formation and not move.
<br />- [Fixed] script error with earplugs and now add ability to get earplugs from start.
<br />- [Fixed][Altis] Hunter Spawn was spawning Prowlers.
<br />- [Fixed][Tanoa] Enemy Cas spawn on Tanoa.
<br />- [Tweaked] Teleport AddActions should now only appear when FOB has been captured.
<br />- [Updated] Revive.
<br />- [Updated] Mission will end after X amount of AO's.
<br />- [Replaced] TAW VD with CHVD.

"
]];
player createDiaryRecord ["changelog",
[
"3.00.07",
"
<br />- [Added] Added radio sounds to supports.
<br />- [Fixed] Underwater Mission not deleting enemies once done.
<br />- [Fixed] View distance now on only arsenal men.
<br />- [Fixed] Addaction to spawn in hunter/prowler back to Arsenal man.
<br />- [Tweaked] Friendly Fire messages now come from Crossroads.
<br />- [Removed][Tanoa] Removed Yanukka AO.
"
]];
player createDiaryRecord ["changelog",
[
"3.00.08",
"
<br />- [Fixed] Player spamming radio callouts.
<br />- [Tweaked] UAV respawn is now 5 minutes.
<br />- [Tweaked] Arty should now take longer between firing.
<br />- [Tweaked] Rewrote pilot restriction.
"
]];
player createDiaryRecord ["changelog",
[
"3.00.09",
"
<br />- [Fixed] Huge error in the priority arti causing massive rpt spam.
<br />- [Tweaked] Chopper Down message delay reduced.
"
]];
player createDiaryRecord ["changelog",
[
"3.00.10",
"
<br />- [Fixed][Tanoa] AO's not working properly.
<br />- [Fixed][Tanoa] FOB Comms Bravo.
"
]];
player createDiaryRecord ["changelog",
[
"3.1.1",
"
<br />- [Added] Safezone to main base
<br />- [Added] Added Prowlers to the respawn Vehicles
<br />- [Added] TK protection
<br />- [Fixed][Altis] AO's not working properly.
<br />- [Tweaked] Rewrote pilot restriction.
<br />- [Tweaked] UAV and plane repair pad's
"
]];
player createDiaryRecord ["changelog",
[
"3.1.2",
"
<br />- [Added] Prio AA mission
<br />- [Added] Runway light's
<br />- [Added] Refueling option's for smaller helo's
<br />- [Fixed][Altis] AO's not working properly.
<br />- [Tweaked] Derp_revive
<br />- [Tweaked] Moved Vehicle pickup and Blackfish spawn added arsenal to vheicle lift

"
]];
player createDiaryRecord ["changelog",
[
"3.1.3",
"
<br />- [added] clear vehicle inventory option
<br />- [added] new side mission
<br />- [fixed] AOs will no longer enter deadlock
<br />- [fixed] AA side mission cleanup
<br />- [Fixed] Certain units spawning damaged
<br />- [Fixed][altis] Frini woods bugging out
<br />- [tweaked] zeus related stuff
<br />- [tweaked] Under the hood stuff for AO and side missions
"
]];
player createDiaryRecord ["changelog",
[
"3.1.4",
"
<br />- [added] USS Freedom
<br />- [added] Blackwasp and UCAV to the Freedom
<br />- [added] Blackwasp (both versions) and UCAV to side mission rewards
<br />- [tweaked] Rescue the pilot side mission bleedout timer is now 15 minutes
"
]];
player createDiaryRecord ["changelog",
[
"3.1.5",
"
<br />- [added] squad XML hint
<br />- [added] Side mission reward: hemtt mounted praetorian and spartan
<br />- [added] Side mission reward: Unarmed inf transport xi'an
<br />- [added] Side mission reward: LAT hellcat
<br />- [added] Side mission reward: AT, AA and .50 cal offroad
<br />- [added] Side mission reward: Armed qilin
<br />- [Fixed] UAV rearm pad not working for certain UAVs
<br />- [Fixed] Rewards spawning damaged
<br />- [Fixed] Pawnee camos not displaying correctly
<br />- [tweaked] Side mission reward spawn rate
"
]];

player createDiaryRecord ["changelog",
[
"3.2.0",
"
<br />- <font size='16'>Initial release malden Invade and Annex</font><br />
<br />- [added] Random ghosthawk camos
<br />- [added] Random blackwasp camos
<br />- [added] AA for the USS freedom
<br />- [added] Random loadouts for respawning jets
<br />- [added] Nato or black skins for some FOB vehicles
<br />- [added] System that prevents unplayable levels of fog
<br />- [added] Nato or black skins for some side mission rewards
<br />- [Fixed] Typo in earplugs hint
<br />- [tweaked] Service pad speed
<br />- [tweaked] UCAV respawn timer
<br />- [tweaked] Prio AA now spawns 3x AA assets
<br />- [tweaked] Blackwasp respawn timer and loadout
<br />- [tweaked] Ammo in AT/AA offroad (side mission reward)
<br />- [tweaked] Base AA is now a Praetorian 1C (AAA turret)
<br />- [tweaked] Under the hood stuff for zeus
<br />- [tweaked] Under the hood stuff for main AO
<br />- [tweaked] Under the hood stuff for side missions
<br />- [tweaked] Under the hood stuff for side mission rewards
<br />- [tweaked] Under the hood stuff for prio AA and arty objective
<br />- [tweaked] Under the hood stuff for teleporting to the carrier
<br />- [tweaked][altis][tanoa] Placements of the carrier
<br />- [tweaked][altis][tanoa] Placements of things on the carrier
<br />- [removed][altis] Arsenal on the carrier
"
]];

player createDiaryRecord ["changelog",
[
"3.2.1",
"
<br />- [added] Random Huron camos
<br />- [added] Billboards advertising AWE
<br />- [added] Two new ground vehicle rewards
<br />- [Fixed] Destroyed radiotowers now despawn
<br />- [Fixed] Incorrect link appeared when you spawn
<br />- [Fixed] [Malden] Le Port AO bugging out
<br />- [tweaked] Pilot spawn restricted to pilots
<br />- [tweaked] Under the hood stuff for Zeus
<br />- [tweaked] Under the hood stuff for carrier AA
<br />- [tweaked] Under the hood stuff for side missions
<br />- [tweaked] Under the hood stuff for prio AA objective
<br />- [tweaked] Under the hood stuff for blacklisting co-pilots 
<br />- [tweaked][Malden] Moved some stuff around in base
"
]];

player createDiaryRecord ["changelog",
[
"3.2.2",
"
<br />Hotfix
<br />- [Fixed] Prio AA objective bugging out
"
]];

player createDiaryRecord ["changelog",
[
"3.2.3",
"
<br />- [added] New side mission rewards
<br />- [added] New side mission, the old Kavala/Pyrgos CQC mission
<br />- [added][Altis] Vehicle service station at FOB guardian
<br />- [Fixed] Side missions will not spawn on FOBs any more
<br />- [Fixed] Jet service notification displaying the wrong number
<br />- [tweaked] Side mission rewards spawn rate
"
]];

player createDiaryRecord ["changelog",
[
"3.2.4",
"
<br />- [added] New priority objective, factory
<br />- [tweaked] TK messages
<br />- [tweaked] Under the hood things for zeus
<br />- [tweaked] Under the hood things for the CQC side mission
<br />- [tweaked] Verious other under the hood tweaks
<br />- [Fixed][Altis] AOs near FOB guardian bugging out
"
]];

player createDiaryRecord ["changelog",
[
"3.2.5",
"
<br />- [added] Actual FOB things to the FOBs
<br />- [tweaked] AO spawn order
<br />- [tweaked] CQC side mission
<br />- [tweaked] Protect UN forces side mission
<br />- [tweaked] Various things for the prio factory mission
<br />- [tweaked] Multiple under the hood changes to several things
"
]]; 


player createDiaryRecord ["changelog",
[
"3.2.6",
"
<br />- [added] New sub-objective: HQ
<br />- [added] Several new side mission rewards
<br />- [added] 2 new side missions: militia camp and capture intel
<br />- [tweaked] Main AO garrisonned infantry
<br />- [tweaked] The way vehicles spawn in at FOBs
<br />- [tweaked] General tweaks to several side missions
<br />- [tweaked] General tweaks to main AO spawn handler
<br />- [tweaked] Random loadout from the wasp (non-stealth)
<br />- [tweaked] General tweaks to several behind the screens things
<br />- [tweaked][Altis] FOB layout
<br />- [tweaked][Altis] Vehicles that spawn at FOBs
<br />- [fixed][Altis] AO bugging out
"
]];  


player createDiaryRecord ["changelog",
[
"3.2.7",
"
<br />- [tweaked] Arty firing loop
<br />- [fixed][Altis] FOB triggers not working as intended
"
]]; 

player createDiaryRecord ["changelog",
[
"3.2.8",
"
<br />- [tweaked] General tweaks to several behind the screens things
<br />- [fixed] Arty not despawning
"
]];

player createDiaryRecord ["changelog",
[
"3.2.9",
"
<br />- [added] Respawnable transport van at base
<br />- [added] Side mission reward: service van
<br />- [tweaked] Arsenal blacklist
<br />- [tweaked] Tweaked side mission code
<br />- [tweaked] Random loadouts of vehicles tweaked
<br />- [tweaked] Tweaked all the priority missions code
<br />- [tweaked] Various minor tweaks to multiple things
<br />- [fixed] several behind the screen bugs
<br />- [fixed] hint spam at militia camp mission
<br />- [fixed] spelling mistakes in search and rescue mission
"
]];

player createDiaryRecord ["changelog",
[
"3.3.0",
"
<br />- [added][Malden] service pads to FOBs
<br />- [added] New side mission: rescue IDAP
<br />- [added] New side mission: secure asset
<br />- [added] New sub objective: goalkeeper
<br />- [added] New sub objective: T-100 section
<br />- [added] Unflip vehicle option, requires 4 people to use
<br />- [added] Action that allows pilots to despawn damaged helis in base
<br />- [added] A function that allows max 3 teamkills. On your 2nd teamkill you will receive a final warning. 10 minutes after a teamkill it will be forgotten and forgiven
<br />- [tweaked][altis] FOB design
<br />- [tweaked] Pilot restriction code
<br />- [tweaked] Various behind the screen tweaks
<br />- [tweaked] The code for all the prio objectives
<br />- [tweaked] Air- and ground-vehicle service script
<br />- [tweaked] No shooting in base hint will display your name
<br />- [tweaked] Spawn points of FOBs will now get the name of said FOB
<br />- [tweaked] Various spelling mistakes corrected (and new ones made)
<br />- [tweaked] Some hints have been replaced by a fancier looking box with text
<br />- [tweaked] The code for all the side missions (except the secure intel mission)
<br />- [fixed] Refuel option for engineers
<br />- [fixed] No shooting in base hint will not show up when controlling UAVs or when using flares
<br />- [removed] Side mission: secure chopper
<br />- [removed][altis] Some main AOs that were to close to FOBs
"
]];

player createDiaryRecord ["changelog",
[
"3.3.1",
"
<br />- [tweaked] Service script, rewrote the rearm section
<br />- [tweaked] Vehicle unflip action.  Now allows for 4 player or a bobcat
<br />- [fixed] Side missions not spawning
<br />- [fixed] Save gear option not showing up
<br />- [fixed] TK-script displaying wrong messages
<br />- [fixed] Radio tower completion hint displaying wrong AO name format
<br />- [fixed] (hopefully) Cache subobjective shouldnt bug out and if it does the AO should still be completable
"
]];

player createDiaryRecord ["changelog",
[
"3.3.2",
"
<br />- [fixed] (hopefully) Side missions not spawning
"
]];

player createDiaryRecord ["changelog",
[
"3.3.3",
"
<br />- [fixed] Rearm script getting stuck in a loop when the vehicle has nothing to rearm
<br />- [fixed] Several side missions not completing
"
]];

player createDiaryRecord ["changelog",
[
"3.3.4",
"
<br />- [added] Radiotower sub-obj will spawn with minefield
<br />- [fixed] Side mission objectiver marker not despawning
<br />- [tweaked] Unflip vehicle action range increased
<br />- [tweaked] Radiotower jet made more deadly.
<br />- [tweaked] Jets and UAVs dont have a laser.  They will need to rely on infantry to desigante things.
<br />- [tweaked] Units spawned by the main AO.  Now: 1x MBT, 2x-4x tigris, 2x-4x APC/IFV, 3x-5x car/MRAP, 8x normal inf group, 3x AA team, 3x AT team, 4x recond squad, max 15 garrisoned buildings in the center of the AO.
"
]];

player createDiaryRecord ["changelog",
[
"3.3.5",
"
<br />-several bug fixes
"
]];

player createDiaryRecord ["changelog",
[
"3.3.6",
"
<br />- [fixed] Error in cache sub-objective
<br />- [fixed] Side mission doors not opening
<br />- [fixed] Massive error spam in prio-AA objective
<br />- [fixed] Side mission rewards not having refuel and flip actions
<br />- [tweaked] Performance of TK-script increased
<br />- [tweaked] Minimum required amount of players for prio objective to spawn increased
"
]];

player createDiaryRecord ["changelog",
[
"3.3.7",
"
<br />- [added] Sling weapon script
<br />- [added] IandA progress saver
<br />- [added] Vanilla-based arsenal
<br />- [added] Ghost hawk door script
<br />- [added] Automatic server restarter
<br />- [added] Option to add supplycrates to helis
<br />- [added] time multiplier for during nighttime
<br />- [added] Intel mechanic for urban cache sidemission
<br />- [added] Some checks to prevent some of the script-kids
<br />- [added] Positive feedback system for prio missions (will prevent no prio mission spawning for prolonged periods of time)
<br />
<br />- [fixed] Side mission spawning 2 rewards
<br />- [fixed] Fixed ground service (hopefully)
<br />- [fixed] Prototype tank side mission cleanup not running
<br />- [fixed] Cache sub-objective holdaction not working as intended
<br />
<br />- [tweaked] Arsenal restrictions
<br />- [tweaked] Init-scripts tweaked
<br />- [tweaked] FOB-vehicle respawn timers
<br />- [tweaked] HQ sub objective will now spawn jets
<br />- [tweaked] Rewrote base AA for more performance
<br />- [tweaked] Rescue pilot mission (changes for performance)
<br />- [tweaked] Vehicle respawn script (changes for performance)
<br />- [tweaked] The same side mission won't spawn 2 times in a row
<br />- [tweaked] Sub objectives are now sub objectives of the main objective
<br />- [tweaked] Research side mission won't spawn with documents anymore, only laptops
<br />- [tweaked] Prio objectives will only spawn when there are at least 15 infantry on the server
<br />- [tweaked] General tweaks, both for visials and for performance to several scripts/functions/missions
<br />
<br />- [removed] Derp arsenal
<br />- [removed] Stomper, 2x prowler and 1 hunter HMG from base vehicle pool
<br />- [removed] Custom vehicle HUD (the green names on the left side of the screen)
"
]];

//-------------------------------------------------- Credits
player createDiaryRecord ["credits",
[
"I&A 3",
"
<br />Mission authors:
<br />
<br />	- <font size='16'>BACONOP</font>
<br />
<br />
<br />Contributors:
<br />
<br />	- alganthe - Ahoy World (ahoyworld.net)
<br />	- Quicksilver
<br />	- PERO - Ahoy World (ahoyworld.net)
<br />	- Zissou - Ahoy World (ahoyworld.net)
<br />	- Stanhope - Ahoyworld member (ahoyworld.net)
<br />	- Ryko - Ahoyworld (ahoyworld.net)
<br />
<br />With the help of:
<br />
<br />	- Pfc. Christiansen - Ahoy World (ahoyworld.net)
<br />	- <font size='16'>The AhoyWorld community</font>
<br />
<br />Other:
<br />
<br />	Ordinance Script
<br />		- Wolfenswarm
<br />
<br />	CHVD
<br />		- Champ-1
<br />
"
]];
