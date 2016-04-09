_pathtotools2 = "scripts\admin\vehicle\";
_EXECscript12 = 'player execVM "'+_pathtotools2+'%1"';

adminmenu2 =
[
	["Menu", true],
		["Хочу квадрик", [2], "", -5, [["expression", format[_EXECscript12,"kvadr.sqf"]]], "1", "1"],
		["Выход", [13], "", -3, [["expression", ""]], "1", "1"]
];

showCommandingMenu "#USER:adminmenu2";