/*
Author: 

	BACONMOP


Description:

	Creates a camp for side missions

______________________________________________*/
params ["_pos"];
_fobs = [
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9"
];
sideMissionCampGlobalArray = [];
_fobType = _fobs call BIS_fnc_selectRandom;
switch(_fobType) do {
// FOB 1
	case "1":{
		_FOB =	[
		["Land_TentDome_F",[2.58594,2.60742,0],324.418,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[-2.05469,-4.20313,0],104.048,1,0,[0,-0],"","",true,false], 
		["Land_TentDome_F",[-4.44434,3.00586,0],196.675,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[4.26367,-3.79688,0],18.606,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_3_F",[6.52051,-2.10742,0],276.269,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_3_F",[6.00586,3.77148,0],228.124,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_3_F",[1.55469,-6.62891,0],155.838,1,0,[0,-0],"","",true,false], 
		["Land_HBarrier_3_F",[-1.88574,7.84375,0],0,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_3_F",[-8.17578,-2.09766,0],273.809,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_3_F",[-5.5625,6.49414,0],127.003,1,0,[0,-0],"","",true,false], 
		["Land_HBarrier_3_F",[-4.38672,-6.95703,0.00273132],208.128,1,0,[0,0],"","",true,false], 
		["Land_Razorwire_F",[11.1318,-8.45508,-1.90735e-006],132.174,1,0,[0,-0],"","",true,false], 
		["Land_Razorwire_F",[6.31738,12.5723,-0.000534058],33.1601,1,0,[0,0],"","",true,false], 
		["Land_Razorwire_F",[14.1367,4.20898,-9.91821e-005],89.7362,1,0,[0,0],"","",true,false], 
		["Land_Razorwire_F",[-5.2666,14.0488,-1.90735e-006],350.256,1,0,[0,0],"","",true,false], 
		["Land_Razorwire_F",[-14.334,4.69727,0.000520706],291.683,1,0,[0,0],"","",true,false], 
		["Land_Razorwire_F",[-13.8389,-8.24414,0.00999641],247.46,1,0,[0,0],"","",true,false], 
		["Land_Razorwire_F",[-1.54004,-16.0059,0.0109425],190.625,1,0,[0,0],"","",true,false]
		];
		_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;
		[_safePos,0,_FOB] call BIS_fnc_ObjectsMapper;
		{
		createVehicleCrew _x;
		} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
		sideMissionCampGlobalArray pushBack _FOB;
	};

//FOB 2
	case "2":{
		_FOB =	[
		["Land_TentDome_F",[-1.06934,-2.07031,-0.00302315],91.4853,1,0,[0,-0],"","",true,false], 
		["Land_HBarrier_1_F",[2.8457,-1.20508,-5.72205e-006],217.931,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[-0.914063,3.89258,0.00259209],270.277,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_1_F",[3.80957,-0.0078125,0.00159073],217.959,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[-2.125,-4.13477,-0.00309944],0,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_1_F",[-4.71191,2.07031,-0.00302315],222.591,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_1_F",[5.17383,0.394531,0.00214195],269.288,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[-5.0332,-4.32227,-0.00309944],269.744,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[4.44824,4,0.00629807],270.947,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_1_F",[-3.42676,4.66016,0.00105858],0,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[-3.36328,6.26172,0.00919151],0,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[4.48145,-4.68945,-0.0040226],0.629686,1,0,[0,0],"","",true,false], 
		["O_HMG_01_A_F",[6.05469,-3.5,0.00206566],134.499,1,0,[-1.91332,0.180069],"","",true,false], 
		["Land_HBarrier_5_F",[6.67188,4.86719,0.00203323],89.759,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[-5.20605,0.439453,-0.00309944],219.666,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[7.31641,-1.71484,-0.00370026],88.9063,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[2.32813,6.2793,0.00690079],0,1,0,[0,0],"","",true,false], 
		["O_HMG_01_A_F",[-6.82422,4.99219,0.00127029],308.497,1,0,[-1.91998,0.288525],"","",true,false], 
		["Land_BagFence_Long_F",[-5.46094,6.8457,-0.00179482],178.532,1,0,[0,-0],"","",true,false]
		];
		_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;
		[_safePos,0,_FOB] call BIS_fnc_ObjectsMapper;
		{
		createVehicleCrew _x;
		} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
		sideMissionCampGlobalArray pushBack _FOB;
	};

//FOB 3
	case "3":{
		_FOB =	[ 
		["CamoNet_BLUFOR_F",[1.58984,1.10938,0],0,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[-0.272461,-2.78906,0],89.5516,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[2.97852,-1.19922,0],50.7746,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[-3.01367,4.68945,0],0,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[4.89453,2.4043,0],0.686683,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[-1.77637,-5.70508,0],0,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[-4.68457,-5.89453,0],269.744,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[-4.85742,-1.13281,0],219.666,1,0,[0,0],"","",true,false], 
		["O_HMG_01_high_F",[5.37988,-3.96484,-0.0871296],147.788,1,0,[-0.000774463,0.000474266],"","",true,false], 
		["Land_HBarrier_5_F",[2.67773,4.70898,0],0,1,0,[0,0],"","",true,false], 
		["Land_HBarrier_5_F",[7.02051,3.29688,0],89.759,1,0,[0,0],"","",true,false], 
		["Land_Mil_ConcreteWall_F",[5.06641,-5.64063,9.53674e-006],158.67,1,0,[0,-0],"","",true,false], 
		["O_HMG_01_high_F",[-6.20898,4.86523,-0.0871277],329.98,1,0,[0.00120113,-4.12378e-005],"","",true,false]
		];
		_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;
		[_safePos,0,_FOB] call BIS_fnc_ObjectsMapper;
		{
		createVehicleCrew _x;
		} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
		sideMissionCampGlobalArray pushBack _FOB;
	};

//FOB 4
	case "4":{
		_FOB =	[
		["Land_BagFence_Round_F",[-1.54785,0.498047,-0.00130081],256.706,1,0,[0,0],"","",true,false], 
		["O_Mortar_01_F",[-3.41699,-0.0683594,-0.0383873],290.905,1,0,[-0.00127124,-0.00880812],"","",true,false], 
		["Land_TentDome_F",[3.32031,1.91309,0],324.418,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[0.15332,4.62402,0],277.74,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Round_F",[-4.41406,-1.73438,-0.00130081],20.7004,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Round_F",[-1.16602,-4.58691,-0.00130081],263.512,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[4.51465,-2.33594,0],18.606,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Round_F",[-4.70215,2.15039,-0.00130081],150.447,1,0,[0,-0],"","",true,false], 
		["Land_BagFence_Round_F",[-4.42285,-2.58496,-0.00130081],153.91,1,0,[0,-0],"","",true,false], 
		["O_Mortar_01_F",[-3.44238,-4.5625,-0.0384083],183.753,1,0,[-0.000980532,-0.0072472],"","",true,false], 
		["Land_TentDome_F",[2.58398,-6.01172,0],44.131,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Round_F",[-4.30957,-6.61523,-0.00130081],22.701,1,0,[0,0],"","",true,false]
		];
		_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;
		[_safePos,0,_FOB] call BIS_fnc_ObjectsMapper;
		{
		createVehicleCrew _x;
		} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
		sideMissionCampGlobalArray pushBack _FOB;
	};

//FOB 5
	case "5":{
		_FOB =	[
		["Land_BakedBeans_F",[-0.708008,1.06445,2.86102e-005],96.1648,1,0,[-0.0342149,0.0797368],"","",true,false], 
		["Land_CerealsBox_F",[-0.577148,1.17188,9.72748e-005],212.113,1,0,[0.196642,0.00885301],"","",true,false], 
		["Land_BakedBeans_F",[-1.2959,0.40625,2.67029e-005],328.849,1,0,[-0.0295964,0.0725444],"","",true,false], 
		["Land_Canteen_F",[-1.29004,0.570313,4.76837e-005],40.9242,1,0,[0.0827543,0.0239605],"","",true,false], 
		["Land_Bucket_F",[2.09082,0.410156,6.10352e-005],246.218,1,0,[-0.0207851,0.04228],"","",true,false], 
		["Land_CampingChair_V1_F",[-2.34277,-1.62109,0.00312996],346.675,1,0,[-0.00635422,0.00374521],"","",true,false], 
		["Land_Basket_F",[2.46191,-1.4668,4.00543e-005],137.111,1,0,[0.00784679,0.0118743],"","",true,false], 
		["Land_WoodPile_F",[1.83691,-2.92773,0],277.724,1,0,[0,0],"","",true,false], 
		["Land_BakedBeans_F",[-0.0361328,-3.37109,2.86102e-005],266.428,1,0,[-0.033764,0.0820544],"","",true,false], 
		["Land_Axe_F",[0.786133,-3.45898,-0.00335503],24.8774,1,0,[-2.69132e-005,-4.97239e-005],"","",true,false], 
		["Land_Gloves_F",[0.59668,-3.54297,3.8147e-006],281.032,1,0,[-0.000718987,0.000365739],"","",true,false], 
		["Land_TentDome_F",[2.18848,3.45117,0],280.785,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[-2.13379,4.07422,0],267.026,1,0,[0,0],"","",true,false], 
		["Land_Campfire_F",[-1.95605,-4.22656,0.0299988],209.89,1,0,[0,0],"","",true,false], 
		["Land_Camping_Light_F",[-3.85449,-3.24023,-0.00112915],178.777,1,0,[-0.105661,0.0668002],"","",true,false], 
		["Land_Sleeping_bag_brown_F",[1.31543,-4.77539,0],281.451,1,0,[0,0],"","",true,false], 
		["Land_Sacks_heap_F",[-5.24512,1.82422,0],93.11,1,0,[0,-0],"","",true,false], 
		["Land_CampingChair_V1_F",[-4.37598,-3.88281,0.00312996],280.346,1,0,[-0.00646695,0.00380846],"","",true,false], 
		["Land_Sleeping_bag_F",[-0.00683594,-6.64453,0],317.349,1,0,[0,0],"","",true,false], 
		["Land_FMradio_F",[-0.979492,-7.24609,5.72205e-006],171.781,1,0,[-0.00180567,1.4461e-005],"","",true,false], 
		["Land_Sleeping_bag_F",[-1.89063,-7.61328,0],357.809,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Round_F",[8.51172,1.6582,-0.00130081],218.967,1,0,[0,0],"","",true,false], 
		["Land_CanisterPlastic_F",[-5.08496,-6.70313,5.72205e-006],209.057,1,0,[0.0085394,-0.00274194],"","",true,false], 
		["Land_TinContainer_F",[-4.40137,-7.19336,0.00143051],269.33,1,0,[7.08567,-0.071955],"","",true,false], 
		["Land_BagFence_Round_F",[8.83691,-1.12305,-0.00130081],305.475,1,0,[0,0],"","",true,false], 
		["Land_CanisterPlastic_F",[-4.7373,-7.26563,5.72205e-006],78.4487,1,0,[0.00874056,-0.00209655],"","",true,false], 
		["Land_BagFence_Round_F",[-8.31934,2.45508,-0.00130081],200.141,1,0,[0,0],"","",true,false], 
		["O_GMG_01_high_F",[-9.11133,0.705078,-0.0868034],303,1,0,[-8.21521e-005,0.000460503],"","",true,false], 
		["Land_BagFence_Round_F",[-10.1436,-1.15625,-0.00130081],29.3423,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Round_F",[-10.8936,1.46875,-0.00130081],113.632,1,0,[0,-0],"","",true,false], 
		["Land_CanisterPlastic_F",[4.40137,-10.9297,3.8147e-006],65.8938,1,0,[0.00883968,-0.00236897],"","",true,false], 
		["Land_BagFence_Short_F",[-8.37207,-8.79102,-0.000999451],332.331,1,0,[0,0],"","",true,false], 
		["Land_Razorwire_F",[6.21387,11.2637,-1.90735e-006],191.709,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Short_F",[5.10254,-11.8301,-0.000999451],281.163,1,0,[0,0],"","",true,false], 
		["O_HMG_01_high_F",[3.0918,-12.5645,-0.0871143],148,1,0,[0.000561369,0.000129888],"","",true,false]
		];
		_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;
		[_safePos,0,_FOB] call BIS_fnc_ObjectsMapper;
		{
		createVehicleCrew _x;
		} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
		sideMissionCampGlobalArray pushBack _FOB;
	};

//FOB 6
	case "6":{
		_FOB =	[
		["Land_Flush_Light_green_F",[-0.078125,0.201172,0],0,1,0,[0,0],"","",true,false], 
		["Land_Camping_Light_F",[-0.610352,0.402344,-0.00113106],75.7837,1,0,[-0.109225,0.0705526],"","",true,false], 
		["Land_WoodenLog_F",[-0.401367,0.646484,1.14441e-005],75.0001,1,0,[-0.00625821,-0.00190268],"","",true,false], 
		["Land_TinContainer_F",[-0.193359,0.867188,0.00128746],237.387,1,0,[6.99106,2.41536],"","",true,false], 
		["Land_Campfire_F",[-0.485352,2.41992,0.0299988],26.9091,1,0,[0,0],"","",true,false], 
		["Land_CanisterFuel_F",[-2.65723,0.720703,5.14984e-005],35.7629,1,0,[0.0477631,0.00363053],"","",true,false], 
		["Land_Canteen_F",[2.7168,-1.48047,-0.0127068],17.1496,1,0,[0.0847742,0.0244581],"","",true,false], 
		["Land_Axe_F",[-2.60254,1.8125,-0.00336075],248.022,1,0,[-7.18004e-005,-2.3434e-006],"","",true,false], 
		["Land_WoodPile_F",[-3.51465,1.48633,0],1.20355,1,0,[0,0],"","",true,false], 
		["Land_Basket_F",[3.39746,-2.87891,3.43323e-005],161.745,1,0,[0.00799479,0.0119707],"","",true,false], 
		["Land_TentA_F",[4.42383,-1.30859,0],118.2,1,0,[0,-0],"","",true,false], 
		["Land_WoodenBox_F",[-2.19727,4.11328,-1.90735e-006],135.19,1,0,[-0.000218068,2.95564e-005],"","",true,false], 
		["Land_Sack_F",[4.40137,-2.67773,-0.0104122],18.1445,1,0,[-0.122723,-0.182936],"","",true,false], 
		["Land_TentA_F",[4.89063,2.53711,0],87.3948,1,0,[0,0],"","",true,false], 
		["Land_Flush_Light_yellow_F",[4.64941,3.49219,-1.14441e-005],0,1,0,[0,0],"","",true,false], 
		["Land_Flush_Light_yellow_F",[-6.28809,-1.94336,-1.14441e-005],0,1,0,[0,0],"","",true,false], 
		["Land_TentA_F",[3.90137,6.12109,0],57.6576,1,0,[0,0],"","",true,false], 
		["O_GMG_01_high_F",[-7.23047,-2.75977,-0.0861034],233.004,1,0,[0.104897,0.0095693],"","",true,false], 
		["Land_BagFence_Round_F",[-7.44531,-4.56445,-0.00147247],4.48306,1,0,[0,0],"","",true,false], 
		["Land_GasCooker_F",[1.54492,8.70703,3.8147e-006],130.54,1,0,[0.0192018,0.00354645],"","",true,false], 
		["Land_CerealsBox_F",[-0.0175781,9.03906,0.000144958],91.9983,1,0,[0.321887,0.0127638],"","",true,false], 
		["Land_RiceBox_F",[-0.777344,9.03125,5.34058e-005],352.95,1,0,[0.0571467,0.0567912],"","",true,false], 
		["Land_BakedBeans_F",[-0.988281,9.02344,2.28882e-005],37.6911,1,0,[-0.0356319,0.0742181],"","",true,false], 
		["Land_BagFence_Round_F",[-9.09277,-2.4375,-0.00485802],93.854,1,0,[0,-0],"","",true,false], 
		["Land_CerealsBox_F",[-0.199219,9.14844,8.01086e-005],67.8804,1,0,[0.166405,0.00911125],"","",true,false], 
		["Land_Canteen_F",[0.857422,9.21875,4.57764e-005],340.285,1,0,[0.0921442,0.024169],"","",true,false], 
		["Land_BottlePlastic_V2_F",[-0.716797,9.25781,-3.8147e-005],74.3907,1,0,[-0.0793525,-0.419604],"","",true,false], 
		["Land_RiceBox_F",[-0.964844,9.26953,5.14984e-005],51.1235,1,0,[0.0517682,0.0577874],"","",true,false], 
		["Land_DuctTape_F",[-3.76172,8.69531,0],99.5839,1,0,[-0.00130091,-0.00023446],"","",true,false], 
		["Land_Shovel_F",[-3.18848,9.01563,0.0242844],36.7224,1,0,[-6.20559,0.0940214],"","",true,false], 
		["Land_CanisterPlastic_F",[-4.39063,8.50781,0],196.481,1,0,[0.00859371,-0.00255748],"","",true,false], 
		["O_HMG_01_high_F",[7.8252,-5.625,-0.0871086],138.001,1,0,[-0.000354045,-0.00113945],"","",true,false], 
		["Land_Sacks_heap_F",[2.0625,9.47266,0],22.6568,1,0,[0,0],"","",true,false], 
		["Land_CanisterPlastic_F",[-3.92383,9.40039,-1.90735e-006],243.875,1,0,[0.00893949,-0.00245457],"","",true,false], 
		["Land_BagFence_Short_F",[7.55664,-6.99414,-0.000999451],179.445,1,0,[0,-0],"","",true,false], 
		["Land_BagFence_Round_F",[3.85938,10.0273,-0.00130081],222.772,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[1.11328,10.416,-0.000999451],358.245,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[-1.80469,10.332,-0.000999451],358.245,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Round_F",[-4.61914,9.88086,-0.00130081],136.002,1,0,[0,-0],"","",true,false], 
		["Land_BagFence_Short_F",[9.52441,-4.78906,-0.000999451],259.241,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Short_F",[9.08789,-6.22852,-0.000999451],131.627,1,0,[0,-0],"","",true,false]
		];
		_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;
		[_safePos,0,_FOB] call BIS_fnc_ObjectsMapper;
		{
		createVehicleCrew _x;
		} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
		sideMissionCampGlobalArray pushBack _FOB;
	};

//FOB 7
	case "7":{
		_FOB =	[
		["Land_Matches_F",[-0.533203,-0.0839844,-5.72205e-006],5.04976,1,0,[0.00618229,-0.0766202],"","",true,false], 
		["Land_Campfire_F",[0.0410156,-0.929688,0.0256424],27.42,1,0,[0,0],"","",true,false], 
		["Land_Sleeping_bag_F",[0.255859,2.00977,-0.00588608],182.544,1,0,[0,0],"","",true,false], 
		["Land_PainKillers_F",[2.61523,0.214844,-1.52588e-005],5.03959,1,0,[0.00648864,-0.0761195],"","",true,false], 
		["Land_Ammobox_rounds_F",[-1.22656,2.38281,-0.000167847],36.7644,1,0,[0.0426758,-0.119103],"","",true,false], 
		["Land_Canteen_F",[2.74219,-0.0429688,3.05176e-005],42.9675,1,0,[0.13842,-0.0299421],"","",true,false], 
		["Land_Sleeping_bag_brown_F",[-2.00586,1.26172,-0.0018177],135.534,1,0,[0,-0],"","",true,false], 
		["Land_Ammobox_rounds_F",[-1.61914,2.42969,-0.000167847],80.3268,1,0,[0.0728157,-0.0712643],"","",true,false], 
		["Land_Sleeping_bag_F",[2.2959,0.890625,-0.00969696],230.312,1,0,[0,0],"","",true,false], 
		["Land_Sleeping_bag_brown_F",[-2.76367,-0.830078,-0.00272942],91.105,1,0,[0,-0],"","",true,false], 
		["Land_CanisterPlastic_F",[-3.37305,0.65625,7.62939e-006],210.432,1,0,[-0.0233357,0.0575532],"","",true,false], 
		["Land_Axe_fire_F",[-1.9668,-2.93555,-0.00336456],5.827,1,0,[-0.0760013,-0.00778702],"","",true,false], 
		["Land_Sleeping_bag_brown_F",[2.97656,-1.55273,-0.00938034],284.138,1,0,[0,0],"","",true,false], 
		["Land_WoodPile_F",[-1.47852,-3.83203,-0.0069294],120.172,1,0,[0,-0],"","",true,false], 
		["Land_Sleeping_bag_F",[1.24414,-3.60938,-0.0078907],337.361,1,0,[0,0],"","",true,false], 
		["Land_Sacks_heap_F",[1.47559,4.88867,-0.00754738],27.137,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[-1.3623,5.53516,-0.00667],339,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[-4.17578,4.32227,0.000267029],158,1,0,[0,-0],"","",true,false], 
		["Land_BagFence_Long_F",[3.33691,5.16797,-0.00991249],218,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[-1.66309,-6.36133,-0.0103798],18,1,0,[0,0],"","",true,false], 
		["Land_CratesShabby_F",[0.541016,-6.61914,-0.00938034],346.386,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[5.79395,3.33594,-0.0103798],39,1,0,[0,0],"","",true,false], 
		["Land_WoodenBox_F",[5.98242,-3.00977,-1.52588e-005],290.311,1,0,[-0.000122373,1.72589e-005],"","",true,false], 
		["Land_WoodenBox_F",[-6.55176,2.11914,0.000352859],91.2012,1,0,[0.000717649,-0.0193284],"","",true,false], 
		["Land_BagFence_Long_F",[2.95801,-6.28125,-0.0103798],154,1,0,[0,-0],"","",true,false], 
		["Land_BagFence_Long_F",[-4.59766,-5.48047,-0.00876808],199,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[5.68066,-4.87891,-0.0103798],335,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Short_F",[-7.94629,0.212891,-0.00224113],358.922,1,0,[0,0],"","",true,false], 
		["O_HMG_01_high_F",[-8.42676,-1.64063,-0.0869465],264,1,0,[-0.0428902,0.0753397],"","",true,false]
		];
		_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;
		[_safePos,0,_FOB] call BIS_fnc_ObjectsMapper;
		{
		createVehicleCrew _x;
		} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
		sideMissionCampGlobalArray pushBack _FOB;
	};

//FOB 8
	case "8":{
		_FOB =	[
		["Land_TentDome_F",[2.78906,-1.12695,0],22,1,0,[0,0],"","",true,false], 
		["Land_Campfire_F",[-2.95996,1.04492,0.0299988],0,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[-1.91504,-3.32227,0],101,1,0,[0,-0],"","",true,false], 
		["Land_TentDome_F",[2.15625,3.44727,0],308,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[-3.9541,5.01953,-0.000999451],317,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[1.45117,6.88477,-0.000999451],183,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[-2.3623,-6.63086,-0.000999451],24,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[6.13281,3.55078,-0.000999451],250,1,0,[0,0],"","",true,false], 
		["Land_BagFence_Long_F",[3.52441,-6.66602,-0.000999451],154,1,0,[0,-0],"","",true,false], 
		["Land_BagFence_Long_F",[6.91211,-3.28125,-0.000999451],274,1,0,[0,0],"","",true,false], 
		["Land_Flush_Light_yellow_F",[-11.2715,3.15625,-1.14441e-005],0,1,0,[0,0],"","",true,false], 
		["Land_runway_edgelight",[12.6855,-4.76172,-2.09808e-005],227.734,1,0,[0.080184,-0.072875],"","",true,false], 
		["Land_Flush_Light_green_F",[-13.3184,-3.53516,0],0,1,0,[0,0],"","",true,false], 
		["Land_Flush_Light_green_F",[-11.3105,9.49023,0],0,1,0,[0,0],"","",true,false], 
		["Land_Razorwire_F",[-15.0078,4.48047,-1.90735e-006],301.709,1,0,[0,0],"","",true,false], 
		["Land_Razorwire_F",[-13.9512,-7.32617,-0.0032959],249.709,1,0,[0,0],"","",true,false]
		];
		_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;
		[_safePos,0,_FOB] call BIS_fnc_ObjectsMapper;
		{
		createVehicleCrew _x;
		} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
		sideMissionCampGlobalArray pushBack _FOB;
	};

//FOB 9
	case "9":{
		_FOB =	[
		["Campfire_burning_F",[2.39063,-0.123047,0.0299988],0,1,0,[0,0],"","",true,false], 
		["Campfire_burning_F",[-2.52051,0.730469,0.0269661],0,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[-0.950195,-4.36719,-0.00461006],101,1,0,[0,-0],"","",true,false], 
		["Land_TentDome_F",[0.888672,4.99805,0],279,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[4.37988,-5.08984,-0.00388336],69,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[-6.85938,-2.76953,-0.0100002],133,1,0,[0,-0],"","",true,false], 
		["Land_TentDome_F",[6.37207,4.0332,0],328,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[-5.0498,5.77344,0],237,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[8.29883,-0.644531,0],4.99999,1,0,[0,0],"","",true,false], 
		["Land_TentDome_F",[-9.70703,1.89258,-0.00837135],187,1,0,[0,0],"","",true,false]
		];
		_safePos = [_pos,0,50,10,0,1,0] call BIS_fnc_findSafePos;
		[_safePos,0,_FOB] call BIS_fnc_ObjectsMapper;
		{
		createVehicleCrew _x;
		} forEach nearestObjects [_safePos, ["StaticWeapon"], 50];
		sideMissionCampGlobalArray pushBack _FOB;
	};
};
_fobArray = sideMissionCampGlobalArray;
_fobArray