
IF (isnil "server")then{hint "YOU MUST PLACE A GAME LOGIC NAMED SERVER!";};
eos_fnc_spawnvehicle=compile preprocessfilelinenumbers "scripts\eos\functions\eos_SpawnVehicle.sqf";
eos_fnc_grouphandlers=compile preprocessfilelinenumbers "scripts\eos\functions\setSkill.sqf";
eos_fnc_findsafepos=compile preprocessfilelinenumbers "scripts\eos\functions\findSafePos.sqf";
eos_fnc_spawngroup= compile preprocessfile "scripts\eos\functions\infantry_fnc.sqf";
eos_fnc_setcargo = compile preprocessfile "scripts\eos\functions\cargo_fnc.sqf";
eos_fnc_taskpatrol= compile preprocessfile "scripts\eos\functions\shk_patrol.sqf";
SHK_pos= compile preprocessfile "scripts\eos\functions\shk_pos.sqf";
shk_fnc_fillhouse = compile preprocessFileLineNumbers "scripts\eos\Functions\SHK_buildingpos.sqf";
eos_fnc_getunitpool= compile preprocessfilelinenumbers "scripts\eos\UnitPools.sqf";
call compile preprocessfilelinenumbers "scripts\eos\AI_Skill.sqf";

EOS_Deactivate = {
	private ["_mkr"];
		_mkr=(_this select 0);		
	{
		_x setmarkercolor "colorblack";
		_x setmarkerAlpha 0;
	}foreach _mkr;
};

EOS_debug = {
private ["_note"];
_mkr=(_this select 0);
_n=(_this select 1);
_note=(_this select 2);
_pos=(_this select 3);

_mkrID=format ["%3:%1,%2",_mkr,_n,_note];
deletemarker _mkrID;
_debugMkr = createMarker[_mkrID,_pos];
_mkrID setMarkerType "Mil_dot";
_mkrID setMarkercolor "colorBlue";
_mkrID setMarkerText _mkrID;
_mkrID setMarkerAlpha 0.5;
};