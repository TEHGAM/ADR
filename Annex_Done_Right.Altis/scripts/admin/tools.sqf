_pathtotools = "scripts\admin\tools\";
_EXECscript1 = 'player execVM "'+_pathtotools+'%1"';

adminmenu =
[
	["Menu", true],
        ["Teleport", [2],  "", -5, [["expression", format[_EXECscript1,"teleport.sqf"]]], "1", "1"],
		["Teleport Player To Me", [3],  "", -5, [["expression", format[_EXECscript1,"tptome.sqf"]]], "1", "1"],		
		["Heal Self", [4],  "", -5, [["expression", format[_EXECscript1,"heal.sqf"]]], "1", "1"],
		["Heal Player(s)", [5],  "", -5, [["expression", format[_EXECscript1,"healp.sqf"]]], "1", "1"],
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
		["Exit", [13], "", -3, [["expression", ""]], "1", "1"]	
];
		
showCommandingMenu "#USER:adminmenu";