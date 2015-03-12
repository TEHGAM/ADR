_vehicle = _this select 0;

_pitchBank = {
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

_check = _vehicle getVariable "sling_attached";
if(isNil "_check") then {_vehicle setVariable ["sling_attached",false,false]};
if(isNil "sling_cameraOn") then {sling_cameraOn = false};

_vehicle addAction ["<t color='#FF0000'>" + "Sling Rope Attach" + "</t>","scripts\vehicle\sling\sling_attach.sqf",[],21,true,true,"","(_this == driver _target) AND (count ((getPos _target) nearEntities [['Car','Motorcycle','Tank','ship'],10]) > 0) AND !(_target getVariable 'sling_attached')"];
_vehicle addAction ["<t color='#FF0000'>" + "Sling Rope Detach" + "</t>","scripts\vehicle\sling\sling_detach.sqf",[],21,true,true,"","(_this == driver _target) AND (_target getVariable 'sling_attached')"];
_vehicle addAction ["<t color='#FF0000'>" + "Toggle Sling Camera" + "</t>","scripts\vehicle\sling\sling_toggleDisplay.sqf",[],-98,false,false,"","(_this == driver _target)"];

//camera stuff (only visible to pilot (hopefully));
_camera = "camera" camcreate [0,0,0];

_minZ = (((boundingBox _vehicle) select 0) select 2) - 1;
_midY = (((boundingBox _vehicle) select 1) select 1) / 3;
_attachPoint = [0,_midY,_minZ + 1.5];

_camera attachTo [_vehicle, _attachPoint];
[_camera,-90,0] call _pitchBank;

_camera camSetFOV 2;
_camera camCommit 0;
_camera camCommitPrepared 0;
_vehicle setVariable ["sling_camera",_camera,false];

[_vehicle] execVM "scripts\vehicle\sling\sling_monitor.sqf";
[_vehicle] execVM "scripts\vehicle\sling\sling_monitorPlayer.sqf";