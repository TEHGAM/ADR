//Добавляет действие Бобкэтy вошедшему в зону действия триггера (на входе название триггера) [triggername] execVM boxZone.sqf
_zone = _this select 0; //zone is first argument in this script. Try [triggername] execVM "boxZone.sqf"
_bobcat1 = list _zone select 0; // selects the vehicle moved inside this trigger area
if (vehicle _bobcat1 isKindof "B_APC_Tracked_01_CRV_F") then
{
  _bobcat1 vehicleChat("Начата загрузка ремкомплекта");
  _bobcat1 removeAction action734;
  _bobcat1 setFuel 0;
  sleep 1;
  _bobcat1 vehiclechat "Загружен на 40%...";
  sleep 2;
  _bobcat1 vehiclechat "Загружен на 75%...";
  sleep 3;
  action734 = _bobcat1 addAction ["<t color='#FF8000'>Выгрузить ремкомплект</t>","dropResupplyBox.sqf", _bobcat1];
  _bobcat1 vehiclechat "Загружен на 100%. Готово!";
  _bobcat1 setFuel 1;
  cratercleaner = [7, _bobcat1] execVM "groundWorks.sqf";
}
else
{
  _bobcat1 vehiclechat "В данной машине отсутствует кран для работы с грузом. Используйте Бобкэт!"
};
