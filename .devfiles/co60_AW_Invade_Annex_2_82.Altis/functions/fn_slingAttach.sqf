/*
@filename: fn_slingAttach.sqf
Author: 
	
	Quiksilver
	
Last modified:

	28/07/2014 ArmA 1.24 by Quiksilver
	
Description:

	Sling attach vehicle and monitor

__________________________________________________________________________________*/

private [
	"_h","_hType","_nearUnits","_liftable","_hPos","_hVel","_closestUnit","_closestDist","_unit","_unitPos","_unitDist",
	"_closestUnitType","_minZ","_midY","_attachPoint","_wasCollide","_height","_speedHelo"
];

_h = _this select 0;
_hType = vehicle player;
if (getPos _hType select 2 > maxLiftingHeight) exitWith {hintSilent "Too high to sling";};
_nearUnits = (getPos _hType) nearEntities [["LandVehicle","Ship"],maxLiftingDistance];
if (count _nearUnits < 1) exitWith {hintSilent "No sling targets";};
_liftable = [];

if (_hType isKindOf "I_Heli_Transport_02_F") then {_liftable = light + medium + heavy;};
if (_hType isKindOf "B_Heli_Transport_01_F" || _hType isKindOf "B_Heli_Transport_01_camo_F") then {_liftable = light + medium;};
_hPos = getPos _hType;
_hVel = velocity _hType;
_hPos = [(_hPos select 0) + (_hVel select 0), (_hPos select 1) + (_hVel select 1), (_hPos select 2) + (_hVel select 2)];
_closestUnit = nil;
_closestDist = 999;

{
	_unit = _x;
	_unitPos = getPos _unit;
	_unitDist = _unitPos distance _hPos;
	
	if(_unitDist < _closestDist) then {
		_closestUnit = _unit;
		_closestDist = _unitDist;
	};
} count _nearUnits;
_closestUnitType = typeOf _closestUnit;

if (({_closestUnitType == _x} count _liftable) < 1) exitWith {hintSilent "Not liftable";};
_whitelistedCrewVehs = ["B_UGV_01_rcws_F","B_UGV_01_F"];
if (((count (crew _closestUnit)) > 0) && !((typeOf _closestUnit) in _whitelistedCrewVehs)) exitWith {
	hintSilent "Crew in vehicle";
};
if (_closestUnit getVariable "slingable") then {

	//Find sling position

	_minZ = (((boundingBox _hType) select 0) select 2) - 1;
	_midY = (((boundingBox _hType) select 1) select 1) / 3;
	_attachPoint = [0,_midY,_minZ];

	//Attach

	[_closestUnit] call fnWeightParameters;
	_closestUnit attachTo [_hType,_attachPoint];
	_hType setVariable ["sling_attached",true,true];
	_hType setVariable ["sling_object",_closestUnit,true];

	_wasCollide = 0;

	//================================================= MONITOR LOOP

	if (_hType getVariable "sling_attached") then {
		
		while {_hType getVariable "sling_attached"} do {
			
			_minY = (((boundingBox _closestUnit) select 0) select 2);
			_height = (((getPos _closestUnit select 2) + minLiftingHeight) + _minY);

			//================================================= when lifted object is above ground without obstruction
				
			if (_height > 1) then {
				_vel = velocity _hType;
				_velPost = [(_vel select 0) * liftingDampen,(_vel select 1) * liftingDampen,(_vel select 2) - downwardThrust];			
				_hType setVelocity (_velPost);
				sleep 0.1;
			};		
				
			//================================================= when lifted object is below ground
				
			if (_height < 0) then {
			
				_speedHelo = speed _hType;

				// high speed collision - sling breaks
					
					if (_speedHelo > mediumSpeedThreshold) then {
					
					_vel = velocity _hType;
					_velPost = [(_vel select 0) * collisionDampen,(_vel select 1) * collisionDampen,(_vel select 2) - upwardThrust]; 		// violent collision pulls down on the chopper			
					
					detach _closestUnit;
					_closestUnit setVelocity (stationaryVel);
					_closestUnit setPos [getPos _closestUnit select 0,getPos _closestUnit select 1,0];
						
					_hType setVariable ["sling_attached",false,true];
					_hType setVelocity (_velPost);
						
				} else {
					
					// ensure vehicle from going under ground
						
					_closestUnit setPos [getPos _closestUnit select 0,getPos _closestUnit select 1,0];
					
					// medium speed collision - bumpy drag
						
					if (_speedHelo > lowSpeedThreshold) then {
						
						_wasCollide = _wasCollide + 1;
							
						if (_wasCollide > collisionCounter) then {
							
							_vel = velocity _hType;
							_velPost = [(_vel select 0) * collisionDampen,(_vel select 1) * collisionDampen,(_vel select 2) + upwardThrust]; 		//sling breaks causes upward thrust			
							
							detach _closestUnit;
							_closestUnit setVelocity (stationaryVel);
								
							_hType setVariable ["sling_attached",false,true];
							_hType setVelocity (_velPost);
								
						} else {
							
							_vel = velocity _hType;
							_velPost = [(_vel select 0) * collisionDampen,(_vel select 1) * collisionDampen,(_vel select 2) * collisionDampen * bumpiness];			
							_hType setVelocity (_velPost);
								
							sleep 0.1;
								
							_velPost = [(_velPost select 0) * collisionDampen,(_velPost select 1) * collisionDampen,(_velPost select 2) * bumpiness];			
							_hType setVelocity (_velPost);
						};				
					} else {
						
						//================================================= low speed collision - smooth drag
							
						_vel = velocity _hType;
						_velPost = [(_vel select 0) * draggingDampen,(_vel select 1) * draggingDampen,(_vel select 2) * draggingDampen];			
						_hType setVelocity (_velPost);
							
						_closestUnit setVelocity (_velPost);
							
						_wasCollide = 0;
					};
				};
			};
				
			//================================================= when helo or slung-veh is dead
				
			if ((!canMove _hType) || {(!canMove _closestUnit)} || {(player != player)}) then {
				_vel = velocity _hType;
				_velRelease = [_vel select 0,_vel select 1,_vel select 2 + upwardThrust];
				detach _closestUnit;
				_closestUnit setVelocity (_vel);
				_hType setVariable ["sling_attached",false,true];
				_hType setVelocity (_velRelease);
			};
			sleep 0.1;
		};
	};
} else {
	hintSilent "Can't sling this vehicle";
};