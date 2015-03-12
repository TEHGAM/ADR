_helo = _this select 0;
_camera = _helo getVariable "sling_camera";
while{alive _helo} do {
	
	waitUntil{sleep 1;(player == driver _helo) AND sling_cameraOn};
	
	BIS_liveFeed = ["rendertarget0",_camera,_helo,true] call BIS_fnc_pip;
	_mode = [_this, 3, 0, [0]] call BIS_fnc_param;
	_mode call BIS_fnc_liveFeedEffects;
	
	disableSerialization;
	waitUntil {!(isNull (uiNamespace getVariable "BIS_fnc_PIP_RscPIP"))};
	_disp = uiNamespace getVariable "BIS_fnc_PIP_RscPIP";
	for "_i" from 12 to 0 step - 1 do 
	{
		private ["_ctrl"];
		_ctrl = _disp displayCtrl (2400 + _i);
		_ctrl ctrlsettext "#(argb,256,256,1)r2t(rendertarget0,1.0)";
	};
	
	waitUntil{!(alive _helo) OR !(player == driver _helo) OR !(alive player) OR !sling_cameraOn};
	_disp = uiNamespace getVariable "BIS_fnc_PIP_RscPIP";
	BIS_liveFeed cameraeffect ["terminate","back"];
	["rendertarget0"] call BIS_fnc_PIP;
	BIS_liveFeed = nil;
};