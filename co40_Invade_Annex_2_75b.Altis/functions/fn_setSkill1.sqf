
if(!isServer) exitWith{};
{
	_x setSkill ["aimingAccuracy", 0.3];
	_x setSkill ["aimingShake", 0.7];
	_x setSkill ["aimingSpeed", 0.4];
	_x setSkill ["commanding", 1];
	_x setSkill ["courage", 1];
	_x setSkill ["endurance", 1];
	_x setSkill ["general", 1];
	_x setSkill ["reloadSpeed", 1];
	_x setSkill ["spotDistance", 0.8];
	_x setSkill ["spotTime", 0.6];
} forEach (_this select 0);