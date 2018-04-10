params ["_newUnit", "_corpse", "_respawn", "_respawnDelay"];

[player] call derp_revive_fnc_reviveActions; // Add back the action, since we can't fucking keep it

[_newUnit, "ALIVE"] call derp_revive_fnc_switchState;
