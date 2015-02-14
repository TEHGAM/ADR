_helo = _this select 0;

_target = (_helo getVariable "aw_sling_object");
_minZ = (((boundingBox _target) select 0) select 2);

//if(((_target modelToWorld [0,0,_minZ]) select 2) < 0) exitWith {hint "Too Low To Release"};
if((((getPos _target select 2) + 2.4) + _minZ)  < 0) exitWith {hint "Слишком низко для сброса груза."};

detach _target;
_target setVelocity (velocity _helo);
_helo setVariable ["aw_sling_attached",false,true];