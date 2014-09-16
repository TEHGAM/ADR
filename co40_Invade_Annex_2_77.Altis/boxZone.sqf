//добавляет действие бобкету вошедшему в зону действия триггера (на входе название триггера) [triggername] execVM boxZone.sqf
_zone = _this select 0; //zone is first agrument in this script. Try [triggername] execVM "boxZone.sqf"
_bobcat1 = list _zone select 0; // selecting vehicle moved in this trigger area
if (vehicle _bobcat1 isKindof "B_APC_Tracked_01_CRV_F") then 
	{
	_bobcat1 vehicleChat("loading Vehicle Box");
	_bobcat1 removeAction action734;
	_bobcat1 setFuel 0;
	sleep 1;
	_bobcat1 vehiclechat "40% done";
	sleep 2;
	_bobcat1 vehiclechat "75% done";
	sleep 3;
	action734 = _bobcat1 addAction ["<t color='#FF8000'>Drop vehicle ammobox.</t>","dropResupplyBox.sqf", _bobcat1];
	_bobcat1 vehiclechat "100% done. Ready";
	_bobcat1 setFuel 1;
	cratercleaner = [7, _bobcat1] execVM "groundWorks.sqf";
	
	} ELSE 	{_bobcat1 vehiclechat "Sorry there no any crane. Only Bobcat type Vehicle supported to load box."};
	
