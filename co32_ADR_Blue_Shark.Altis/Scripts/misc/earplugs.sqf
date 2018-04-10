//    VAS EARPLUGS v2.0   //
//scripts\VAS\Earplugs.sqf//
//      MykeyRM [AW]      //
////////////////////////////

//Earplugs.sqf
//(findDisplay 46) displayRemoveEventHandler ["KeyDown", MEP_KD];  //Prevent doubleUp of eventHandlers - Not sure these actually stack so just incase.
sleep 1;

_PlugsTakenHint  = "<t color='#ff9d00' size='1.3' shadow='1' shadowColor='#000000' align='center'>*** Earplugs received ***  </t>";   //Item taken hint.     
_howtoHint = "<t  size='1' shadow='1' shadowColor='#000000' align='center'>   [Pause/Break] key to Insert and Remove </t>";          //Instructions hint.
  
  //hint parseText (_PlugsTakenHint + _howtoHint);   
[parseText format ["<br />%1<br />%2", _PlugsTakenHint, _howtoHint], true, nil, 10, 1, 0.3] spawn BIS_fnc_textTiles;

PlugsIN = 2;     			 //Set 'EARPLUGS REMOVED' as init value 

earplugAction = { 
	switch (PlugsIN) do {
		case 1: { 
			PlugsIN = 2; 
			2 fadeSound 1; 
			[parseText format ["<br/><t size='1.6' font='PuristaBold' align='center'>*** earplugs removed *** </t>"], true, [10,5], 2, 0.5, 0.3] spawn BIS_fnc_textTiles;
		};
		case 2: { 
			PlugsIN = 1; 
			2 fadeSound 0.2; 
			[parseText format ["<br/><t size='1.6' font='PuristaBold' align='center'>*** earplugs fitted *** </t>"], true, [10,5], 2, 0.5, 0.3] spawn BIS_fnc_textTiles;
		};
	};
};

//Add keybind to player [Pause/Break] key - US keyboard.
MEP_KD = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 197) then {_this call earplugAction;};"];


/*
MEP_KD = (findDisplay 46) displayAddEventHandler ["KeyDown", "if (_this select 1 == 197) then {         
 switch (PlugsIN) do {
    case 1: { _this call 'earplugInAction'; PlugsIN = 2; 2 fadeSound 1; player groupChat 'EARPLUGS REMOVED'; };
	case 2: { _this call 'earplugInAction'; PlugsIN = 1; 2 fadeSound 0.2; player groupChat 'EARPLUGS FITTED';  };
	default { };
	};
}"];
/*
Once Earplugs taken from vas the Earplugs remain constant.
Keybind remains until diconnection from server.

mission.sqf - Script calls
Object init Quartermaster - line 2308
Object init Supply_Officer - Line 2623
*/