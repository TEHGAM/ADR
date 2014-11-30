_helo = _this select 0;
if((!isServer) AND isMultiplayer) exitWith{};
_wasCollide = 0;

_magVelocity =
{
	private["_mag","_vel"];
	_vel = velocity (_this select 0);
	_mag = sqrt(((_vel select 0) * (_vel select 0)) + ((_vel select 1) * (_vel select 1)) + ((_vel select 2) * (_vel select 2)));
	_mag
};

while{alive _helo} do 
{
	waitUntil{sleep 1;_helo getVariable "aw_sling_attached"};
	while{_helo getVariable "aw_sling_attached"} do
	{
		_unit = (_helo getVariable "aw_sling_object");
		_minZ = (((boundingBox _unit) select 0) select 2);
		_height = (((getPos _unit select 2) + 2.4) + _minZ);
		
		_velocity = [_helo] call _magVelocity;
		
		if((_height < 0) AND (speed _helo > 7)) then
		{
			_wasCollide = _wasCollide + 1;
			if(_wasCollide > 4) then 
			{
				detach _unit;
				_unit setVelocity (velocity _helo);
				_helo setVariable ["aw_sling_attached",false,true];
			};
		}
		else {_wasCollide = 0};
		
		if((_height < 0) AND (speed _helo < 7)) then
		{
			_minZ = (((boundingBox _helo) select 0) select 2) - 1;
			_midY = (((boundingBox _helo) select 1) select 1) / 3;
			_attachPoint = [0,_midY,_minZ - _height];
			detach _unit;
			_unit setPos [getPos _unit select 0,getPos _unit select 1,0];
			_unit setVelocity (velocity _helo);
			_unit attachTo [_helo,_attachPoint];
		};
		
		if((!alive _helo) OR (!alive _unit)) then
		{
			detach _unit;
			_unit setVelocity (velocity _helo);
			_helo setVariable ["aw_sling_attached",false,true];
		};

		sleep 0.05;
	};
};