private ["_name","_vehicle","_hudnames","_ui"];   
	   
disableSerialization;
while {true} do {
	1000 cutRsc ["HudNames","PLAIN"];
	_ui = uiNameSpace getVariable "HudNames";
	_HudNames = _ui displayCtrl 99999;

    if(player != vehicle player) then
    {
        _name = "";
        _vehicle = assignedVehicle player;
        //Air vehicles
		if(_vehicle isKindOf "Air") then {
			{
				if ((driver _vehicle == _x) || (_vehicle turretUnit [0] == _x) || (_vehicle turretUnit [1] == _x) || (_vehicle turretUnit [2] == _x)) then {    
					if((driver _vehicle == _x) || (_vehicle turretUnit [0] == _x)) then {
						_name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getinpilot_ca.paa'/><br/>", _name, (name _x)];
					}
					else {
						_name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/>", _name, (name _x)];
					};
				}
				else {
					_name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa'/><br/>", _name, (name _x)];
				};
			} forEach crew _vehicle;
		}
		//Other vehicles
		else {
			{
				if ((driver _vehicle == _x) || (gunner _vehicle == _x)) then {    
					if(driver _vehicle == _x) then {
						_name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getindriver_ca.paa'/><br/>", _name, (name _x)];
					}
					else {
						_name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/><br/>", _name, (name _x)];
					};
				}
				else {
					if(commander _vehicle == _x) then {
						_name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getincommander_ca.paa'/><br/>", _name, (name _x)];	
					}
					else {
						_name = format ["<t size='0.85' color='#f0e68c'>%1 %2</t> <img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa'/><br/>", _name, (name _x)];
					};
				};
			} forEach crew _vehicle;
		};
      	_HudNames ctrlSetStructuredText parseText _name;
      	_HudNames ctrlCommit 0;
    };
    sleep 1;
};  
  