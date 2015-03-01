minLiftingHeight = 2.4;
maxLiftingDistance = 10;
maxLiftingHeight = 10;

superheavy = ["B_MBT_01_cannon_F","B_MBT_01_arty_F","I_MBT_03_cannon_F","B_MBT_01_TUSK_F"];
heavy = ["B_APC_Tracked_01_CRV_F","B_APC_Tracked_01_rcws_F","B_APC_Wheeled_01_cannon_F","I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F","B_APC_Tracked_01_AA_F"];
medium = ["C_Van_01_fuel_F","B_MRAP_01_F","B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","B_UGV_01_F","B_UGV_01_rcws_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","B_Boat_Armed_01_minigun_F","B_SDV_01_F"];
light = ["B_Quadbike_01_F"];

lowSpeedThreshold = 30; 				// lower than threshold = smooth drag
mediumSpeedThreshold = 70; 				// lower than threshold = bumpy drag, higher = sling detach

stationaryVel = [0,0,0]; 				// collision velocity with no bounce on lifted unit
collisionDampen = 0.90; 				// velocity dampening effect on lifting chopper because of collision
collisionCounter = 2;
bumpiness = -1.2; 						// must be negative to recreate the up and down feeling and greater than 1 to magnify the effect

upwardThrust = 0;
downwardThrust = 0;
draggingDampen = 0;
liftingDampen = 0;

fnWeightParameters = {
	_unit = _this select 0;
	_unitType = typeOf _unit;

	if(({_unitType == _x} count superheavy) > 0) then {
		upwardThrust = 15; 								// upward thrust when lifted unit is detached
		downwardThrust = 0.4; 							// constant downward thrust when lifted unit is attached
		draggingDampen = 0.85; 							// velocity dampening effect on lifting chopper because of dragging
		liftingDampen = 0.975; 							// velocity dampening effect on chopper whilst lifting without obstruction			
	} else {
		if(({_unitType == _x} count heavy) > 0) then {
			upwardThrust = 12;
			downwardThrust = 0.3;
			draggingDampen = 0.85;
			liftingDampen = 0.98;
		} else {
			if(({_unitType == _x} count medium) > 0) then {
				upwardThrust = 8;
				downwardThrust = 0.2;
				draggingDampen = 0.90;
				liftingDampen = 0.985;
			} else {
				upwardThrust = 5;
				downwardThrust = 0.1;
				draggingDampen = 0.95;
				liftingDampen = 0.99;
			};
		};
	};
};
