waitUntil {!isNull player};

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

Script_Taru =
{
	[] call
	{
		if (isClass(configFile >> "CfgPatches" >> "agm_core")) exitWith {};

		if (isClass(configFile >> "CfgPatches" >> "cba_main")) then
		{
			["XENO Taru Pod Mod", localize "STR_XENO_Arrimer", {["Arrimage"] call Script_Choix_Unite;}, [DIK_A,true,false,false]] call cba_fnc_registerKeybind;
			["XENO Taru Pod Mod", localize "STR_XENO_Desarrimer", {["Desarrimage"] call Script_Choix_Unite;}, [DIK_E,true,false,false]] call cba_fnc_registerKeybind;
			["XENO Taru Pod Mod", localize "STR_XENO_Larguer", {["Largage"] call Script_Choix_Unite;}, [DIK_C,true,false,false]] call cba_fnc_registerKeybind;
		};

		Action_Arrimer = player addAction [localize "STR_XENO_Arrimer", "[""Arrimage"", player] call Script_Choix_Unite;", nil, 2, false, true, "",
		"[player] call Script_Verification_Helico and {[player] call Script_Verification_Pod} and {!([player] call Script_Verification_Objet_Attacher)}"];

		Action_Desarrimer = player addAction [localize "STR_XENO_Desarrimer", "[""Desarrimage"", player] call Script_Choix_Unite;", nil, 2, false, true, "",
		"[player] call Script_Verification_Helico and {[player] call Script_Verification_Pod} and {[player] call Script_Verification_Objet_Attacher}"];

		Action_Larguer = player addAction [localize "STR_XENO_Larguer", "[""Largage"", player] call Script_Choix_Unite;", nil, 2, false, true, "",
		"[player] call Script_Verification_Helico and {[player] call Script_Verification_Pod} and {[player] call Script_Verification_Objet_Attacher}"];
	};

	[] spawn Script_Taru_Hotfix_VRotor;
};

Script_Verification_Objet_Attacher =
{
	_helico = vehicle (_this select 0);
	_objet_Verifier = false;

	[] call
	{
		if (count attachedObjects _helico isEqualTo 0) exitwith {};
		if (count attachedObjects _helico > 0) exitwith {_objet_Verifier = true;};
	};
	_objet_Verifier
};

Script_Verification_Pod =
{
	_pod = getSlingLoad vehicle (_this select 0);
	_pod_Verifier = false;

	_liste_Class_Parent = [(configfile >> "CfgVehicles" >> typeof _pod),true] call BIS_fnc_returnParents;

	{
		if (_x isEqualTo "Pod_Heli_Transport_04_base_F") exitwith {_pod_Verifier = true;};
	} foreach _liste_Class_Parent;
	_pod_Verifier
};

Script_Verification_Helico =
{
	_helicoptere = vehicle (_this select 0);
	_helico_Verifier = false;
	_liste_Class_Parent = [(configfile >> "CfgVehicles" >> typeof _helicoptere),true] call BIS_fnc_returnParents;

	{
		if (_x isEqualTo "Heli_Transport_04_base_F") exitwith {_helico_Verifier = true;};
	} foreach _liste_Class_Parent;
	_helico_Verifier
};

Script_Choix_Unite =
{
	_arrimer_Desarrimer = _this select 0;
	_helicoptere = vehicle player;
	_cables = ropes _helicoptere;
	_unite_Lancant_Script = [];

	if (ropeUnwound (_cables select 0)) then
	{
		[] call
		{
			if (local _helicoptere) exitwith {_unite_Lancant_Script = [player];};

			if (!local _helicoptere) exitwith
			{
				{
					_proprietaire_Vehicule = owner _x;

					if (_proprietaire_Vehicule isEqualTo owner _x) exitwith
					{
						_unite_Lancant_Script = _x;
					};
				} foreach crew _helicoptere;
			};
		};

		[] call
		{
			if (_arrimer_Desarrimer isEqualTo "Desarrimage") exitwith {[[_helicoptere],"Script_Taru_Desarrimer_Pod",_unite_Lancant_Script,false] call BIS_fnc_MP;};
			if (_arrimer_Desarrimer isEqualTo "Arrimage") exitwith {[[_helicoptere],"Script_Taru_Arrimer_Pod",_unite_Lancant_Script,false] call BIS_fnc_MP;};
			if (_arrimer_Desarrimer isEqualTo "Largage") then {[[_helicoptere],"Script_Taru_Larguer_Pod",_unite_Lancant_Script,false] call BIS_fnc_MP;};
		};
	};
};

Script_Taru_Arrimer_Pod =
{
	_helicoptere = vehicle (_this select 0);
	_sans_Son = if (count _this > 1) then {_this select 1} else {false};
	_objet_Heliporter = getSlingLoad _helicoptere;
	_mass_Objet_Heliporter = getmass getSlingLoad _helicoptere;
	_mass_Helicoptere = getmass _helicoptere;
	_poids_Helico = weightRTD _helicoptere;

	
	if (!isTouchingGround _helicoptere) then
	{
		if (!_sans_Son) then {[["Son Arrimage", _helicoptere],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false] spawn BIS_fnc_MP;};
		{ropeUnwind [_x, 1.9, 1];} foreach ropes _helicoptere;

		waituntil {ropeLength (ropes _helicoptere select 0) isEqualTo 1};
	};

	[] call
	{
		_liste_Class_Parent = [(configfile >> "CfgVehicles" >> typeOf _objet_Heliporter),true] call BIS_fnc_returnParents;
		_helicoptere allowdamage false;

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_bench_F") exitwith
			{
				_objet_Heliporter attachTo [_helicoptere,[0,0.1,-1.13]];
				_helicoptere setCustomWeightRTD 680;
				_helicoptere setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};

			if (_x isEqualTo "Land_Pod_Heli_Transport_04_covered_F") exitwith
			{
				_objet_Heliporter attachTo [_helicoptere,[-0.1,-1.05,-0.82]];
				_helicoptere setCustomWeightRTD 1413;
				_helicoptere setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};

			if (_x isEqualTo "Land_Pod_Heli_Transport_04_fuel_F") exitwith
			{
				_objet_Heliporter attachTo [_helicoptere,[0,-0.282,-1.25]];
				_helicoptere setCustomWeightRTD 13311;
				_helicoptere setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};

			if (_x isEqualTo "Land_Pod_Heli_Transport_04_medevac_F") exitwith
			{
				_objet_Heliporter attachTo [_helicoptere,[-0.14,-1.05,-0.92]];
				_helicoptere setCustomWeightRTD 1321;
				_helicoptere setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};

			if (_x in ["Land_Pod_Heli_Transport_04_repair_F","Land_Pod_Heli_Transport_04_box_F","Land_Pod_Heli_Transport_04_ammo_F"]) exitwith
			{
				_objet_Heliporter attachTo [_helicoptere,[-0.09,-1.05,-1.1]];
				_helicoptere setCustomWeightRTD 1270;
				_helicoptere setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};
		} foreach _liste_Class_Parent;
	};

	_helicoptere allowdamage true;
	{ropeUnwind [_x, 250, 1];} foreach ropes _helicoptere;

	if (!_sans_Son) then 
	{
		[["Son Fixation", _helicoptere],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false] spawn BIS_fnc_MP;
		[["Chat arrimage", _helicoptere],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false] spawn BIS_fnc_MP;	
	};

	if (isnil {_helicoptere getVariable "EH_GetOut_Taru"}) then
	{
		_helicoptere addEventHandler ["Getin", "[_this] spawn Script_Taru_GetIn;"];
		_helicoptere setVariable ["EH_GetIn_Taru", true, false];
	};	   
};

Script_Taru_Desarrimer_Pod =
{
	_helicoptere = vehicle (_this select 0);
	_sans_Son = if (count _this > 1) then {_this select 1} else {false};
	_objet_Arrimer = attachedObjects _helicoptere select 0;
	_mass_Objet_Heliporter = getmass _objet_Arrimer;
	_mass_Helicoptere = getmass _helicoptere;

	_helicoptere allowdamage false;
	if (!isTouchingGround _helicoptere) then
	{
		_liste_Class_Parent = [(configfile >> "CfgVehicles" >> typeOf _objet_Arrimer),true] call BIS_fnc_returnParents;		

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_bench_F") exitwith
			{
				_objet_Arrimer attachTo [_helicoptere,[0,0.1,-2.83]];
			};
		} foreach _liste_Class_Parent;

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_covered_F") exitwith
			{
				_objet_Arrimer attachTo [_helicoptere,[-0.1,-1.05,-2.52]];
			};
		} foreach _liste_Class_Parent;

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_fuel_F") exitwith
			{
				_objet_Arrimer attachTo [_helicoptere,[0,-0.282,-3.05]];
			};
		} foreach _liste_Class_Parent;

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_medevac_F") exitwith
			{
				_objet_Arrimer attachTo [_helicoptere,[-0.14,-1.05,-2.62]];
			};
		} foreach _liste_Class_Parent;

		{
			if (_x isEqualTo ["Land_Pod_Heli_Transport_04_repair_F","Land_Pod_Heli_Transport_04_box_F","Land_Pod_Heli_Transport_04_ammo_F"]) then
			{
				_objet_Arrimer attachTo [_helicoptere,[-0.09,-1.05,-2.8]];
			};
		} foreach _liste_Class_Parent;
	};	
	
	
	if (isTouchingGround _helicoptere) then {{ropeCut [_x, 0];} foreach ropes _helicoptere; _helicoptere setSlingLoad _objet_Arrimer;};
	if (!isTouchingGround _helicoptere) then {{ropeUnwind [_x, 1.9, 10]; [["Son Desarrimage", _helicoptere],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false] spawn BIS_fnc_MP;} foreach ropes _helicoptere;};
	_helicoptere setCustomWeightRTD 0;	
	_helicoptere setmass _mass_Helicoptere - _mass_Objet_Heliporter;
	detach _objet_Arrimer;	
	_helicoptere allowdamage true;	

	if (!_sans_Son) then {[["Son Défixation", _helicoptere],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false] spawn BIS_fnc_MP;};
	
	if (!isTouchingGround _helicoptere) then {waituntil {ropeLength (ropes _helicoptere select 0) isEqualTo 10};};

	if (!_sans_Son) then {[["Chat désarrimage", _helicoptere],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false] spawn BIS_fnc_MP;};
};

Script_Taru_Larguer_Pod =
{
	_helicoptere = vehicle (_this select 0);
	_objet_Arrimer = attachedObjects _helicoptere select 0;


	_helicoptere allowdamage false;
	{ropeCut [_x, 0];} foreach ropes _helicoptere;
	_helicoptere setCustomWeightRTD 0;
	detach _objet_Arrimer;	
	_helicoptere allowdamage true;

	[["Son Largage", _helicoptere],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false] spawn BIS_fnc_MP;

	sleep 0.5;

	if (ASLToATL getposasl _objet_Arrimer select 2 >= 70) exitwith
	{
		_parachute = createVehicle ["B_Parachute_02_F",getposatl _objet_Arrimer, [], 0, "CAN COLLIDE"];
		_parachute attachTo [_objet_Arrimer,[0,0,-1]];

		[_objet_Arrimer,_parachute,_helicoptere] spawn
		{
			_objet_Arrimer = _this select 0;
			_parachute = _this select 1;
			_helicoptere = _this select 2;

			[["Chat largage avec parachute", _helicoptere],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false] spawn BIS_fnc_MP;

			waituntil
			{
				if (ASLToATL getposasl _objet_Arrimer select 2 <= 5) exitwith
				{
					detach _objet_Arrimer;
					_vitesse_nacelle = velocity _objet_Arrimer;
					_parachute setVelocity [_vitesse_nacelle select 0 + 1, _vitesse_nacelle select 1 + 1, 0];
					true
				};
				false
			};
		};

		waituntil
		{
			if (getposasl _helicoptere distance getposasl _objet_Arrimer >= 50) exitwith
			{
				detach _parachute;
				_objet_Arrimer attachTo [_parachute,[0,0,-1]];
				true
			};
			false
		};
	};

	[["Chat largage sans parachute", _helicoptere],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false] spawn BIS_fnc_MP;
};

Script_Taru_Hotfix_VRotor =
{
	_vehicule = vehicle player;

	waituntil
	{
		sleep 2;
		_degat_VRotor = vehicle player getHitPointDamage "HitVRotor";
		_disfonctionnement_Taru_Hotfixer = false;

		if ([player] call Script_Verification_Helico and {vehicle player != _vehicule}) then
		{
			if (!_disfonctionnement_Taru_Hotfixer) then
			{
				if (_degat_VRotor isEqualTo 1 and {damage vehicle player != 1}) then
				{
					_vehicule = vehicle player;
					_disfonctionnement_Taru_Hotfixer = true;
					_vehicule setHitPointDamage ["HitVRotor", 0];
					systemchat "Hotfix ATRQ";
				};
			};
		};
	};
};

Script_Taru_Transmission_Son_Message =
{
	_type_Son_Message = _this select 0;
	_helicoptere = vehicle (_this select 1);

	[] call
	{
		if (_type_Son_Message isEqualTo "Son Arrimage") exitwith
		{
			if (!isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
			{
				_helicoptere say "XENO_Helitreuillage_Arrimage_Exterieur";
			};
			if (isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
			{
				_helicoptere say "XENO_Helitreuillage_Arrimage_Exterieur_JSRS";
			};
		};

		if (_type_Son_Message isEqualTo "Son Desarrimage") exitwith
		{
			if (!isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
			{
				_helicoptere say "XENO_Helitreuillage_Desarrimage_Exterieur";
			};
			if (isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
			{
				_helicoptere say "XENO_Helitreuillage_Desarrimage_Exterieur_JSRS";
			};
		};
		
		if (_type_Son_Message isEqualTo "Chat arrimage") exitwith
		{
			if (player in crew _helicoptere) then {_helicoptere vehicleChat localize "STR_XENO_Chat_Arrimer";};
		};

		if (_type_Son_Message isEqualTo "Chat désarrimage") exitwith
		{
			if (player in crew _helicoptere) then {_helicoptere vehicleChat localize "STR_XENO_Chat_Desarrimer";};
		};

		if (_type_Son_Message isEqualTo "Chat largage avec parachute") exitwith
		{
			if (player in crew _helicoptere) then {_helicoptere vehicleChat localize "STR_XENO_Chat_Larguer_Avec_Parachute";};
		};

		if (_type_Son_Message isEqualTo "Chat largage sans parachute") then
		{
			if (player in crew _helicoptere) then {_helicoptere vehicleChat localize "STR_XENO_Chat_Larguer_Sans_Parachute";};
		};
	};
};

Script_BIS_Liste_Joueur =
{
	private ["_players"];
	_players = [];
	
	
	{
		if (isplayer _x) then
		{
			if (_x isKindOf "man") then {_players pushback _x;};
		};
	} foreach (allunits + alldead);

	_players
};

Script_Taru_GetIn =
{
	_vehicule = _this select 0 select 0;
	if ([_vehicule] call Script_Verification_Helico) then 
	{
		if (count attachedObjects _vehicule > 0) then 
		{ 
			_time = time + 2;
			waituntil
			{	
				_vehicule setvelocity [0, 0, 0];
				if (time > _time or {time > _time + 15}) exitwith {true};
			};					
		};
	};	
};

[] call Script_Taru;
XENO_Taru_EH_Respawn = player addEventHandler ["Respawn", "[] call Script_Taru;"];