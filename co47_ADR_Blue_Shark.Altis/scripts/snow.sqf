_cc = ppEffectCreate ["colorCorrections", 1550];
_cc ppEffectEnable true;
_cc ppEffectAdjust [1.0, 1.1, -0.025, [0.1, 0.1, 0.5, 0.125], [0.88, 0.88, 1.00, 0.85], [0.299, 0.587, 0.114, 0]];
_cc ppEffectCommit 0;

_velocity = [((wind select 0) / 4.0), ((wind select 1) / 4.0), -10];

objEmitterHost = "Land_Bucket_F" createVehicleLocal (position player);
objEmitterHost attachTo [player,[0,0,0]];
objEmitterHost hideObject true;
objEmitterHost allowDamage false;
objEmitterHost enableSimulation false;

private ["_pos","_color","_obj"];
_pos = position objEmitterHost;
_obj = objEmitterHost;
_color = [[1, 1, 1, 0.75],[1, 1, 1, 1]];
flurry_parent = "#particleSource" createVehicleLocal _pos;
flurry_parent setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,12,[0,0,12],_velocity,(.7),.1375,.10,0.4,[.04],_color,[1000],.7,.3,"","",_obj];
flurry_parent setParticleCircle [0,[0,0,0]];
flurry_parent setParticleRandom [0,[15,15,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];
flurry_parent setDropInterval 0.004;

flurry_front = "#particleSource" createVehicleLocal _pos;
flurry_front setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,12,[0,45,10],_velocity,(.7),.1375,.10,0.4,[.04],_color,[1000],.7,.3,"","",_obj];
flurry_front setParticleCircle [0,[0,0,0]];
flurry_front setParticleRandom [0,[20,20,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];
flurry_front setDropInterval 0.004;

flurry_rear = "#particleSource" createVehicleLocal _pos;
flurry_rear setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,12,[0,-45,10],_velocity,(.7),.1375,.10,0.4,[.04],_color,[1000],.7,.3,"","",_obj];
flurry_rear setParticleCircle [0,[0,0,0]];
flurry_rear setParticleRandom [0,[15,15,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];
flurry_rear setDropInterval 0.004;

flurry_right = "#particleSource" createVehicleLocal _pos;
flurry_right setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,12,[45,0,10],_velocity,(.7),.1375,.10,0.4,[.04],_color,[1000],.7,.3,"","",_obj];
flurry_right setParticleCircle [0,[0,0,0]];
flurry_right setParticleRandom [0,[20,20,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];
flurry_right setDropInterval 0.004;

flurry_left = "#particleSource" createVehicleLocal _pos;
flurry_left setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,12,[-45,0,10],_velocity,(.7),.1375,.10,0.4,[.04],_color,[1000],.7,.3,"","",_obj];
flurry_left setParticleCircle [0,[0,0,0]];
flurry_left setParticleRandom [0,[20,20,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];
flurry_left setDropInterval 0.004;
