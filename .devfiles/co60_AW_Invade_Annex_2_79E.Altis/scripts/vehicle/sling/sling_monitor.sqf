#include "sling_config.sqf"

_helo = _this select 0;
_wasCollide = 0;

while{alive _helo} do {
	waitUntil{sleep 1;_helo getVariable "sling_attached"};
	while{_helo getVariable "sling_attached"} do {
		_unit = (_helo getVariable "sling_object");
		_minY = (((boundingBox _unit) select 0) select 2);
		_height = (((getPos _unit select 2) + minLiftingHeight) + _minY);

		//when lifted object is above ground without obstruction
		if(_height > 1) then {
			_vel = velocity _helo;
			_velPost = [(_vel select 0)*liftingDampen,(_vel select 1)*liftingDampen,(_vel select 2)-downwardThrust];			
			_helo setVelocity (_velPost);
			sleep 0.2;
		};		
		
		//when lifted object is below ground
		if(_height < 0) then {
			_speedHelo = speed _helo;

			// high speed collision - sling breaks
			if (_speedHelo > 70) then {
				_vel = velocity _helo;
				_velPost = [(_vel select 0)*collisionDampen,(_vel select 1)*collisionDampen,(_vel select 2)-upwardThrust]; // violent collision pulls down on the chopper			
			
				detach _unit;
				_unit setVelocity (stationaryVel);
				_unit setPos [getPos _unit select 0,getPos _unit select 1,0];
				
				_helo setVariable ["sling_attached",false,true];
				_helo setVelocity (_velPost);
			} else {
				// ensure vehicle from going under ground
				_unit setPos [getPos _unit select 0,getPos _unit select 1,0];
			
				// medium speed collision - bumpy drag
				if(_speedHelo > lowSpeedThreshold) then {
					_wasCollide = _wasCollide + 1;
					if(_wasCollide > collisionCounter) then {
						_vel = velocity _helo;
						_velPost = [(_vel select 0)*collisionDampen,(_vel select 1)*collisionDampen,(_vel select 2)+upwardThrust]; //sling breaks causes upward thrust			
					
						detach _unit;
						_unit setVelocity (stationaryVel);
						
						_helo setVariable ["sling_attached",false,true];
						_helo setVelocity (_velPost);
					} else {
						_vel = velocity _helo;
						_velPost = [(_vel select 0)*collisionDampen,(_vel select 1)*collisionDampen,(_vel select 2)*collisionDampen*bumpiness];			
						_helo setVelocity (_velPost);
						
						sleep 0.2;
						
						_velPost = [(_velPost select 0)*collisionDampen,(_velPost select 1)*collisionDampen,(_velPost select 2)*bumpiness];			
						_helo setVelocity (_velPost);
					};				
				}
				
				// low speed collision - smooth drag
				else {
					_vel = velocity _helo;
					_velPost = [(_vel select 0)*draggingDampen,(_vel select 1)*draggingDampen,(_vel select 2)*draggingDampen];			
					_helo setVelocity (_velPost);
					
					_unit setVelocity (_velPost);
					
					_wasCollide = 0;
				};
			};
		};
		
		//when helo is dead
		if((!alive _helo) OR (!alive _unit)) then {
			_vel = velocity _helo;
			_velRelease = [_vel select 0,_vel select 1,_vel select 2+upwardThrust];

			detach _unit;
			_unit setVelocity (_vel);

			_helo setVariable ["sling_attached",false,true];
			_helo setVelocity (_velRelease);
		};
	sleep 0.05;
	};
};