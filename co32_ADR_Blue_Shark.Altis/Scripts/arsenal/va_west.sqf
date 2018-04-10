params ["_box"];

waitUntil {arsenalDefined};

itemsList = specBinocs + baseItems + baseVests + baseMagazines + baseHeadgear + baseGoggles + (items player) + [(headgear player)] + [(vest player)];
backpackList = baseBackpacks + westBaseBackpacks + [backpack player];
weaponsList = baseWeapons + specBinocs + (weapons player);
magazinesList = baseMagazines + EU1Magazines + (magazines player);
itemBlackList = nvgBlacklist;

if ( roleDescription player find "Pilot" > -1 ) then
{	//Pilots
	weaponsList = weaponsList + EU1SMGWeapons;
	itemsList = itemsList + westPilotUniforms + westPilotVests + westPilotHeadgear;
} else {
	itemsList = itemsList + westBaseHeadgear + westNormalHeadgear + westReconHeadgear + westNormalUniforms + westReconUniforms + westNormalVests + westReconVests;
};

if ( roleDescription player find "Squad" > -1 || roleDescription player find "JTAC" > -1 || roleDescription player find "Team Leader" > -1) then
{	// SQUAD LEADERS) - COMMAND EQUIPMENT
	weaponsList = weaponsList + EU1CarbineWeapons + EU1RifleWeapons + EU1GLWeapons + EU1LATWeapons;
};

if ( roleDescription player find "Grenadier" > -1 ) then
{	// TEAM LEADER / GRENADIER EQUIPMENT
	weaponsList = weaponsList + EU1GLWeapons + EU1LATWeapons;
};

if ( roleDescription player find "UAV" > -1 ) then
{	weaponsList = weaponsList + EU1CarbineWeapons + EU1SMGWeapons;
	itemsList = itemsList + ["B_UavTerminal"];
	backpackList = backpackList + ["B_UAV_01_backpack_F","B_UAV_06_backpack_F","B_UAV_06_medical_backpack_F"];
};

if ( roleDescription player find "edic" > -1 ) then
{	// MEDICAL EQUIPMENT
	weaponsList = weaponsList + EU1CarbineWeapons + EU1SMGWeapons;
	itemsList = itemsList + ["Medikit", "U_C_Paramedic_01_F"];
};

if ( roleDescription player find "AT" > -1 ) then
{	// MISSILE LAUNCHERS
	weaponsList = weaponsList + EU1RifleWeapons + EU1CarbineWeapons + EU1HATWeapons + EU1LATWeapons;
};

if ( roleDescription player find "Autorifleman" > -1 ) then
{	// AUTORIFLEMAN
	weaponsList = weaponsList + EU1MMGWeapons + EU1LMGWeapons + EU1LATWeapons;
};

if ( roleDescription player find "Engineer" > -1  || roleDescription player find "Repair" > -1) then
{	// Engineers
	weaponsList = weaponsList + EU1CarbineWeapons + EU1RifleWeapons + EU1LATWeapons;
	itemsList = itemsList + ["Toolkit"];
};

if ( roleDescription player find "Explosive" > -1 ) then
{	// EOD
	weaponsList = weaponsList + EU1CarbineWeapons + EU1RifleWeapons + EU1LATWeapons;
	itemsList = itemsList + ["MineDetector", "Toolkit"];
	magazinesList = magazinesList + baseDemo;
};

if ( roleDescription player find "Marksman" > -1 ) then
{	// MARSKMAN
	weaponsList = weaponsList + EU1MarksmanWeapons + EU1LATWeapons;
	itemsList = itemsList + specOptics;
};

if ( roleDescription player find "FSG" > -1 ) then
{	// FSG
	weaponsList = weaponsList + EU1SMGWeapons + EU1CarbineWeapons + EU1LATWeapons;
	backpackList = backpackList + westBackpackWeapons;
};

if ( roleDescription player find "Sniper" > -1 && roleDescription player find "Spotter" == -1) then
{	// SNIPERS
	weaponsList = weaponsList + EU1SniperWeapons;
	itemsList = itemsList + westGhillieUniforms + specOptics + sniperOptics;
};

if ( roleDescription player find "Spotter" > -1 ) then
{	// SPOTTERS
	weaponsList = weaponsList + EU1RifleWeapons + EU1CarbineWeapons + EU1LATWeapons;
	itemsList = itemsList + westGhillieUniforms;
};

//init ammo box
["AmmoboxInit",[_box,false,{true}]] spawn BIS_fnc_arsenal;

//whitelist
[_box, itemsList, false, false] call BIS_fnc_addVirtualItemCargo;
[_box, weaponsList, false, false] call BIS_fnc_addVirtualWeaponCargo;
[_box, backpackList, false, false] call BIS_fnc_addVirtualBackpackCargo;
[_box, magazinesList, false, false] call BIS_fnc_addVirtualMagazineCargo;

//blacklist
[_box, itemBlackList, false, false] call BIS_fnc_removeVirtualItemCargo;