private ["_vehicle", "_player", "_target", "_targetClassification", "_classification"];

_player = player;
_player setVariable ["CurrentTarget", objNull];

while {(true)} do
{
if (! (Alive player)) then
	{
	sleep 20;
	_player = player; //if player model changed
	waitUntil {Alive player};
	};

	sleep 0.15;
	_vehicle = vehicle player;

	if (isNull(_vehicle getVariable "AttachedVehicle")) then
	{
		_classification = _vehicle getVariable "Classification";

		if (!isNUll(_vehicle) 
			&& _player != _vehicle // player is not the current vehicle
			&& driver(_vehicle) == _player // player is the driver for the current vehicle
			&& isEngineOn _vehicle  // the vehicle is on
			&& !isTouchingGround _vehicle  // the vehicle is on the ground
			&& _classification > 0 // the vehicle is a valid transport
			) then
		{
			_target = (nearestObjects [_vehicle, g_transport_transportable, g_transport_distance_cap * g_transport_forgiveness_multiplier]) select 0;

			if (!isNull(_target)) then
			{
				_targetClassification = _target getVariable "Classification";

				if (_targetClassification <= _classification 
					&& abs(_target distance _vehicle) <= g_transport_distance_cap * g_transport_forgiveness_multiplier 
					&& abs(speed _target - speed _vehicle) <= g_transport_speed_difference_cap * g_transport_forgiveness_multiplier
					) then
				{
					_player setVariable ["CurrentTarget", _target];
				}
				else
				{
					_player setVariable ["CurrentTarget", objNull];
				};
			}
			else
			{
				_player setVariable ["CurrentTarget", objNull];
			};
			
			sleep 0.125;
		}
		else
		{	
			_player setVariable ["CurrentTarget", objNull];
			sleep 0.25;
		};
	};
};
