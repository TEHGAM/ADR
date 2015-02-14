_helo = _this select 0;
while{(_helo getVariable "aw_sling_attached") AND (alive _helo)} do
{
	waitUntil{sleep 0.1;(player == driver _helo)};
	while{(_helo getVariable "aw_sling_attached") AND (player == driver _helo)} do
	{
		_unit = (_helo getVariable "aw_sling_object");
		_minZ = (((boundingBox _unit) select 0) select 2);
		//_height = ((_unit modelToWorld [0,0,_minZ]) select 2);
		_height = (((getPos _unit select 2) + 2.4) + _minZ);
		_string = format["Высота груза: %1",_height];
		[_string,0,0,0.12,0] spawn BIS_fnc_dynamicText;
		sleep 0.1;
	};
};