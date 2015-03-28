// INFANTRY SKILL
_InfskillSet = [
0.3,        		// aimingAccuracy
0.45,        		// aimingShake
0.6,        		// aimingSpeed
0.7,         		// spotDistance
0.4,       			// spotTime
1,        			// courage
1,        			// reloadSpeed
1,        			// commanding
1        			// general
];


// ARMOUR SKILL
_ArmSkillSet = [
0.25,        		// aimingAccuracy
0.45,        		// aimingShake
0.6,        		// aimingSpeed
0.6,         		// spotDistance
0.7,        		// spotTime
1,        			// courage
1,        			// reloadSpeed
1,        			// commanding
1        			// general
];


// LIGHT VEHICLE skill
_LigSkillSet = [
0.25,        		// aimingAccuracy
0.45,        		// aimingShake
0.6,        		// aimingSpeed
0.4,         		// spotDistance
0.4,        		// spotTime
1,        			// courage
1,        			// reloadSpeed
1,        			// commanding
1        			// general
];


// HELICOPTER SKILL
_AIRskillSet = [
0.5,        		// aimingAccuracy
0.5,        		// aimingShake
0.7,        		// aimingSpeed
1,         			// spotDistance
1,        			// spotTime
1,        			// courage
1,        			// reloadSpeed
1,        			// commanding
1        			// general
];


// STATIC SKILL
_STAskillSet = [
0.25,        		// aimingAccuracy
0.45,        		// aimingShake
0.6,        		// aimingSpeed
0.4,         		// spotDistance
0.4,        		// spotTime
1,        			// courage
1,        			// reloadSpeed
1,        			// commanding
1        			// general
];

server setvariable ["INFskill",_InfskillSet];
server setvariable ["ARMskill",_ArmSkillSet];
server setvariable ["LIGskill",_LigSkillSet];
server setvariable ["AIRskill",_AIRskillSet];
server setvariable ["STAskill",_STAskillSet];