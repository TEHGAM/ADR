/*ws_fnc_createCAS
Credit to wolfenswarn 
FEATURE
Creates a CAS run at the given location

USAGE
MinimaL:
[position,direction] call ws_fnc_createCAS

PARAMETERS
1. Center of CAS run (any position)     | MANDATORY
2. Direction for CAS to strafe towards                      | MANDATORY
3. Class of CAS plane to send.                              | OPTIONAL - default is Wipeout
4. Type of CAS run. 0: Guns only. 1: Rockets only. 2: Both. | OPTIONAL - default is 0
[_target,_dir,"O_Plane_CAS_02_F",_run] call AW_fnc_createCas;
RETURNS
true
*/

private ["_pos","_class","_type","_dir","_dummy"];

_pos = (_this select 0);
_dir = (_this select 1);
_class = if (count _this > 2) then {(_this select 2)} else {"B_Plane_CAS_01_F"};
_type = if (count _this > 3) then {(_this select 3)} else {0};

if ((_pos distance (getMarkerPos"respawn_west")) > 1500) then {
	_dummy = "LaserTargetCBase" createVehicle _pos;
	_dummy enableSimulation false; _dummy hideObject true;
	_dummy setVariable ["vehicle",_class];
	_dummy setVariable ["type",_type];
	_dummy setDir _dir;

	[_dummy,nil,true] call BIS_fnc_moduleCAS;

	[_dummy] spawn {
		sleep 10;

		deleteVehicle (_this select 0);
	};
};
true