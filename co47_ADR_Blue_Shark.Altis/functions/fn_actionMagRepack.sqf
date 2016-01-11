_magListFull = magazinesAmmoFull player;
_magList = [];
{
    _currentMag = _x select 0;
    _currentAmmo = _x select 1;
    _currentMagSize = getNumber (configFile >> "CfgMagazines" >> _currentMag >> "count");
    if (_currentMagSize > 1) then {
        if (_x select 3 == -1) then {
            if (count _magList > 0) then {
                _counter = 0;
                for "_x" from ((count _magList) - 1) to 0 step -1 do {
                    if ((_magList select _x) select 0 == _currentMag) then {
                        _magList set [_x, [_currentMag, ((_magList select _x) select 1) + _currentAmmo, ((_magList select _x) select 2) + 1]];
                        _counter = _counter + 1;
                    };
                    if ((_x == 0) and (_counter == 0)) then {
                        _magList pushBack [_currentMag, _currentAmmo, 1];
                    };
                }
            } else {
                _magList pushBack [_currentMag, _currentAmmo, 1];
            };
        };
    };
} forEach _magListFull;

_currentMags = 0;
_newMags = 0;

_stance = stance player;

if (_stance == "STAND") then {
    player switchMove "AinvPercMstpSrasWrflDnon_G01";
};
if (_stance == "CROUCH") then {
    player switchMove "AinvPknlMstpSrasWrflDnon_G01";
};
if (_stance == "PRONE") then {
    player switchMove "AinvPpneMstpSrasWrflDnon_G01";
};

{
    _currentMag = _x select 0;
    _currentAmmo = _x select 1;
    _currentMagSize = getNumber (configFile >> "CfgMagazines" >> _currentMag >> "count");
    _magsToAdd = floor (_currentAmmo / _currentMagSize);
    _magsToAddLeft = _currentAmmo - (_magsToAdd * _currentMagSize);
    _currentMags = _currentMags + (_x select 2);
    if (_magsToAdd > 0) then {
        player removeMagazines _currentMag;
        player addMagazines [_currentMag, _magsToAdd];
        _newMags = _newMags + _magsToAdd;
        if (_magsToAddLeft > 0) then {
            player addMagazine [_currentMag, _magsToAddLeft];
            _newMags = _newMags + 1;
        };
    };
} forEach _magList;

systemChat format ["Магазины перепакованы. Было %1, стало %2.", _currentMags, _newMags];
