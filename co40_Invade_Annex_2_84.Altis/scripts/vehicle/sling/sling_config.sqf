minLiftingHeight = 2.4;

maxLiftingDistance = 10;
maxLiftingHeight = 10;

superheavy = ["B_MBT_01_cannon_F","B_MBT_01_arty_F","B_Mortar_01_F","I_MBT_03_cannon_F","B_MBT_01_TUSK_F"];
heavy = ["B_Truck_01_covered_F","B_Truck_01_Repair_F","B_Truck_01_medical_F","B_Truck_01_fuel_F","B_APC_Tracked_01_CRV_F","B_APC_Tracked_01_rcws_F","B_APC_Wheeled_01_cannon_F","I_APC_tracked_03_cannon_F","I_APC_Wheeled_03_cannon_F","B_APC_Tracked_01_AA_F"];
medium = ["C_Van_01_fuel_F","B_MRAP_01_F","B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","B_UGV_01_F","B_UGV_01_rcws_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","B_Boat_Armed_01_minigun_F","B_SDV_01_F","O_Truck_03_covered_F"];
light = ["B_Quadbike_01_F"];

lowSpeedThreshold = 30; // lower than threshold = smooth drag
mediumSpeedThreshold = 70; // lower than threshold = bumpy drag, higher = sling detach

stationaryVel = [0,0,0]; // collision velocity with no bounce on lifted unit
collisionDampen = 0.90; // velocity dampening effect on lifting chopper because of collision
collisionCounter = 2;
bumpiness = -1.2; // must be negative to recreate the up and down feeling and greater than 1 to magnify the effect
