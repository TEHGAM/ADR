/*
  Authors:
  Quiksilver
  Rarek [AW]

  Last modified:
  24/04/2014

  Description:
  Not done with this, want to get the Commanders gun firing, and some other stuff.
*/

private ["_flatPos","_accepted","_position","_flatPos1","_flatPos2","_flatPos3","_PTdir","_unitsArray","_priorityGroup","_distance","_dir","_c","_pos","_barrier","_enemiesArray","_radius","_unit","_targetPos","_firingMessages","_fuzzyPos","_briefing","_completeText","_priorityMan1","_priorityMan2"];

//1.FIND POSITION
  _flatPos = [0,0,0];
  _accepted = false;
  while {!_accepted} do
  {
    _position = [[[getMarkerPos currentAO,2500]],["water","out"]] call BIS_fnc_randomPos;
    _flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];

    while {(count _flatPos) < 2} do
    {
      _position = [[[getMarkerPos currentAO,2500]],["water","out"]] call BIS_fnc_randomPos;
      _flatPos = _position isFlatEmpty [5, 0, 0.2, 5, 0, false];
    };

    if ((_flatPos distance (getMarkerPos "respawn_west")) > 2000 && (_flatPos distance (getMarkerPos currentAO)) > 800) then
    {
      _accepted = true;
    };
  };

  _flatPos1 = [(_flatPos select 0) - 2, (_flatPos select 1) - 2, (_flatPos select 2)];
  _flatPos2 = [(_flatPos select 0) + 2, (_flatPos select 1) + 2, (_flatPos select 2)];
  _flatPos3 = [(_flatPos select 0) + 20, (_flatPos select 1) + random 20, (_flatPos select 2)];

//2.SPAWN OBJECTIVES
  _PTdir = random 360;

  sleep 0.3;

  priorityObj1 = "O_MBT_02_arty_F" createVehicle _flatPos1;
  waitUntil {!isNull priorityObj1};
  priorityObj1 setDir _PTdir;

  sleep 0.3;

  priorityObj2 = "O_MBT_02_arty_F" createVehicle _flatPos2;
  waitUntil {!isNull priorityObj2};
  priorityObj2 setDir _PTdir;

  sleep 0.3;

  priorityObj1 addEventHandler ["Fired",{if (!isPlayer (gunner priorityObj1)) then { priorityObj1 setVehicleAmmo 1; };}];
  priorityObj2 addEventHandler ["Fired",{if (!isPlayer (gunner priorityObj2)) then { priorityObj2 setVehicleAmmo 1; };}];

//SPAWN AMMO TRUCK (for ambiance and plausibiliy of unlimited ammo)
  ammoTruck = "O_Truck_03_ammo_F" createVehicle _flatPos3;
  waitUntil {!isNull ammoTruck};
  ammoTruck setDir random 360;

  { _x lock 3 } forEach [priorityObj1,priorityObj2,ammoTruck];

//3.SPAWN CREW
  sleep 1;

  _unitsArray = [objNull];

  _priorityGroup = createGroup east;

    "O_officer_F" createUnit [_flatPos, _priorityGroup];
    "O_officer_F" createUnit [_flatPos, _priorityGroup];
    "O_engineer_F" createUnit [_flatPos, _priorityGroup];
    "O_engineer_F" createUnit [_flatPos, _priorityGroup];

    priorityGunner1 = ((units _priorityGroup) select 2);
    priorityGunner2 = ((units _priorityGroup) select 3);

    ((units _priorityGroup) select 0) assignAsCommander priorityObj1;
    ((units _priorityGroup) select 0) moveInCommander priorityObj1;
    ((units _priorityGroup) select 1) assignAsCommander priorityObj2;
    ((units _priorityGroup) select 1) moveInCommander priorityObj2;
    ((units _priorityGroup) select 2) assignAsGunner priorityObj1;
    ((units _priorityGroup) select 2) moveInGunner priorityObj1;
    ((units _priorityGroup) select 3) assignAsGunner priorityObj2;
    ((units _priorityGroup) select 3) moveInGunner priorityObj2;

  [(units _priorityGroup)] call QS_fnc_setSkill4;
  _priorityGroup setBehaviour "COMBAT";
  _priorityGroup setCombatMode "RED";
  _priorityGroup allowFleeing 0;

  _unitsArray = _unitsArray + [_priorityGroup];

  {
    _x addCuratorEditableObjects [[priorityObj1, priorityObj2, ammoTruck] + (units _priorityGroup), false];
  } foreach adminCurators;

//4.SPAWN H-BARRIER RING
  sleep 1;

  _distance = 16;
  _dir = 0;
  for "_c" from 0 to 7 do
  {
    _pos = [_flatPos, _distance, _dir] call BIS_fnc_relPos;
    _barrier = "Land_HBarrierBig_F" createVehicle _pos;
    waitUntil {alive _barrier};
    _barrier setDir _dir;
    _dir = _dir + 45;
    _barrier allowDamage false; 
    _barrier enableSimulation false;

    _unitsArray = _unitsArray + [_barrier];
  };

//5.SPAWN FORCE PROTECTION
  sleep 1;

  _enemiesArray = [priorityObj1] call QS_fnc_PTenemyEAST;

//7.BRIEF
  _fuzzyPos = [((_flatPos select 0) - 300) + (random 600),((_flatPos select 1) - 300) + (random 600),0];
  { _x setMarkerPos _fuzzyPos; } forEach ["priorityMarker", "priorityCircle"];

  "priorityMarker" setMarkerText "Артиллерия"; publicVariable "priorityMarker";
  priorityTargetText = "Артиллерия"; publicVariable "priorityTargetText";

  _briefing = "<t align='center' size='2.2'>Внимание</t><br/><t size='1.5' color='#d63333'>Вражеская артиллерия</t><br/>____________________<br/>Обнаружена точка укрепления артиллерийских орудий противника. Её близлежащее расположение от района дислокации грозит всей нашей наземной группировке.<br/><br/>Первый залп ожидается уже через 5 минут.";
  GlobalHint = _briefing; hint parseText _briefing; publicVariable "GlobalHint";
  showNotification = ["NewPriorityTarget", "Обнаружена артиллерия врага"]; publicVariable "showNotification";

  _firingMessages = [
    "Противник выпустил артиллерийский залп. По укрытиям!",
    "Наши позиции обстреливает батарея врага. Ищите укрытие!",
    "Враг начал прицельный артиллерийский огонь. Укройтесь!",
    "Враг ведёт стрельбу из артиллерийских орудий. Пригнитесь!",
    "Противник начал артобстрел наших позиций. В укрытие!"];

//FIRING SEQUENCE LOOP
_radius = 80;

while { canMove priorityObj1 || canMove priorityObj2 } do
{
  _accepted = false;
  _unit = objNull;
  _targetPos = [0,0,0];

  while {!_accepted} do
  {
    _unit = (playableUnits select (floor (random (count playableUnits))));
    _targetPos = getPos _unit;

    if ((_targetPos distance (getMarkerPos "respawn_west")) > 1000 && vehicle _unit == _unit && side _unit == WEST) then
    {
      _accepted = true;
    } else
    {
      sleep 10; //Default 10
    };
  };

  if (PARAMS_ArtilleryTargetTickWarning == 1) then
  {
    hqSideChat = _firingMessages call BIS_fnc_selectRandom; publicVariable "hqSideChat"; [WEST,"HQ"] sideChat hqSideChat;
  };

  _dir = [_flatPos, _targetPos] call BIS_fnc_dirTo;

  { _x setDir _dir; } forEach [priorityObj1, priorityObj2];

  sleep 5;  //Default 5

  {
    if (alive _x) then
    {
      for "_c" from 0 to 4 do
      {
        _pos =
        [
          (_targetPos select 0) - _radius + (2 * random _radius),
          (_targetPos select 1) - _radius + (2 * random _radius),
          0
        ];
        _x doArtilleryFire [_pos, "32Rnd_155mm_Mo_shells", 1];
        sleep 8;//Default 8
      };
    };
  } forEach [priorityObj1,priorityObj2];

  if (_radius > 10) then { _radius = _radius - 10; };

  if (PARAMS_ArtilleryTargetTickTimeMax <= PARAMS_ArtilleryTargetTickTimeMin) then
  {
    sleep PARAMS_ArtilleryTargetTickTimeMin;
  } else
  {
    sleep (PARAMS_ArtilleryTargetTickTimeMin + (random (PARAMS_ArtilleryTargetTickTimeMax - PARAMS_ArtilleryTargetTickTimeMin)));
  };
};

//DE-BRIEF
_completeText = "<t align='center' size='2.2'>Внимание</t><br/><t size='1.5' color='#08b000'>Артиллерия подавлена</t><br/>____________________<br/>ИПротивник лишился артиллерийских орудий.<br/><br/>Возвращайтесь к выполнению основной задачи.";
GlobalHint = _completeText; hint parseText _completeText; publicVariable "GlobalHint";
showNotification = ["CompletedPriorityTarget", "Артиллерия нейтрализована"]; publicVariable "showNotification";
{ _x setMarkerPos [-10000,-10000,-10000] } forEach ["priorityMarker","priorityCircle"]; publicVariable "priorityMarker";

//DELETE
sleep 120;
{ _x removeEventHandler ["Fired", 0]; } forEach [priorityObj1,priorityObj2];
{ [_x] spawn QS_fnc_SMdelete } forEach [_enemiesArray,_unitsArray];
{ deleteVehicle _x } forEach [priorityObj1,priorityObj2,ammoTruck];
