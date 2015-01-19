//Выкладывает из входящей машины (если это Бобкэт) боеприпасы для техники. Родительский скрипт: boxZone.sqf для добавления этого действия пересекающему зону триггера Бобкэту.
_bobcat1 = _this select 0; //First variable in script arguments is a vehicle that spawns ammobox
if (vehicle _bobcat1 isKindof "B_APC_Tracked_01_CRV_F") then
{
  DeleteVehicle ammo4 ;  //Only four ammoboxes avalible per map
  ammo4 = ammo3 ;        //Creates second ammobox variable
  ammo3 = ammo2 ;        //Creates second ammobox variable
  ammo2 = ammo1 ;        //Creates second ammobox variable
  _bobcat1 setFuel 0;
  sleep 1;
  _bobcat1 vehiclechat "Загружен на 40%...";
  sleep 2;
  _bobcat1 vehiclechat "Загружен на 75%...";
  sleep 3;
  _bobcat1 vehiclechat "Загружен на 100%. Готово!";
  ammo1 = "Box_NATO_AmmoVeh_F" createVehicle (position _bobcat1); //creates ammobox outside a given vehicle
  _bobcat1 setFuel 1;
  _bobcat1 removeAction action734;
}
else
{
  _bobcat1 VehicleChat "В данной машине отсутствует кран для работы с грузом. Используйте Бобкэт!";
  _bobcat1 removeAction aact1;
};
