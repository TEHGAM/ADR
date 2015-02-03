/*
  Author:
  Jester [AW]
  Quiksilver

  Last modified:
  27/04/2014

  Description:
  Spawns enemy CAS while radio tower is alive.
*/

#define AIR_TYPE "O_Plane_CAS_02_F"
#define SPAWN_LIMIT 4
#define FIXED_TIME 480    //Default 480
#define RANDOM_TIME 300   //Default 300

waitUntil {sleep 0.5; !(isNil "currentAOUp")};
private ["_priorityMessageJet"];

while {true} do {
  sleep (FIXED_TIME + (random RANDOM_TIME));
  if ((radioTowerAlive) && (({(typeOf _x == AIR_TYPE) && (side _x == east)} count vehicles) < SPAWN_LIMIT))
  then {
    _helo_Patrol = createGroup EAST;
    _patrolPos = getMarkerPos currentAO;
    //_jtacPos = [_patrolPos, 1000, 50, 10] call BIS_fnc_findOverwatch;
    _helo_Array = [[15000, _patrolPos select 1, 2000], 20, [AIR_TYPE] call BIS_fnc_selectRandom, east] call BIS_fnc_spawnVehicle;
    //"O_recon_JTAC_F" createUnit [_jtacPos,_helo_Patrol];
    _helo_Patrol = _helo_Array select 0;
    _helo_crew = _helo_Array select 1;
    [_helo_Array select 2, _patrolPos] call BIS_fnc_taskAttack;

    [(units _helo_Patrol)] call QS_fnc_setSkill4;

    {
      _x addCuratorEditableObjects [[_air], false];
      _x addCuratorEditableObjects [units _airGroup, false];
    } foreach _curators;

    showNotification = ["EnemyJet", "Новая воздушная цель"]; publicVariable "showNotification";
    _priorityMessageJet ="<t align='center' size='2.2'>Внимание</t><br/><t size='1.5' color='#d63333'>Вражеский штурмовик</t><br/><br/>Враг запросил авиаподдержку. Примите меры ПВО.<br/><br/>Немедленное уничтожение авиации противника как упростит проведение, так и ускорит выполнение боевой задачи.";
    GlobalHint = _priorityMessageJet; publicVariable "GlobalHint"; hint parseText _priorityMessageJet;

    waitUntil
    {
      sleep 5;
      _helo_Patrol setVehicleAmmo 1;
      !alive _helo_Patrol || {!canMove _helo_Patrol}
    };

    [] call QS_fnc_rewardPlusHintJet;

    sleep 5;
    _helo_Patrol setDamage 1;
    sleep 5;
    deleteVehicle _helo_Patrol;

    {
      _x setDamage 1;
      sleep 5;
      deleteVehicle _x;
    } foreach _helo_crew;
  };
  sleep 10;
};
