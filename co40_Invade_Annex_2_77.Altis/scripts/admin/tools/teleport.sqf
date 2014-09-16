openMap true;
cutText ["Click somewhere on the map to move there", "PLAIN"];
onMapSingleClick "vehicle player setPos _pos; onMapSingleClick '';true;";
"Teleported himself" call BIS_fnc_log;
