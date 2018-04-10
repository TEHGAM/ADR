/*
Author: BACONMOP
usage:
0:position to spawn
*/
params ["_billBoard"];
_imageList = [1,2,4,5,6,7,8];
_bill1 = _imageList call BIS_fnc_selectRandom;
if (_bill1 == 1) then {_billBoard setObjectTexture [0,"media\Billboards\grenade.paa"]};
if (_bill1 == 2) then {_billBoard setObjectTexture [0,"media\Billboards\pilots.paa"]};
if (_bill1 == 4) then {_billBoard setObjectTexture [0,"media\Billboards\report.paa"]};
if (_bill1 == 5) then {_billBoard setObjectTexture [0,"media\Billboards\steam.paa"]};
if (_bill1 == 6) then {_billBoard setObjectTexture [0,"media\Billboards\TEAMKill.paa"]};
if (_bill1 == 7) then {_billBoard setObjectTexture [0,"media\Billboards\teamspeak.paa"]};
if (_bill1 == 8) then {_billBoard setObjectTexture [0,"media\Billboards\website.paa"]};
