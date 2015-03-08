//------------------------------ CONFIG

_unit = _this select 0;
_type = typeOf _unit;

//---------- UH-80 Ghosthawk

_ghosthawk = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F"];

//---------- Strider

_strider = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];

//---------- Black camo

_blackVehicles = ["B_Heli_Light_01_armed_F"];

// The hummingbird
_wasp = ["B_Heli_Light_01_F","B_Heli_Light_01_armed_F"];

// The orca
_orca = ["O_Heli_Light_02_unarmed_F"];

//---------- Sling

_slingable = ["B_Heli_Light_01_F"];
_notSlingable = ["B_Heli_Light_01_armed_F", "B_Heli_Attack_01_F"];

//---------- VAS-enabled

_VASable = ["B_Truck_01_ammo_F"];

//---------- BOBCAT

_noAmmoCargo = ["B_APC_Tracked_01_CRV_F","B_Truck_01_ammo_F"];

//------------------------------ INITIALIZE VEHICLES

if (isNull _unit) exitWith {};

if (((_unit isKindOf "Helicopter") OR (_type in _slingable)) AND !(_type in _notSlingable)) then {
	[_unit] execVM "scripts\vehicle\sling\sling_setupUnit.sqf"
};

if (_type in _ghosthawk) then {
	[_unit] execVM "scripts\vehicle\animate\ghosthawk.sqf";
	_unit addAction ["<t color='#0000f6'>Ammo Drop</t>", "scripts\vehicle\drop\drop.sqf",[1],0,false,true,"","driver _target == _this"];
	_unit addEventHandler ["Fired", { _this execVM "scripts\vehicle\spreadTurret.sqf"}];  
};

if (_type in _blackVehicles) then {
	for "_i" from 0 to 9 do { _unit setObjectTextureGlobal [_i,"#(argb,8,8,3)color(0,0,0,0.6)"]; };
};

if (_type in _strider) then {
	_unit setObjectTexture [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'];
	_unit setObjectTexture [1,'\A3\data_f\vehicles\turret_co.paa']; 
};

if (_type in _VASable) then { 
	_unit addAction ["<t color='#ff1111'>Mobile VAS</t>","scripts\VAS\open.sqf",[],10,true,true,'((vehicle player) == player) && ((player distance _target) < 5)'];
};


if(_type in _wasp) then {
	_unit setObjectTexture[0, 'A3\Air_F\Heli_Light_01\Data\skins\heli_light_01_ext_digital_co.paa']};

if(_type in _orca) then {_unit setObjectTexture[0, 'A3\Air_F\Heli_Light_02\Data\heli_light_02_ext_indp_co.paa']};

if (_type in _noAmmoCargo) then {_unit setAmmoCargo 0;};

_unit addAction ["<t color='#3f3fff'>Clear Inventory</t>","scripts\vehicle\clear\clear.sqf",[],-97,false];