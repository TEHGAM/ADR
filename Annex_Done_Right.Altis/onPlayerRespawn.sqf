/*

  Filename:
  onPlayerRespawn.sqf

  Author:
  Quiksilver

  Last modified:
  9/04/2014

  Description:
  Client scripts that should execute after respawn.

*/

if (!isDedicated) then
{
  player addAction [
    ("<t color='#04cc6b'>" + localize "STRD_squadm" + "</t>"),
    Compile preprocessFileLineNumbers "scripts\DOM_squad\open_dialog.sqf", [], -80, false
  ];
};

//Скрипт теплака
_allowedVehicles = []; //сюда пишешь машинки, где работает теплак
_allowedWeapons = ["GMG_UGV_40mm",
                   "Laserdesignator_mounted",
                   "Laserdesignator",
                   "launch_B_Titan_F",
                   "launch_O_Titan_F",
                   "launch_I_Titan_F",
                   "launch_B_Titan_short_F",
                   "launch_O_Titan_short_F",
                   "launch_I_Titan_short_F"];

waitUntil {!isNull player};

while {true} do
{
if (currentVisionMode player == 2) then
  {
    _disable = true;
    _veh = vehicle player;
    _weaponClass = currentWeapon player;

    if ((_veh != player) and ((TypeOf _veh) in _allowedVehicles) ) then
    {
      _disable = false;
    };

    if ((_veh != player)) then
    {
      _disable = false;
    };

    if (_weaponClass in  _allowedWeapons) then
    {
      _disable = false;
    };

    if (_disable) then
    {
cutText ["Тепловизор отключен; нажмите клавишу «N»","BLACK",-1];
waituntil {currentVisionMode player != 2};
0 cutFadeOut 0;
    };
  };
  sleep 1;
};
