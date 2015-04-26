private ['_lightbar','_migalka'];
_obj = _this select 0;
_lightbar = _this select 1;
_migalka = _this select 2;
sleep 0.01;
switch (_lightbar) do {
case 0 : {_obj animate ["HidePolice", 1]};
case 1 : {_obj animate ["HidePolice", 0]};
case 2 : {_obj animate ["HideServices", 0]};
};
switch (_migalka) do {
case 0 : {_obj animate ["BeaconsStart", 1]};
case 1 : {_obj animate ["BeaconsStart", 0]};
};