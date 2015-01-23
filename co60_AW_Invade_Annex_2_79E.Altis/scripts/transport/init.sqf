g_transport_light_offset = [0, 1, -0.25]; 	// offset for the attachment point on the mh9
g_transport_ka_60_offset = [0, 1, -3.25]; 	// offset for the attachment point on the Ka-60
g_transport_speed_difference_cap = 3; 		// Difference in speed between target and transport in kmph
g_transport_distance_cap = 15;				// Maximum distance between the target and transport in meters
g_transport_forgiveness_multiplier = 1;	// Forgiveness multiplier is applied to all calculations for a fudge factor. It is a game after all. 

// Types of vehicles that can be transported
g_transport_transportable = ["LandVehicle", "Ship"]; 

// Types of vehicles that can be transported
g_transport_transports = ["air"];			

allUnits + vehicles execVM "scripts\transport\classify.sqf";
SystemChat "=Transport Ropes= initialized.";
