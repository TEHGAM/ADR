private ["_iampilot", "_btc_tk_prison"];

//=========================== PILOTS ONLY
_pilots = ["B_Helipilot_F", "O_helipilot_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;

if (_iampilot) then {
	//===== HELI TURRETS LOCK
	player addAction ["<t color='#FF9800'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Разрешить стрельбу</t>", QS_fnc_uh80TurretActions, [0], -95, false, false, '', '[] call QS_fnc_conditionUH80TurretActionUnlock'];
	player addAction ["<t color='#FF9800'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Запретить стрельбу</t>", QS_fnc_uh80TurretActions, [1], -95, false, false, '', '[] call QS_fnc_conditionUH80TurretActionLock'];

	//===== FIELD REPAIR
	vehicle_repaired = false;
	player addAction ["<t color='#FF9800'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_debug_ca.paa' size='1.0'/> Полевой ремонт</t>", QS_fnc_actionPilotRepair, [1], 100, false, false, '', '[] call QS_fnc_conditionPilotRepair'];
};

//====================== Clear vehicle inventory
inventory_cleared = false;
player addAction ["<t color='#2196F3'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_toolbox_modules_ca.paa' size='1.0'/> Освободить грузоотсек</t>", QS_fnc_actionClearInventory, [], -96, false, false, '', '[] call QS_fnc_conditionClearInventory'];

//====================== Magazine Repack
player addAction ["<t color='#84FFFF'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargomag_ca.paa' size='1.0'/> " + localize "STR_ADR_MagRepack" + "</t>", QS_fnc_actionMagRepack, [], -97, false, false, ''];

//====================== DOM_SQUAD
if (!isDedicated) then
{
  player addAction [
    ("<t color='#04cc6b'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_toolbox_groups_ca.paa' size='1.0'/> " + localize "STRD_squadm" + "</t>"),
    Compile preprocessFileLineNumbers "scripts\DOM_squad\open_dialog.sqf", [], -98, false
  ];
};

//====================== Prison check
if (!isDedicated) then {
    _btc_tk_prison = profileNamespace getVariable ["btc_tk_prison", 0];
    if (_btc_tk_prison > 0) then {
        _tk = [] spawn BTC_Teamkill;
    };
};

//====================== Rules check
if (!isDedicated) then {
    _uid = getPlayerUID player;
    _rules = missionNamespace getVariable ["TEHGAM_RULES",[]];
    if (!(_uid in _rules)) then {
        createDialog "tehgam_rules";
    };
};