private ["_iampilot"];

//Client scripts that should execute after respawn.
if (!isDedicated) then
{
  player addAction [
    ("<t color='#04cc6b'>" + localize "STRD_squadm" + "</t>"),
    Compile preprocessFileLineNumbers "scripts\DOM_squad\open_dialog.sqf", [], -97, false
  ];
};

//=========================== PILOTS ONLY
_pilots = ["B_pilot_F", "B_helipilot_F", "B_soldier_repair_F"];
_iampilot = ({typeOf player == _x} count _pilots) > 0;

if (_iampilot) then {
	//===== HELI TURRETS LOCK
	player addAction ["<t color='#FF9800'>&#160;&#160;• Разрешить стрельбу</t>", QS_fnc_uh80TurretActions, [0], -94, false, false, '', '[] call QS_fnc_conditionUH80TurretActionUnlock'];
	player addAction ["<t color='#FF9800'>&#160;&#160;• Запретить стрельбу</t>", QS_fnc_uh80TurretActions, [1], -95, false, false, '', '[] call QS_fnc_conditionUH80TurretActionLock'];
};

//====================== Clear vehicle inventory
inventory_cleared = false;
player addAction ["<t color='#2196F3'>&#160;&#160;• Освободить грузотсек</t>", QS_fnc_actionClearInventory, [], -96, false, false, '', '[] call QS_fnc_conditionClearInventory'];