_actUsed = _this select 1;  // Unit that used the Action (also _this in the addAction command)
_actID = _this select 2;  // ID of the Action

_object = _this select 0;

sleep 1;
_timeleft = 15;

[[hint "Charge placed on Objective. Standby..."],"BIS_fnc_spawn",nil,true] spawn BIS_fnc_MP;
sleep 0.5;
while {true} do {
hintsilent format ["Charge Explode in :%1", [((_timeleft)/60)+.01,"HH:MM"] call bis_fnc_timetostring];
if (_timeleft < 1) exitWith{};
  _timeleft = _timeleft -1;
sleep 1;
};
"Bo_Mk82" createvehicle getpos _object;
{_x setdamage 0} foreach crew _object + [_object];
SM_COMPLETE=true;publicvariable "SM_COMPLETE";

