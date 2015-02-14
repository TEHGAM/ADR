//Alex Wise
//Sling loading script
//ArmA 3

_vehicle = _this select 0;

_pitchBank =
{
	private["_obj","_p","_b","_vx","_vy","_vz","_v"];
	 _obj = _this select 0;
	 _p = _this select 1;
	 _b = _this select 2;
	 _obj setVectorUp [0,0.001,0.999];
	 _obj setVectorDir [0,0.999,0.001];
	 _vx = (sin _b) * (cos _p);
	 _vz = -(sin _p);
	 _vy = (cos _b) * (cos _p);
	 _v = [_vx,_vz,_vy];
	 _obj setVectorUp _v;
};

_check = _vehicle getVariable "aw_sling_attached";
if(isNil "_check") then {_vehicle setVariable ["aw_sling_attached",false,false]};
if(isNil "aw_sling_cameraOn") then {aw_sling_cameraOn = false};


// _vehicle addAction ["<t color='#FF0000'>" + "Подцепить" + "</t>","scripts\vehicle\aw_sling\aw_sling_attach.sqf",[],21,true,true,"","(_this == driver _target) AND (count ((getPos _target) nearEntities [['Car','Motorcycle','Tank','ship'],5]) > 0) AND !(_target getVariable 'aw_sling_attached')"];
// _vehicle addAction ["<t color='#FF0000'>" + "Отцепить" + "</t>","scripts\vehicle\aw_sling\aw_sling_detach.sqf",[],21,true,true,"","(_this == driver _target) AND (_target getVariable 'aw_sling_attached')"];
_vehicle addAction ["<t color='#FF0000'>" + "Камера (вкл/выкл)" + "</t>","scripts\vehicle\aw_sling\aw_sling_toggleDisplay.sqf",[],-98,false,true,"","(_this == driver _target)"];
//pilot eject
//_vehicle addAction ["Выпрыгнуть",{player action [ "eject", vehicle player]},[],1,false,true,"","_this in _target"];

//camera stuff (only visible to pilot (hopefully));
_camera = "camera" camcreate [0,0,0];

_minZ = (((boundingBox _vehicle) select 0) select 2) - 1;
_midY = (((boundingBox _vehicle) select 1) select 1) / 3;
_attachPoint = [0,_midY,_minZ + 1.5];

//_dir = getDir _vehicle;
//_vehicle setDir 0;
_camera attachTo [_vehicle, _attachPoint];
[_camera,-90,0] call _pitchBank;
//_vehicle setDir _dir;

_camera camSetFOV 2;
_camera camCommit 0;
_camera camCommitPrepared 0;
_vehicle setVariable ["aw_sling_camera",_camera,false];


[_vehicle] execVM "scripts\vehicle\aw_sling\aw_sling_monitor.sqf";
[_vehicle] execVM "scripts\vehicle\aw_sling\aw_sling_monitorPlayer.sqf";
