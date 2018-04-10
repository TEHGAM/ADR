/*
 * Author: BACONMOP
 * Underwater side mission
 *
 *
 */
// Setup and Var creation --------------------------

_thingsToDelete = [];
_buildingToDelete = [];
_underwaterBaddies = [];

// Find Location -----------------------------------

_smLoc = [] call AW_fnc_findWaterLocation;

// Spawn Enemies -----------------------------------

_underwaterBaddies = [_smLoc] call AW_fnc_underwaterTangos;

// Spawn Objective ---------------------------------

_Target = [
"Land_i_Barracks_V1_f",
"Land_Research_HQ_F",
"Land_Cargo_HQ_V3_F",
"Land_Cargo_Tower_V1_No1_F",
"Land_Cargo_Tower_V1_No2_F",
"Land_Cargo_Tower_V1_No3_F",
"Land_Cargo_Tower_V1_No4_F",
"Land_Cargo_Tower_V1_No5_F",
"Land_Cargo_Tower_V1_No6_F",
"Land_Cargo_Tower_V1_No7_F"
];

_Building = _Target call BIS_fnc_selectRandom;

_randomPos = [[[_smLoc, 100],[]],[]] call BIS_fnc_randomPos;
if !(_randomPos isEqualTo [0,0,0]) then {
	waterObjBuilding = _Building createVehicle _randomPos;
} else {
	_accepted = false;
	while {!_accepted} do {
		_randomPos = [[[_smLoc, 100],[]],[]] call BIS_fnc_randomPos;
		if !(_randomPos isEqualTo [0,0,0]) then {
			waterObjBuilding = _Building createVehicle _randomPos;
			_accepted = true;
		};
	};
};

_object = [crate3,crate4] call BIS_fnc_selectRandom;
sideObj = _object;
_cacheBuildingLocationFinal = waterObjBuilding buildingPos (1 + (random 4));
_object setPos _cacheBuildingLocationFinal;
_buildingToDelete pushBack waterObjBuilding;
_defenders = [waterObjBuilding] call AW_fnc_underwaterBuildingDefenders;
_c4Message = ["The charge has been set! 30 seconds until detonation.","The c4 has been set! 30 seconds until detonation.","The charge is set! 30 seconds until detonation."] call BIS_fnc_selectRandom;


//------- POS FOR SECONDARY EXPLOSIONS
_secondary1 = [sideObj, random 30, random 360] call BIS_fnc_relPos;
_secondary2 = [sideObj, random 30, random 360] call BIS_fnc_relPos;
_secondary3 = [sideObj, random 30, random 360] call BIS_fnc_relPos;
_secondary4 = [sideObj, random 50, random 360] call BIS_fnc_relPos;
_secondary5 = [sideObj, random 70, random 360] call BIS_fnc_relPos;

// Hints and Notifications -------------------------

	_fuzzyPos = [((_randomPos select 0) - 300) + (random 600),((_randomPos select 1) - 300) + (random 600),0];
	{ _x setMarkerPos _fuzzyPos; } forEach ["sideMarker", "sideCircle"];
	sideMarkerText = "Underwater Demolitions";
	"sideMarker" setMarkerText "Side Mission: Underwater Demolitions";
    [west,["underWaterTask"],["OPFOR have setup an underwater outpost. We need you to get out to it and destroy anything of value inside of it","Side Mission: Underwater Demolitions","sideCircle"],(getMarkerPos "sideCircle"),0,0,true,"underWaterMission",true] call BIS_fnc_taskCreate;
	sideMarkerText = "Underwater Demolitions";

{_x addCuratorEditableObjects [(_underwaterBaddies), true]; } foreach allCurators;
{_x addCuratorEditableObjects [(_defenders), true]; } foreach allCurators;
{_x addCuratorEditableObjects [(_buildingToDelete), true]; } foreach allCurators;
sideMissionUp = true;
SM_SUCCESS = false;

while { sideMissionUp } do {

		sleep 0.3;

	//----------------------------------------------------- IF HQ IS DESTROYED [FAIL]

	if (!alive sideObj || !missionActive) exitWith {

		//-------------------- DE-BRIEFING

        ["underWaterTask", "Failed",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["underWaterTask",west] call bis_fnc_deleteTask;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];

		//-------------------- DELETE

		_object setPos [-10000,-10000,0];			// hide objective
		sleep 120;
		{
			deleteVehicle _x;
		} foreach _underwaterBaddies;
		{
			deleteVehicle _x;
		} foreach _defenders;
		{ deleteVehicle _x } forEach _buildingToDelete;
		sideMissionUp = false;
	};

	//------------------------------------------------------ IF WEAPONS ARE DESTROYED [SUCCESS]

	if (SM_SUCCESS || !missionActive) exitWith {

		//-------------------- BOOM!


		sleep 30;											// ghetto bomb timer
		"Bo_GBU12_LGB" createVehicle getPos _object; 		// default "Bo_Mk82"
		sleep 0.1;
		_object setPos [-10000,-10000,0];					// hide objective

		//-------------------- DE-BRIEFING

		[] call AW_fnc_SMhintSUCCESS;
        ["underWaterTask", "Succeeded",true] call BIS_fnc_taskSetState;
        sleep 5;
        ["underWaterTask",west] call bis_fnc_deleteTask;
		{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["sideMarker", "sideCircle"];

		//--------------------- SECONDARY EXPLOSIONS, create a function for this?

		sleep 10 + (random 10);
		"SmallSecondary" createVehicle _secondary1;
		"SmallSecondary" createVehicle _secondary2;
		sleep 5 + (random 5);
		"SmallSecondary" createVehicle _secondary3;
		sleep 2 + (random 2);
		"SmallSecondary" createVehicle _secondary4;
		"SmallSecondary" createVehicle _secondary5;

		//--------------------- DELETE, DESPAWN, HIDE and RESET

		sleep 120;
		{
			deleteVehicle _x;
		} foreach _underwaterBaddies;
		{
			deleteVehicle _x;
		} foreach _defenders;
		{ deleteVehicle _x } forEach _buildingToDelete;
		sideMissionUp = false;
	};
};
