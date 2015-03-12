/*
@filename: SHK_buildingPos.sqf
Author:

	Shuko of LDD Kyllikki (kyllikki.fi) - tweaked version 0.12 by Quiksilver for I&A 1/07/2014 ArmA 1.22
	
Last Modified:

	14/08/2014 ArmA 1.24 by Quiksilver
	
Description:

	Put units into buildings
	nul = [position,unitArray,radius,priorityposition0=random1=ground2=roof,height,disableMove,stance] execvm "shk_buildingpos.sqf"

_____________________________________________________________________________________*/

private [
	"_obj","_sortArray","_opos","_rad","_bpos","_priority","_tmp","_min",
	"_max","_h","_disableMove","_stance","_taken","_ind","_pos","_dir",
	"_i","_p","_h","_i","_j","_a","_lo","_hi","_x","_id","_sort"
];

//============================================================================== CONFIG

_opos = _this select 0;
_obj = _this select 1;
_rad = if (count _this > 2) then {_this select 2} else {20};
_disableMove = if (count _this > 5) then {_this select 5} else {false};
_stance = if (count _this > 6) then {_this select 6} else {false};
_bpos = [];
_taken = [];

//============================================================================== SORT ARRAY

_sortArray = {
	_sort = {
		_a = _this select 0; 													//array to be sorted
		_id = _this select 1; 													//array item index to be compared
		_lo = _this select 2; 													//lower index to sort from
		_hi = _this select 3; 													//upper index to sort to

		_h = nil;            													//used to make a do-while loop below
		_i = _lo;
		_j = _hi;
		if (count _a == 0) exitWith {};
		_x = (_a select ((_lo+_hi)/2)) select _id;

		while {isNil "_h" || _i <= _j} do {
			while {(_a select _i) select _id < _x} do {
				_i = _i + 1;
			};
			while {(_a select _j) select _id > _x} do {
				_j = _j - 1;
			};
			if (_i <= _j) then {
				_h = _a select _i;
				_a set [_i,_a select _j];
				_a set [_j,_h];

				_i = _i + 1;
				_j = _j - 1;
			};
		};

		if (_lo < _j) then {
			[_a,_id,_lo,_j] call _sort;
		};
		if (_i < _hi) then {
			[_a,_id,_i,_hi] call _sort;
		};
    };
	[_this select 0, _this select 1, 0, 0 max ((count (_this select 0))-1)] call _sort;
	_this select 0;
};

if (typeName _opos == typeName objNull) then {_opos = getPos _opos};

//============================================================================== FIND BUILDINGS

{
    for [{_i = 0;_p = _x buildingPos _i},{str _p != "[0,0,0]"},{_i = _i + 1;_p = _x buildingPos _i}] do {
		_bpos set [count _bpos,_p];
    };
} count (nearestObjects [_opos,["Building"],_rad]);							

//============================================================================== PRIORITY

if (count _this > 3) then {
	_priority = _this select 3;
    _bpos = [_bpos,2] call _sortArray;
} else {
	_priority = 0;
};

//============================================================================== HEIGHT

if (count _this > 4) then {
    if (count (_this select 4) > 0) then {
		_tmp = [];
		_min = (_this select 4) select 0;
		_max = (_this select 4) select 1;
		{
			_h = _x select 2;
			if (_h >= _min && _h <= _max) then { 
				_tmp set [count _tmp,_x]; 
			};
		} count _bpos;
		_bpos = _tmp;
    };
};

//============================================================================== STANCE / MOVEMENT
  
{
	while {count _taken < count _bpos} do {
		switch _priority do {
			case 0: {_ind = floor (random (count _bpos))}; 					// random
			case 1: {_ind = count _taken}; 									// ground floor first
			case 2: {_ind = count _bpos - count _taken - 1}; 				// roof first
		};
     
		if !(_ind in _taken) exitWith {
			_taken set [count _taken,_ind];
			_pos = _bpos select _ind;
			_dir = ((_pos select 0) - (_opos select 0)) atan2 ((_pos select 1) - (_opos select 1));
			if (_dir < 0) then {
				_dir = _dir + 360;
			};
			_x setPos _pos;
			_x setFormDir _dir;
			if (_disableMove) then {
				doStop _x;
			};
			if (_stance) then {
				_x setUnitPos "UP";
				_x allowFleeing 0;
			};
		};
    };
	_x enableAttack FALSE;
} count _obj;