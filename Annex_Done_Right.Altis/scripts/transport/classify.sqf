{
	if (_x isKindOf "Air") then 
	{ 
		switch (typeof(_x)) do
		{		
			case "I_Heli_Transport_02_F":
			{
				[_x, 3, [0,2,-10]] execVM "scripts\transport\fn_SetupTransport.sqf";			
			};
			case "B_Heli_Transport_01_F":
			{
				[_x, 3, [0,2,-10]] execVM "scripts\transport\fn_SetupTransport.sqf";			
			};
			case "B_Heli_Transport_03_F":
			{
				[_x, 3, [0,2,-10]] execVM "scripts\transport\fn_SetupTransport.sqf";			
			};
		};
	}
	else 
	{
		if (_x isKindOf "LandVehicle" || _x isKindOf "Ship") then 
		{ 
			switch (typeof(_x)) do
			{
				case "B_Quadbike_01_F":
				{
					_x setVariable ["Classification", 1];
				};
				case "C_Quadbike_01_F":
				{
					_x setVariable ["Classification", 1];
				};
				case "I_Quadbike_01_F":
				{
					_x setVariable ["Classification", 1];
				};
				case "O_Quadbike_01_F":
				{
					_x setVariable ["Classification", 1];
				};
				default
				{
					diag_log typeof(_x);
					_x setVariable ["Classification", 2];
				};
			};
		};
	};
} foreach _this;

