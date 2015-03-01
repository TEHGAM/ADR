// Original pilotcheck by Kamaradski [AW]. 
// Since then been tweaked by many hands!
// Notable contributors: chucky [allFPS], Quiksilver.

_pilots = ["B_Helipilot_F"];
_aircraft_nocopilot = ["B_Heli_Transport_01_camo_F", "B_Heli_Transport_01_F", "I_Heli_Transport_02_F", "O_Heli_Light_02_F", "O_Heli_Light_02_unarmed_F", "B_Heli_Light_01_armed_F","B_Heli_Transport_03_F"];

waitUntil {player == player};

_iampilot = ({typeOf player == _x} count _pilots) > 0;

/* Remove comments and insert UIDs into the whitelist to exempt individuals from this script
_uid = getPlayerUID player;
_whitelist = ["76561198029008449","76561198058389301","76561198085765221","76561198022163272","76561198039531022","76561198080680196","76561198001522951","76561198054120913","76561198043550034","76561198023528482","76561197961923793","76561198079640023","76561197998355936","76561197983658369","76561198086257618","76561197980032453"];

if (_uid in _whitelist) exitWith {};
*/

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
					if (!_iampilot) then {
						systemChat "Co-pilot is disabled on this vehicle";
						player action ["getOut",_veh];
					};
				};
			};
			if(!_iampilot) then {
				_forbidden = [driver _veh];
				if (player in _forbidden) then {
					systemChat "You must be a pilot to fly this aircraft";
					player action ["getOut", _veh];
				};
			};
		};
	};
};

