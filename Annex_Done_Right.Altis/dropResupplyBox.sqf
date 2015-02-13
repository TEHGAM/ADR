//Выкладывает из входящего юнита (если это Бобкэт) боеприпасы для техники. Родительский скрипт: boxZone.sqf для добавления этого действия пересекающему зону триггера Бобкэту.
_bobcat1 = _this select 0; // first variable in script arguments is vehicle that spawning ammobox
if (vehicle _bobcat1 isKindof "B_APC_Tracked_01_CRV_F") then
{
  _dropbox = _bobcat1 getVariable "dropbox";
  DeleteVehicle ammo4 ; // only four ammoboxes avalible per map
  ammo4 = ammo3 ; // creates second ammobox variable
  ammo3 = ammo2 ; // creates second ammobox variable
  ammo2 = ammo1 ; // creates second ammobox variable

  _bobcat1 setFuel 0;
  sleep 1;
  _bobcat1 vehiclechat "Загружен на 40%...";
  sleep 2;
  _bobcat1 vehiclechat "Загружен на 75%...";
  sleep 3;
  _bobcat1 vehiclechat "Загружен на 100%. Готово!";
  ammo1 = "Box_NATO_AmmoVeh_F" createVehicle (position _bobcat1); //creates box at position of externally given vehicle
  ammo1 setRepairCargo 1;
  //ammo1 setAmmoCargo 1;
  _bobcat1 setFuel 1;
  // _bobcat1 removeAction _dropbox;
} else
{
  _bobcat1 VehicleChat "В данной машине отсутствует кран для работы с грузом. Используйте Бобкэт!";
  _bobcat1 removeAction aact1;
  _bobcat1 removeAction _dropbox;
  };
