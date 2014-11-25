// Vehicle Info Crew Script By : MarKeR. Thanks to Blakeace for azimuth code usage. Also XxAnimusxX for showing me a couple of errors.   
// Vehicle Crew and Target HUD for ARMA 3. Should work with ARMA 2 with a change of icon path for driver, gunner and cargo.
// For use with script download from  http://www.armaholic.com/page.php?id=20121    save and replace crew.sqf
// Original author - http://forums.bistudio.com/member.php?93598-marker
// Last Modified by PR9INICHEK(25.11.14)


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
				if (
				(driver _vehicle == _x) ||
				(_vehicle turretUnit [0] == _x) ||
				(_vehicle turretUnit [1] == _x) ||
				(_vehicle turretUnit [2] == _x) ||
				(_vehicle turretUnit [3] == _x) ||
				(_vehicle turretUnit [4] == _x) ||
				(_vehicle turretUnit [5] == _x) ||
				(_vehicle turretUnit [6] == _x) ||
				(_vehicle turretUnit [7] == _x) ||
				(_vehicle turretUnit [8] == _x) ||
				(_vehicle turretUnit [9] == _x)
				) then {    
					if((driver _vehicle == _x) || (_vehicle turretUnit [0] == _x)) then {
						_name = format ["<t size='0.85' color='#f0e68c'>%1<img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getinpilot_ca.paa'/> %2</t><br/>", _name, (name _x)];
					}
					else {
						_name = format ["<t size='0.85' color='#f0e68c'>%1<img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/> %2</t><br/>", _name, (name _x)];
					};
				}
				else {
					_name = format ["<t size='0.85' color='#f0e68c'>%1<img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa'/> %2</t><br/>", _name, (name _x)];
					};
			} forEach crew _vehicle;
		}
		//Other vehicles
		else {
			{
				if ((driver _vehicle == _x) || (gunner _vehicle == _x)) then {    
					if(driver _vehicle == _x) then {
						_name = format ["<t size='0.85' color='#f0e68c'>%1<img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getindriver_ca.paa'/> %2</t><br/>", _name, (name _x)];
					}
					else {
						_name = format ["<t size='0.85' color='#f0e68c'>%1<img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa'/> %2</t><br/>", _name, (name _x)];
					};
				}
				else {
					if(commander _vehicle == _x) then {
						_name = format ["<t size='0.85' color='#f0e68c'>%1<img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getincommander_ca.paa'/> %2</t><br/>", _name, (name _x)];	
					}
					else {
						_name = format ["<t size='0.85' color='#f0e68c'>%1<img size='0.8' color='#FF9D00' image='a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa'/> %2</t><br/>", _name, (name _x)];
					};
				};
			} forEach crew _vehicle;
		};
      	_HudNames ctrlSetStructuredText parseText _name;
      	_HudNames ctrlCommit 0;
    };
    sleep 1;
};  
  