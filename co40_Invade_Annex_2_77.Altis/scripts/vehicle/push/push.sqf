_boat = _this select 0;
_unit = _this select 1;
_dir = getDir _unit;

_mag = 2;

_x = _mag * (sin _dir);
_y = _mag * (cos _dir);

_boat setVelocity [_x,_y,0];