private ["_iampilot"];

//=========================== PILOTS ONLY
_pilots = ["B_soldier_repair_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;

if (_iampilot) then {
	//===== HELI TURRETS LOCK
	player addAction ["<t color='#FF9800'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Разрешить стрельбу</t>", QS_fnc_uh80TurretActions, [0], -95, false, false, '', '[] call QS_fnc_conditionUH80TurretActionUnlock'];
	player addAction ["<t color='#FF9800'><img image='\a3\ui_f\data\map\VehicleIcons\iconhelicopter_ca.paa' size='1.0'/> Запретить стрельбу</t>", QS_fnc_uh80TurretActions, [1], -95, false, false, '', '[] call QS_fnc_conditionUH80TurretActionLock'];
};

//====================== Clear vehicle inventory
inventory_cleared = false;
player addAction ["<t color='#2196F3'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_toolbox_modules_ca.paa' size='1.0'/> Освободить грузоотсек</t>", QS_fnc_actionClearInventory, [], -96, false, false, '', '[] call QS_fnc_conditionClearInventory'];

//====================== DOM_SQUAD
if (!isDedicated) then
{
  player addAction [
    ("<t color='#04cc6b'><img image='\a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_toolbox_groups_ca.paa' size='1.0'/> " + localize "STRD_squadm" + "</t>"),
    Compile preprocessFileLineNumbers "scripts\DOM_squad\open_dialog.sqf", [], -97, false
  ];
};
