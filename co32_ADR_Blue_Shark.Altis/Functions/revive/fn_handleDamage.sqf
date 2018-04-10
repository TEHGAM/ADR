player addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "_source", "_projectile", "_index","_instigatorobj"];

    private _maxSafeDamage = getMissionConfigValue ["derp_revive_maxSafeDamage", 0.95];
    private _downedDamageTreshold = getMissionConfigValue ["derp_revive_downedDamageTreshold", 1.5];
    private _damageReturned = 0;

    if (alive _unit) then {
        // If the unit is inside a dead vehicle, kill it
        if (!isNull objectParent _unit && {!alive vehicle _unit}) exitWith {
            _damageReturned = 1;
			if (isPlayer _source) then {
				[_unit,_source,_projectile,_instigatorobj] remoteExec ["AW_fnc_killMessage", 2 ,false]
			};
            forceRespawn _unit;
        };

        // Handles the source of the damage
        if (isNull _source) then {
            _source = missionNamespace getVariable ["derp_revive_lastDamageSource",objNull];
        } else {
            derp_revive_lastDamageSource = _source;
        };

        if (_index > -1) then {
            if (_damage < 0.1) then {
                _damageReturned = (_unit getHit _selection) min _maxSafeDamage;

            } else {

                // Kill the unit if it's alive and received damage above the treshold
                if (_damage >= _downedDamageTreshold  && {alive _unit}) then {
                    _damageReturned = 1;
                    _unit setVariable ["derp_revive_loadout", getUnitLoadout _unit];
                    forceRespawn _unit;
                    [_source] call bis_fnc_reviveAwardKill;
					if (isPlayer _source) then {
						[_unit,_source,_projectile,_instigatorobj] remoteExec ["AW_fnc_killMessage", 2 ,false]
						};

                } else {
                    // Check if the damage received is above the vanilla death treshold
                    if (_damage >= 1 && {!(_unit getVariable ["derp_revive_downed", false])}) then {
                        _damageReturned = 0.95;

						if (isPlayer _source) then {
							[_unit,_source,_projectile,_instigatorobj] remoteExec ["AW_fnc_killMessage", 2 ,false]
						};
						
						
                        // Check if the player is on foot and above water, if so put it into downed state
                        if (vehicle _unit == _unit && {(getPosASL _unit) select 2 > 0}) then {
                            _unit setUnconscious true;
                            [_unit, "DOWNED"] call derp_revive_fnc_switchState;
                            cutText ["","BLACK", 1];
                            _unit allowDamage false;

                        } else {

							if (isPlayer _source) then {
								[_unit,_source,_projectile,_instigatorobj] remoteExec ["AW_fnc_killMessage", 2 ,false]
                            };
							
                            // If the unit is under water kill it
                            if (vehicle _unit == _unit && {(getPosASL _unit) select 2 < 0}) then {
                                _damageReturned = 1;
                                _unit setVariable ["derp_revive_loadout", getUnitLoadout _unit];
                                forceRespawn _unit;
                                [_source] call bis_fnc_reviveAwardKill;

                            } else {
								
								if (isPlayer _source) then {
									[_unit,_source,_projectile,_instigatorobj] remoteExec ["AW_fnc_killMessage", 2 ,false]
                                };
								
                                // Check if the vehicle is inside a vehicle, and if that vehicle ejects dead corpses (like the quadbike), in that case kill the unit
                                private _seat = ((fullCrew vehicle _unit) select {_x select 0 == _unit}) select 0;

                                if ( (_seat select 1 == "driver" && {getNumber (configFile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "ejectDeadDriver") == 1}) || {(_seat select 1 in ["cargo", "turret", "gunner"]) && {getNumber (configFile >> "CfgVehicles" >> typeOf (vehicle _unit) >> "ejectDeadCargo") == 1}} || {(getPosASL _unit) select 2 < 0}) then {
                                    _damageReturned = 1;
                                    _unit setVariable ["derp_revive_loadout", getUnitLoadout _unit];
                                    forceRespawn _unit;
                                    [_source] call bis_fnc_reviveAwardKill;

                                } else {
                                    [_unit, "DOWNED"] call derp_revive_fnc_switchState;
                                    cutText ["","BLACK", 1];
                                    _unit allowDamage false;
									if (isPlayer _source) then {
										[_unit,_source,_projectile,_instigatorobj] remoteExec ["AW_fnc_killMessage", 2 ,false]
                                    };
                                };
                            };
                        };
                    } else {
                        _damageReturned = _maxSafeDamage min _damage;
                    };
                };
            };
        };
    };

    _damageReturned
}];
