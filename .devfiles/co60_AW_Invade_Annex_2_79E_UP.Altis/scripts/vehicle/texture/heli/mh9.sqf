if (((_this select 1) < 1) or ((_this select 1) > 15)) exitWith {};

_skin = switch (_this select 1) do {
	case 1: {"heli_light_01_ext_blueline_co"};
	case 2: {"heli_light_01_ext_digital_co"};
	case 3: {"heli_light_01_ext_elliptical_co"};
	case 4: {"heli_light_01_ext_furious_co"};
	case 5: {"heli_light_01_ext_graywatcher_co"};
	case 6: {"heli_light_01_ext_jeans_co"};
	case 7: {"heli_light_01_ext_shadow_co"};
	case 8: {"heli_light_01_ext_sheriff_co"};
	case 9: {"heli_light_01_ext_speedy_co"};
	case 10: {"heli_light_01_ext_sunset_co"};
	case 11: {"heli_light_01_ext_vrana_co"};
	case 12: {"heli_light_01_ext_wasp_co"};
	case 13: {"heli_light_01_ext_wave_co"};
	case 14: {"heli_light_01_ext_co"};
	case 15: {"heli_light_01_ext_blue_co"};
};

if (_skin in ["heli_light_01_ext_co","heli_light_01_ext_blue_co"]) then {
	_skin = format["\a3\air_f\Heli_Light_01\Data\%1.paa", _skin];
} else {
	_skin = format["\a3\air_f\Heli_Light_01\Data\Skins\%1.paa", _skin];
};

(_this select 0) setObjectTexture [0, _skin];