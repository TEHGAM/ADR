/*
Modified by [LB] chucky to temporarily disable copilot on transport choppers whilst bug 11987 is outstanding
http://feedback.arma3.com/view.php?id=11987

Adapted SaMatra's code published on:
http://forums.bistudio.com/showthread.php?157481-crewmen
*/

true spawn {

    _pilots = ["B_Helipilot_F"];
    _aircraft_nocopilot = ["B_Heli_Transport_01_camo_F", "B_Heli_Transport_01_F", "I_Heli_Transport_02_F", "O_Heli_Light_02_F", "O_Heli_Light_02_unarmed_F", "B_Heli_Light_01_armed_F"];

    waitUntil {player == player};

    _iampilot = ({typeOf player == _x} count _pilots) > 0;

    while { true } do {
        _oldvehicle = vehicle player;
        waitUntil {vehicle player != _oldvehicle};

        if(vehicle player != player) then {
            _veh = vehicle player;

            //------------------------------ pilot can be pilot seat only
			
            if((_veh isKindOf "Helicopter" || _veh isKindOf "Plane") && !(_veh isKindOf "ParachuteBase")) then {
				if(({typeOf _veh == _x} count _aircraft_nocopilot) > 0) then {
					_forbidden = [_veh turretUnit [0]];
					if(player in _forbidden) then {
						systemChat "Co-pilot is disabled on this vehicle";
						player action ["getOut", _veh];
					};
				};
				if(!_iampilot) then {
					_forbidden = [driver _veh];
					if(player in _forbidden) then {
						systemChat "You must be a pilot to fly this aircraft";
						player action ["getOut", _veh];
					};
				};
            };
		};
    };
}; 

