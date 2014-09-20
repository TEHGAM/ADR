/*
Created by =BTC= Giallustio

Visit us at: 
http://www.blacktemplars.altervista.org/
06/03/2012
*/
//Functions
BTC_assign_actions =
{
	player addAction [("<t color=""#ED2744"">") + ("Drag") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_drag], 8, true, true, "", "[] call BTC_check_action_drag"];
	player addAction [("<t color=""#ED2744"">") + ("Pull out injured") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_pull_out], 8, true, true, "", "[] call BTC_pull_out_check"];
	player addAction [("<t color=""#ED2744"">") + ("Carry") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_carry], 8, true, true, "", "[] call BTC_check_action_drag"];
};
BTC_get_gear =
{
	private ["_array_mag","_id","_display_name","_count","_array_class","_array_bullet","_array_class_x","_array_bullet_x","_r_mag_d","_h_mag_d","_brack"];
	_gear = [];
	_weapons = [];
	_prim_weap = primaryWeapon player;
	_prim_items = primaryWeaponItems player;
	_sec_weap = secondaryWeapon player;
	_sec_items = secondaryWeaponItems player;
	_items_assigned = assignedItems player;
	_handgun = handgunWeapon player;
	_handgun_items = handgunItems player;
	if (_prim_weap != "") then {_weapons = _weapons + [_prim_weap]};
	if (_sec_weap != "") then {_weapons = _weapons + [_sec_weap]};
	if (_handgun != "") then {_weapons = _weapons + [_handgun]};
	_goggles = goggles player;
	_headgear = headgear player;
	_uniform = uniform player;
	_uniform_items = uniformItems player;
	_vest = vest player;
	_vest_items = vestItems player;
	_back_pack = backpack player;
	_back_pack_items = backpackItems player;
	_back_pack_weap = getWeaponCargo (unitBackpack player);
	_weap_sel = currentWeapon player;
	_weap_mode = currentWeaponMode player;
	_fire_mode_array = getArray (configFile >> "cfgWeapons" >> _weap_sel >> "modes");
	_fire_mode = _fire_mode_array find _weap_mode;

	_magazinesAmmoFull = magazinesAmmoFull player;
	_mag_uniform = [];_mag_vest = [];_mag_back = [];_mag_loaded_prim = [];_mag_loaded_sec = [];_mag_loaded_at = [];
	{
		if !(_x select 2) then
		{
			switch (true) do
			{
				case ((_x select 4) == "Vest" && ((_x select 3) != 0) && (getNumber(configFile >> "cfgMagazines" >> (_x select 0) >> "count") > 1))     : {_mag_vest = _mag_vest + [[(_x select 0),(_x select 1)]]};
				case ((_x select 4) == "Uniform" && ((_x select 3) != 0) && (getNumber(configFile >> "cfgMagazines" >> (_x select 0) >> "count") > 1))  : {_mag_uniform = _mag_uniform + [[(_x select 0),(_x select 1)]]};
				case ((_x select 4) == "Backpack" && ((_x select 3) != 0) && (getNumber(configFile >> "cfgMagazines" >> (_x select 0) >> "count") > 1)) : {_mag_back = _mag_back + [[(_x select 0),(_x select 1)]]};
			};
		}
		else
		{
			switch (true) do
			{
				case ((_x select 3) == 1)  : {_mag_loaded_prim = [(_x select 0),(_x select 1)]};
				case ((_x select 3) == 2)  : {_mag_loaded_sec = [(_x select 0),(_x select 1)]};
				case ((_x select 3) == 4) : {_mag_loaded_at = [(_x select 0),(_x select 1)]};
			};			
		};
	} foreach _magazinesAmmoFull;
	_ammo = [_mag_loaded_prim,_mag_loaded_sec,_mag_loaded_at,_mag_uniform,_mag_vest,_mag_back];
	_gear =
	[
		_uniform,
		_vest,
		_goggles,
		_headgear,
		_back_pack,
		_back_pack_items,
		_back_pack_weap,
		_weapons,
		_prim_items,
		_sec_items,
		_handgun_items,
		_items_assigned,
		_uniform_items,
		_vest_items,
		_weap_sel,
		_fire_mode,
		_ammo
	];
	//diag_log text format ["------------------------------------------",""];
	//{diag_log text format ["%1",_x]} foreach _gear;
	//diag_log text format ["------------------------------------------",""];
	_gear
};
BTC_set_gear =
{
	/*_gear =
	[
		_uniform,0
		_vest,1
		_goggles,2
		_headgear,3
		_back_pack,4
		_back_pack_items,5
		_back_pack_weap,6
		_weapons,7
		_prim_items,8
		_sec_items,9
		_handgun_items,10
		_items_assigned,11
		_uniform_items,12
		_vest_items,13
		_weap_sel,14
		_fire_mode,15
		_ammo
	];*/
	_unit = _this select 0;
	_gear = _this select 1;
	_id = 0;
	//{diag_log text format ["Gear (ID: %1) = %2",_id,_x];_id = _id + 1;} foreach _gear;
	removeAllweapons _unit;
	removeuniform _unit;
	removevest _unit;
	removeheadgear _unit;
	removegoggles _unit;
	removeBackPack _unit;
	{_unit removeItem _x} foreach (items _unit);
	{_unit unassignItem _x;_unit removeItem _x} foreach (assignedItems _unit);
	////////////////////////
	if ((_gear select 0) != "") then {_unit addUniform (_gear select 0);};
	if ((_gear select 1) != "") then {_unit addVest (_gear select 1);};
	_unit addBackpack "B_AssaultPack_blk"; 
	if (count (_gear select 11) > 0) then {{if (_x != "" && _x != "Binocular" && _x != "Rangefinder" && _x != "Laserdesignator") then {_unit addItem _x;_unit assignItem _x;sleep 0.01;};} foreach (_gear select 11);};

	_ammo = _gear select 16;
	if (count (_ammo select 0) > 0) then {_unit addMagazine (_ammo select 0)};
	if (count (_ammo select 1) > 0) then {_unit addMagazine (_ammo select 1)};
	if (count (_ammo select 2) > 0) then {_unit addMagazine (_ammo select 2)};
	
	{if (isClass (configFile >> "cfgWeapons" >> _x)) then {_unit addweapon _x;};} foreach (_gear select 7);	
	
	removeBackPack _unit;
	if ((_gear select 4) != "") then {_unit addBackPack (_gear select 4);clearAllItemsFromBackpack _unit;};	
	
	//mags
	_u_cont = (uniformContainer _unit);
	_v_cont = (vestContainer _unit);	
	
	{_unit addMagazine _x;} foreach (_ammo select 3);
	{if (!(isClass (configFile >> "cfgMagazines" >> _x))) then {_unit addItem _x;} else {if (getNumber(configFile >> "cfgMagazines" >> _x >> "count") < 2) then {_unit addMagazine _x;};};sleep 0.1;} foreach (_gear select 12);

	if (!isnull _u_cont) then {_u_cont addItemCargo ["itemWatch",50];};
	
	{_unit addMagazine _x;} foreach (_ammo select 4);
	{if (!(isClass (configFile >> "cfgMagazines" >> _x))) then {_unit addItem _x;} else {if (getNumber(configFile >> "cfgMagazines" >> _x >> "count") < 2) then {_unit addMagazine _x;};};sleep 0.1;} foreach (_gear select 13);
	
	if (!isnull _v_cont) then {_v_cont addItemCargo ["itemWatch",300];};
	
	{_unit addMagazine _x;} foreach (_ammo select 5);
	
	{if (!(isClass (configFile >> "cfgMagazines" >> _x))) then {_unit addItem _x;} else {if (getNumber(configFile >> "cfgMagazines" >> _x >> "count") < 2) then {_unit addMagazine _x;};};sleep 0.1;} foreach (_gear select 5);
	
	if (!isnull _u_cont) then {for "_i" from 1 to 50 do {_unit removeItemFromUniform "itemWatch";};};
	if (!isnull _v_cont) then {for "_i" from 1 to 300 do {_unit removeItemFromVest "itemWatch";};};		
	
	if ((_gear select 2) != "") then {_unit addGoggles (_gear select 2);};
	if ((_gear select 3) != "") then {_unit addHeadgear (_gear select 3);};
	if (count ((_gear select 6) select 0) > 0) then 
	{
		for "_i" from 0 to (count ((_gear select 6) select 0) - 1) do
		{
			(unitBackpack _unit) addweaponCargoGlobal [((_gear select 6) select 0) select _i,((_gear select 6) select 1) select _i];
		};			
	};
	removeAllPrimaryWeaponItems _unit;
	if (count (_gear select 8) > 0) then {{if (_x != "") then {_unit addPrimaryWeaponItem _x;};} foreach (_gear select 8);};
	if (count (_gear select 9) > 0) then {{if (_x != "") then {_unit addSecondaryWeaponItem _x;};} foreach (_gear select 9);};
	if (count (_gear select 10) > 0) then {{if (_x != "") then {_unit addHandgunItem _x;};} foreach (_gear select 10);};
	_unit selectweapon (_gear select 14);
	if ((_gear select 15) != -1) then {player action ["SWITCHWEAPON", player, player, (_gear select 15)];};
};
BTC_fnc_handledamage =
{
	_player = _this select 0;
	_damage = _this select 2;
	_in_veh = false;
	if (format ["%1", _player getVariable "BTC_need_revive"] == "0") then
	{
		if (vehicle player != player && ((getDammage (vehicle player)) > 0.9)) then 
		{
			unAssignVehicle player;
			player action ["eject", vehicle player];
			_in_veh = true;
		};
		if (((_damage + getDammage player) > 0.9 || _in_veh) && !(BTC_r_loop) && player getVariable "BTC_need_revive" == 0) then {player setDamage 0.6;_spawn = [] spawn BTC_fnc_wait_for_revive;0} else {_damage};
	} else {0};
};
BTC_fnc_wait_for_revive =
{
	if (player getVariable "BTC_need_revive" == 0 && !BTC_r_loop) then 
	{
		_fatigue = getFatigue player;
		player setFatigue 0.8;
		player setBleedingRemaining 2;
		BTC_r_loop = true;
		player setVariable ["BTC_need_revive",1,true];
		player setDamage 0.8;
		player allowDamage false;
		player setcaptive true;
		_unit = player;
		_pos = getPos player;
		if (vehicle player != player) then 
		{
			unAssignVehicle player;
			player action ["eject", vehicle player];
			sleep 0.1;
		};
		player switchMove "AinjPpneMstpSnonWrflDnon";
		

		BTC_killed_pveh = [2,_unit];publicVariable "BTC_killed_pveh";
		//BTC_marker_pveh = [0,BTC_side,_pos,_unit];publicVariable "BTC_marker_pveh";
		
		player setDamage 0.8;
		player switchMove "AinjPpneMstpSnonWrflDnon";
		WaitUntil {animationstate player == "AinjPpneMstpSnonWrflDnon"};
		//player enableSimulation false;
		BTC_r_timeout = time + BTC_revive_time_max;
		BTC_respawn_cond = false;
		disableSerialization;
		_dlg = createDialog "BTC_respawn_button_dialog";
		player switchMove "AinjPpneMstpSnonWrflDnon";
		BTC_gear = [player] call BTC_get_gear;
		while {Alive player && getDammage player >= 0.26 && time < BTC_r_timeout} do
		{
			if (!Dialog && !BTC_respawn_cond) then {_dlg = createDialog "BTC_respawn_button_dialog";};
			//if (animationstate player != "AinjPpneMstpSnonWrflDnon") then {player switchMove "AinjPpneMstpSnonWrflDnon";};
			_healer = call BTC_check_healer;
			hintSilent format ["%1\n%2", round (BTC_r_timeout - time),_healer];
			if (getDammage player < 0.26 || BTC_respawn_cond) then {closeDialog 0;};
			player setFatigue 0.8;
			player setBleedingRemaining 2;
			sleep 0.1;
		};
		BTC_r_loop = false;
		player enableSimulation true;
		player allowDamage true;
		player setFatigue _fatigue;
		closedialog 0;
		[] spawn {while {dialog} do {closeDialog 0;sleep 0.1;};};
		if (Alive player) then
		{
			if (time > BTC_r_timeout && getDammage player >= 0.26) then 
			{
				[] spawn BTC_player_respawn;
			};
			if (getDammage player < 0.26 && !BTC_respawn_cond) then 
			{
				hintSilent "";
				player setVariable ["BTC_need_revive",0,true];
				player switchMove "AinjPpneMstpSnonWnonDnon_rolltofront";
				closedialog 0;
				sleep 0.5;
				player playMove "amovppnemstpsraswrfldnon";
				[] spawn {while {dialog} do {closeDialog 0;sleep 0.1;};};
			};
		};
		player setcaptive false;
	};
};
BTC_check_healer =
{
	_pos = getpos player;
	_men = [];_veh = [];_dist = 501;_healer = objNull;_healers = [];
	_msg = "No friendly units nearby.";
	_men = nearestObjects [_pos, ["Man"], 500];
	_veh = nearestObjects [_pos, ["LandVehicle", "Air", "Ship"], 500];
	{
		{private ["_man"];_man = _x;if (isPlayer _man && ({_man isKindOf _x} count ["Man"]) > 0) then {_men = _men + [_man];};} foreach crew _x;
	} foreach _veh;
	if (count _men > 0) then
	{
		{if (Alive _x && format ["%1",_x getVariable "BTC_need_revive"] != "1" && isPlayer _x && side _x == BTC_side) then {_healers = _healers + [_x];};} foreach _men;
		if (count _healers > 0) then
		{
			{
				if (_x distance _pos < _dist) then {_healer = _x;_dist = _x distance _pos;};
			} foreach _healers;
			if !(isNull _healer) then {_msg = format ["%1 could heal you! He is %2 m away!", name _healer,round(_healer distance _pos)];};
		};
	};
	_msg
};
BTC_player_respawn =
{
	_body = player;
	BTC_respawn_cond = true;
	player setdamage 1;
	deleteVehicle _body;
	hintSilent "";
	titleText ["", "BLACK FADED"];
	[] spawn
	{
		WaitUntil {Alive player};
		player setcaptive false;
		deTach player;
		player setVariable ["BTC_need_revive",0,true];
		closeDialog 0;
		sleep 0.2;
		_gear = [player,BTC_gear] spawn BTC_set_gear;
		titleText ["", "BLACK FADED"];
		if (vehicle player != player) then {unAssignVehicle player;player action ["eject", vehicle player];};
		player setPos getMarkerPos BTC_respawn_marker;
		sleep 1;
		closeDialog 0;
		player setDamage 0;
		player switchMove "";
		closeDialog 0;
		sleep 0.1;
		BTC_respawn_cond = false;
		titleText ["", "BLACK IN"];
		sleep 2;
		titleText ["", "PLAIN"];
	};
};
BTC_drag =
{
	private ["_injured"];
	_men = nearestObjects [player, ["Man"], 2];
	if (count _men > 1) then {_injured = _men select 1;};
	if (format ["%1",_injured getVariable "BTC_need_revive"] != "1") exitWith {};
	BTC_dragging = true;
	_injured setVariable ["BTC_dragged",1,true];
	_injured attachTo [player, [0, 1.1, 0.092]];
	player playMoveNow "AcinPknlMstpSrasWrflDnon";
	_id = player addAction [("<t color=""#ED2744"">") + ("Drop") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_release], 9, true, true, "", "true"];
	//_injured playMoveNow "AinjPpneMstpSnonWrflDb_grab";
	BTC_drag_pveh = [1,_injured];publicVariable "BTC_drag_pveh";
	WaitUntil {!Alive player || ((animationstate player == "acinpknlmstpsraswrfldnon") || (animationstate player == "acinpknlmwlksraswrfldb"))};
	private ["_act","_veh_selected","_array","_array_veh","_name_veh","_text_action","_action_id"];
	_act = 0;_veh_selected = objNull;_array_veh = [];
	while {!isNull player && alive player && !isNull _injured && alive _injured && format ["%1", _injured getVariable "BTC_need_revive"] == "1" && BTC_dragging} do
	{
		_array = nearestObjects [player, ["Air","LandVehicle"], 5];
		_array_veh = [];
		{if (_x emptyPositions "cargo" != 0) then {_array_veh = _array_veh + [_x];};} foreach _array;
		if (count _array_veh == 0) then {_veh_selected = objNull;};
		if (count _array_veh > 0 && _veh_selected != _array_veh select 0) then 
		{
			_veh_selected    = _array_veh select 0;
			_name_veh        = getText (configFile >> "cfgVehicles" >> typeof _veh_selected >> "displayName");
			_text_action     = ("<t color=""#ED2744"">" + "Load wounded in " + (_name_veh) + "</t>");
			_action_id = player addAction [_text_action,"scripts\=BTC=_revive\=BTC=_addAction.sqf",[[_injured,_veh_selected],BTC_load_in], 7, true, true];
			_act  = 1;
		};
		if (count _array_veh == 0 && _act == 1) then {player removeAction _action_id;_act = 0;};
		sleep 0.1;
	};
	if (_act == 1) then {player removeAction _action_id;};
	player playMoveNow "AmovPknlMstpSrasWrflDnon";
	_injured setVariable ["BTC_dragged",0,true];
	if (format ["%1",_injured getVariable "BTC_need_revive"] == "1") then {detach _injured;_injured playMoveNow "AinjPpneMstpSnonWrflDb_release";};
	detach _injured;
	player removeAction _id;
	BTC_dragging = false;
};
BTC_carry =
{
	private ["_injured"];
	_men = nearestObjects [player, ["Man"], 2];
	if (count _men > 1) then {_injured = _men select 1;};
	if (format ["%1",_injured getVariable "BTC_need_revive"] != "1") exitWith {};
	BTC_dragging = true;
	_healer = player;
	_injured setVariable ["BTC_dragged",1,true];
	detach _injured;
	player playMoveNow "acinpknlmstpsraswrfldnon_acinpercmrunsraswrfldnon";
	_id = player addAction [("<t color=""#ED2744"">") + ("Drop") + "</t>","scripts\=BTC=_revive\=BTC=_addAction.sqf",[[],BTC_release], 9, true, true, "", "true"];
	BTC_carry_pveh = [5,_injured,_healer];publicVariable "BTC_carry_pveh";
	WaitUntil {!Alive player || ((animationstate player == "acinpercmstpsraswrfldnon") || (animationstate player == "acinpercmrunsraswrfldf") || (animationstate player == "acinpercmrunsraswrfldr") || (animationstate player == "acinpercmrunsraswrfldl"))};
	_injured attachto [player,[0.15, 0.15, 0]];_injured setDir 180;
	private ["_act","_veh_selected","_array","_array_veh","_name_veh","_text_action","_action_id"];
	_act = 0;_veh_selected = objNull;_array_veh = [];
	while {!isNull player && alive player && !isNull _injured && alive _injured && format ["%1", _injured getVariable "BTC_need_revive"] == "1" && BTC_dragging} do
	{
		_array = nearestObjects [player, ["Air","LandVehicle"], 5];
		_array_veh = [];
		{if (_x emptyPositions "cargo" != 0) then {_array_veh = _array_veh + [_x];};} foreach _array;
		if (count _array_veh == 0) then {_veh_selected = objNull;};
		if (count _array_veh > 0 && _veh_selected != _array_veh select 0) then 
		{
			_veh_selected    = _array_veh select 0;
			_name_veh        = getText (configFile >> "cfgVehicles" >> typeof _veh_selected >> "displayName");
			_text_action     = ("<t color=""#ED2744"">" + "Load wounded in " + (_name_veh) + "</t>");
			_action_id = player addAction [_text_action,"scripts\=BTC=_revive\=BTC=_addAction.sqf",[[_injured,_veh_selected],BTC_load_in], 7, true, true];
			_act  = 1;
		};
		if (count _array_veh == 0 && _act == 1) then {player removeAction _action_id;_act = 0;};
		sleep 0.1;
	};
	if (_act == 1) then {player removeAction _action_id;};
	player playAction "released";
	_injured switchMove "AinjPfalMstpSnonWrflDnon_carried_down";
	BTC_carry_pveh = [6,_injured];publicVariable "BTC_carry_pveh";
	detach _injured;
	_injured setVariable ["BTC_dragged",0,true];
	player removeAction _id;
	BTC_dragging = false;
};
BTC_release =
{
	BTC_dragging = false;
};
BTC_load_in =
{
	_injured = _this select 0;
	_veh     = _this select 1;
	BTC_dragging = false;
	BTC_load_pveh = [3,_injured,_veh];publicVariable "BTC_load_pveh";
};
BTC_pull_out =
{
	_array = nearestObjects [player, ["Air","LandVehicle"], 5];
	_array_injured = [];
	if (count _array != 0) then
	{
		{
			if (format ["%1",_x getVariable "BTC_need_revive"] == "1") then {_array_injured = _array_injured + [_x];};
		} foreach crew (_array select 0);
	};
	BTC_pullout_pveh = [4,_array_injured];publicVariable "BTC_pullout_pveh";
};
BTC_pull_out_check =
{
	_cond = false;
	_array = nearestObjects [player, ["Air","LandVehicle"], 5];
	if (count _array != 0) then
	{
		{
			if (format ["%1",_x getVariable "BTC_need_revive"] == "1") then {_cond = true;};
		} foreach crew (_array select 0);
	};
	_cond
};
BTC_check_action_drag =
{
	_cond = false;
	_men = nearestObjects [vehicle player, ["Man"], 2];
	if (count _men > 1) then
	{
		if (format ["%1", (_men select 1) getVariable "BTC_need_revive"] == "1" && !BTC_dragging && format ["%1", (_men select 1) getVariable "BTC_dragged"] != "1") then {_cond = true;};
	};
	_cond
};
BTC_3d_markers =
{
	_3d = addMissionEventHandler ["Draw3D",
	{
		{
			if (((_x distance player) < BTC_3d_distance) && (format ["%1", _x getVariable "BTC_need_revive"] == "1")) then
			{
				drawIcon3D["a3\ui_f\data\map\MapControl\hospital_ca.paa",BTC_3d_icon_color,_x,BTC_3d_icon_size,BTC_3d_icon_size,0,format["%1 (%2m)", name _x, ceil (player distance _x)],0,0.02];
			};
		} foreach playableUnits;//playableUnits
	}];
};
BTC_fnc_PVEH =
{
	_array = _this select 1;
	_type  = _array select 0;
	switch (true) do
	{
		case (_type == 0) : 
		{
			_side = _array select 1;
			_unit = _array select 3;
			if (_side == BTC_side) then 
			{
				_pos = _array select 2;
				_marker = createmarkerLocal [format ["FA_%1", _pos], _pos];
				format ["FA_%1", _pos] setmarkertypelocal "mil_box";
				format ["FA_%1", _pos] setMarkerTextLocal format ["F.A. %1", name _unit];
				format ["FA_%1", _pos] setmarkerColorlocal "ColorGreen";
				format ["FA_%1", _pos] setMarkerSizeLocal [0.3, 0.3];
				[_pos,_unit] spawn
				{
					_pos  = _this select 0;
					_unit = _this select 1;
					while {(!(isNull _unit) && (format ["%1", _unit getVariable "BTC_need_revive"] == "1"))} do
					{
						format ["FA_%1", _pos] setMarkerPosLocal getpos _unit;
						sleep 1;
					};
					deleteMarker format ["FA_%1", _pos];
				};
			};
		};
		case (_type == 1) : {(_array select 1) setDir 180;(_array select 1) playMoveNow "AinjPpneMstpSnonWrflDb_grab";};
		case (_type == 2) : 
		{
			private ["_injured"];
			_injured = (_array select 1);
			[_injured] spawn
			{
				_injured = _this select 0;
				_injured allowDamage false;
				_injured setCaptive true;
				WaitUntil {sleep 1; (isNull _injured) || (format ["%1", _injured getVariable "BTC_need_revive"] == "0")};
				_injured allowDamage true;
				_injured setCaptive false;
			};
		};
		case (_type == 3) : 
		{
			private ["_injured","_veh"];
			_injured = (_array select 1);
			_veh     = (_array select 2);
			if (name _injured == name player) then {_injured moveInCargo _veh};
		};
		case (_type == 4) : 
		{
			private ["_array_injured"];
			_array_injured = (_array select 1);
			{
				if (name player == name _x) then {unAssignVehicle player;player action ["eject", vehicle player];_spawn = [] spawn {sleep 0.5;player switchMove "ainjppnemstpsnonwrfldnon";};};
			} foreach _array_injured;
		};
		case (_type == 5) : 
		{
			private ["_array_injured"];
			_spawn = [(_array select 1),(_array select 2)] spawn
			{
				_injured = _this select 0;
				_healer  = _this select 1;
				_injured setPos (_healer modelToWorld [0,1,0]);				
				_injured setDir (getDir _healer + 180);
				_injured switchMove "AinjPfalMstpSnonWnonDnon_carried_up";
				WaitUntil {!Alive _healer || ((animationstate _healer == "acinpercmstpsraswrfldnon") || (animationstate _healer == "acinpercmrunsraswrfldf") || (animationstate _healer == "acinpercmrunsraswrfldr") || (animationstate _healer == "acinpercmrunsraswrfldl"))};
				_injured switchMove "AinjPfalMstpSnonWnonDf_carried_dead";
				sleep 0.2;
				_injured setDir 180;
			};
		};
		case (_type == 6) : 
		{
			private ["_array_injured"];
			_spawn = [(_array select 1)] spawn
			{
				(_this select 0) switchMove "AinjPfalMstpSnonWrflDnon_carried_down";
				sleep 3;
				if (format ["%1",(_this select 0) getVariable "BTC_need_revive"] == "1") then {(_this select 0) switchMove "ainjppnemstpsnonwrfldnon";};
			};
		};
		case (_type == 7) : 
		{
			private ["_injured","_cpr_bonus"];
			_injured = _array select 1;
			_cpr_bonus = _array select 2;
			if (name player == _injured) then {BTC_r_timeout = BTC_r_timeout + _cpr_bonus;};
		};
	};
};
BTC_cpr =
{
	private ["_unit","_cpr_bonus","_name"];
	_men = nearestObjects [player, ["Man"], 2];
	if (count _men > 1) then {_unit = _men select 1;};
	if (format ["%1",_unit getVariable "BTC_need_revive"] != "1") exitWith {};
	closeDialog 0;
	player playMove "AinvPknlMstpSnonWnonDr_medic0";//CPR
	_cpr_bonus = BTC_r_cpr_time / 10;
	_name = name _unit;
	BTC_cpr_pveh = [7,_name,_cpr_bonus];publicVariable "BTC_cpr_pveh";
	sleep 7;
	player playMove "AinvPknlMstpSnonWnonDr_medic0";
	sleep 7;
	if (!isNull _unit && _unit getVariable "BTC_need_revive" == 1 && _unit != player && !BTC_r_loop) then
	{
		_cpr_bonus = BTC_r_cpr_time - (BTC_r_cpr_time / 10);
		BTC_cpr_pveh = [7,_name,_cpr_bonus];publicVariable "BTC_cpr_pveh";
	};
};