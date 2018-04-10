/*
* Author: alganthe
* Shuffles the provided array.
*
* Arguments:
* 0: Array to be shuffled <ARRAY>
*
* Return Value:
* Shuffled array
*/
private _cnt = count _this;

for "_i" from 1 to _cnt do {
    _this pushBack (_this deleteAt floor random _cnt);
};

_this
