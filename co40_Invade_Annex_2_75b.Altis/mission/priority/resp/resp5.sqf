if (mdh_resp_resp5 > 0) then
{
	{_x setdamage 1} forEach (nearestObjects [(getpos resppos), [], mdh_resp_resp5]);
};
