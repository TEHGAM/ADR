_helo = _this select 0;

_unit = (_helo getVariable "sling_object");
	
_minY = (((boundingBox _unit) select 0) select 2);

//if(((_unit modelToWorld [0,0,_minY]) select 2) < 0) exitWith {hint "Too Low To Release"};
if((((getPos _unit select 2) + minLiftingHeight) + _minY)  < 0) exitWith {hint "Too Low To Release"};

_vel = velocity _helo;
_velPost = [_vel select 0,_vel select 1,(_vel select 2)+upwardThrust];

detach _unit;
_unit setVelocity (_vel);

_helo setVariable ["sling_attached",false,true];
_helo setVelocity (_velPost);
