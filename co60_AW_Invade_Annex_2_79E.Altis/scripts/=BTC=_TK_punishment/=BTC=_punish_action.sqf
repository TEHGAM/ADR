_id = _this select 2;
_array = _this select 3;
_name = _array select 0;
BTC_tk_PVEH = [_name,name player];
publicVariable "BTC_tk_PVEH";
hint format ["%1 СѓР±РёР» %2, Р·Р° С‡С‚Рѕ Рё Р±С‹Р» РЅР°РєР°Р·Р°РЅ",_name, name player];
player removeAction _id;
