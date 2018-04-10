//-------------------- Wait for player to action

[[player,"AinvPknlMstpSlayWrflDnon_medic"],"QS_fnc_switchMoveMP",nil,false] spawn BIS_fnc_MP;

sleep 1;



//-------------------- Send hint to player that he's planted the bomb

_name = name player;

_sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 healed the pilot. Good job for looking everyone.</t>",_name];
[_sidecompleted] remoteExec ["AW_fnc_globalHint",0,false];

sleep 5;

[] remoteExec ["Aw_fnc_smSucSwitch",2];