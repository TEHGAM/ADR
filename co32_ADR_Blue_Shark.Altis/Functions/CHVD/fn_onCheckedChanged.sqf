_state = _this select 0;
_syncVar = _this select 1;
_slider = _this select 2;
_text = _this select 3;
_sliderView = _this select 4;

if (_state == 1) then {
	call compile format ["%1 = true",_syncVar];
	call compile format ["profileNamespace setVariable ['%1',%1]", _syncVar];
	ctrlEnable [_slider, false];
	ctrlEnable [_text, false];
	
	ctrlSetText [_text, str round ((sliderPosition _sliderView) min CHVD_maxObj)];
	sliderSetPosition [_slider, (sliderPosition _sliderView) min CHVD_maxObj];
} else {
	call compile format ["%1 = false",_syncVar];
	call compile format ["profileNamespace setVariable ['%1',%1]", _syncVar];
	ctrlEnable [_slider, true];
	ctrlEnable [_text, true];
};