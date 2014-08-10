

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [1];
"dynamicBlur" ppEffectCommit 1;

"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [0.8, 15, 0, [0.5, 0.5, 0.5, 0], [0.0, 0.0, 0.6, 2],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 0.4;
 
"dynamicBlur" ppEffectAdjust [0.5];
"dynamicBlur" ppEffectCommit 3;

0 setOvercast 0;
sleep 0.1;

_xHandle = []spawn
{
	Sleep 1;
	"colorCorrections" ppEffectAdjust [1.0, 0.5, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];
	"colorCorrections" ppEffectCommit 2;
};


"dynamicBlur" ppEffectAdjust [2];
"dynamicBlur" ppEffectCommit 1;

"dynamicBlur" ppEffectAdjust [0.5];
"dynamicBlur" ppEffectCommit 4;

_light setLightBrightness 100000.0;

sleep 4.5;

"colorCorrections" ppEffectAdjust [1, 1, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 1; "colorCorrections" ppEffectEnable TRUE;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 1;