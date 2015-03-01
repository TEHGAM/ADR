// Author: Quiksilver
// Eject vehicles crew

_v = _this select 0;

{
	_x action ["getOut",_v];
} count (crew _v);