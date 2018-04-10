/*
Author: Unknown

Description: 
	Gets a punch of params from derp revive about the killer and puts those into a some nice string.  Next prints that string in both sidechat and admin channel.

Last edited: 23/10/2017 by stanhope

edited: renamed variables, switched over to remoteexeccall + syschat instead of the guy standing around. + recording in array
*/

private ["_killedObj","_sourceObj","_projectile","_instigatorObj","_simpleTKMessage","_longTKMessage","_arrayMessage"];

//get params
params ["_killedObj","_sourceObj","_projectile","_instigatorObj"];

//get some additional things for the reporting
private _killedName = name _killedObj;
private _killedVehicle = typeOf (vehicle _killedObj);
private _killedVehicleName = getText( configFile >> "CfgVehicles" >> _killedVehicle >> "DisplayName" );
private _killedUID = getPlayerUID _killedObj;

private _killerName = name _sourceObj;
private _sourceVehicleType = typeOf (vehicle _sourceObj);
private _sourceVehicleName = getText( configFile >> "CfgVehicles" >> _sourceVehicleType >> "DisplayName" );
private _killerUID = getPlayerUID _sourceObj;

private _instigatorName = name _instigatorObj;
private _instigatorObjVehicleType = typeOf (vehicle _instigatorObj);
private _instigatorVehicleName = getText( configFile >> "CfgVehicles" >> _instigatorObjVehicleType >> "DisplayName" );
private _instigatorUID = getPlayerUID _instigatorObj;

//============check what happend to the TKed person================

if (_sourceObj getVariable "isZeus" || _instigatorObj getVariable "isZeus") exitWith {
	if (_sourceObj == _killedObj || _instigatorObj == _killedObj) then{
		/*That zeus killed himself :)*/
		_simpleTKMessage = format["%1 killed himself",_killedName];
		[Quartermaster, _simpleTKMessage] remoteExecCall ["sideChat", 0, false];
	} else {
		_longTKMessage = format["%1 got killed by zeus: %2 (%3).  Weapon used: %4. Vehicle of TKer: %5 (%6)",_killedName,_killerName,_instigatorName,_projectile, _sourceVehicleName,_instigatorVehicleName];
		TKArray pushBack _longTKMessage;
		publicVariable "TKArray";
		[Quartermaster, [adminChannelID, _longTKMessage]] remoteExecCall ["customChat", 0, false];
	};
};

//first see if there is an instigator
if (_instigatorName == "Error: No vehicle") exitWith{

    //check if he killed himself
	if (_killedObj == _sourceObj) then{
		_simpleTKMessage = format["%1 killed himself",_killedName];
		_longTKMessage = format["%1 killed himself with weapon: %2. Vehicle of the TKer: %3",_killedName,_projectile, _sourceVehicleName];
    }else {
    //he didn't kill himself but there is no instigator so he got killed by a vehicle driven by _killer (in 90% of cases)
		_simpleTKMessage = format["%1 teamkilled by someone in %2s vehicle",_killedName,_killerName];
		[_killedName] remoteExecCall ["sendTKhintC", _sourceObj, false];
		_longTKMessage = format["%1 got killed by: %2.  Weapon used: %3. Vehicle of TKer: %4",_killedName,_killerName,_projectile, _sourceVehicleName];
		[] remoteExecCall ["playerTKed", _sourceObj, false];
		
		_arrayMessage = format[
		"The person who got TKed: name: %1, vehicle %2 (%3), UID: %4<br/>
		The Person who did the TKing: name: %5, vehicle %6 (%7), UID: %8<br/>
		Projectile used: %9",
		_killedName, _killedVehicleName ,_killedVehicle, _killedUID,
		_killerName,_sourceVehicleName,_sourceVehicleType, _killerUID,
		_projectile
		];
		TKArray pushBack _arrayMessage;
		publicVariable "TKArray";
    };
		
	[Quartermaster, _simpleTKMessage] remoteExecCall ["sideChat", 0, false];
	[Quartermaster, [adminChannelID, _longTKMessage]] remoteExecCall ["customChat", 0, false];
	
	/*Quartermaster sideChat _simpleTKMessage;
	Quartermaster customChat [adminChannelID, _longTKMessage];*/
 
};
if (_instigatorName != "Error: No vehicle") exitWith {
    //there is an instigator
	
    //the instigator is the person who got killed, can i call him an idiot?
    if (_killedObj == _instigatorObj) then{
		_simpleTKMessage = format["%1 killed himself",_killedName];
		_longTKMessage = format["%1 killed himself with weapon: %2. Vehicle of the TKer: %3",_killedName,_projectile, _instigatorVehicleName];
    }else {
    //this is the most common case, someone got killed by someone else
		_simpleTKMessage = format["%1 teamkilled by %2",_killedName,_instigatorName];
		[_killedName] remoteExecCall ["sendTKhintC", _instigatorObj, false];
		_longTKMessage = format["%1 got killed by: %2.  Weapon used: %3. Vehicle of TKer: %4",_killedName,_instigatorName,_projectile, _instigatorVehicleName];
		[] remoteExecCall ["playerTKed", _instigatorObj, false];
		
		_arrayMessage = format[
		"The Person who did the TKing: name: %5, vehicle %6 (%7)sourceVehicle: %10, UID: %8, Projectile used: %9; The person who got TKed: name: %1, vehicle %2 (%3), UID: %4; ",
		_killedName, _killedVehicleName ,_killedVehicle, _killedUID,
		_killerName,_instigatorVehicleName,_instigatorObjVehicleType, _instigatorUID,
		_projectile, _sourceVehicleType
		];
		
		TKArray pushBack _arrayMessage;
		publicVariable "TKArray";
    };
	
	[Quartermaster, _simpleTKMessage] remoteExecCall ["sideChat", 0, false];
	[Quartermaster, [adminChannelID, _longTKMessage]] remoteExecCall ["customChat", 0, false];
};