/*
    Author: BACONMOP
    Description: For teleporting to different bases
    this addAction ["<t color='#009ACD'>Teleport To Main Base</t>","cutText ['','BLACK OUT'];sleep 2;[player,'BASE'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];"];
	this addAction ["<t color='#009ACD'>Teleport To FOB Martian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'AAC_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('AAC_Airfield' in controlledZones)"]; 
	this addAction ["<t color='#009ACD'>Teleport To FOB Marathon</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Stadium'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Stadium' in controlledZones)"]; 
	this addAction ["<t color='#009ACD'>Teleport To FOB Guardian</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Terminal'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Terminal' in controlledZones)"]; 
	this addAction ["<t color='#009ACD'>Teleport To FOB Dirt Track</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Selakano_Town'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Selakano_Town' in controlledZones)"]; 
	this addAction ["<t color='#009ACD'>Teleport To FOB Last Stand</t>","cutText ['','BLACK OUT'];sleep 2;[player,'Molos_Airfield'] remoteExec ['AW_fnc_baseTeleport',2];sleep 1; cutText ['','BLACK IN'];","",0,false,true,"","('Molos_Airfield' in controlledZones)"];*/

params ["_unit","_baseLoc"];

switch (_baseLoc) do{

    case "BASE":{
        if (_baseLoc in controlledZones) then {
            _unit setPos (getMarkerPos "BASE");
        };
    };

    case "Stadium":{
        if (_baseLoc in controlledZones) then {
            _unit setPos (getMarkerPos "FOB_Marathon");
        };
    };

    case "Terminal":{
        if (_baseLoc in controlledZones) then {
            _unit setPos (getMarkerPos "FOB_Guardian");
        };
    };

    case "Selakano_Town":{
        if (_baseLoc in controlledZones) then {
            _unit setPos (getMarkerPos "FOB_Dirt_Track");
        };
    };

    case "Molos_Airfield":{
        if (_baseLoc in controlledZones) then {
            _unit setPos (getMarkerPos "FOB_Last_Stand");
        };
    };
	
	case "AAC_Airfield":{
        if (_baseLoc in controlledZones) then {
            _unit setPos (getMarkerPos "FOB_Martian");
        };
    };

};
