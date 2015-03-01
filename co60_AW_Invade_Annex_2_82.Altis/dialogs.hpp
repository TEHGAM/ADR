class Box
{
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 2;
    colorBackground[] = { 0.2,0.9,0.5, 0.9};
    colorText[] = {1,1,1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
    text = "";
};

class AW_INTRO
{
	idd=-1;
	movingenable=false;
	
	class controls 
	{
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by BACONMOP, v1.063, #Murapy)
////////////////////////////////////////////////////////

class Rules_box: RscFrame
{
	idc = 1800;
	x = 1;
	y = 0;
	w = 0.725;
	h = 1;
};
class Rules_background: Box
{
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 2;
    colorBackground[] = { 0.1,0.1,0.1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
	x = 1;
	y = 0;
	w = 0.725;
	h = 1;
};
class Rules_Header: RscText
{
	idc = 1000;
	text = "Rules"; //--- ToDo: Localize;
	x = 1.175;
	y = 0.02;
	w = 0.125;
	h = 0.08;
	SizeEx = 0.05400;
	colorText[] = {.9,.1,.1,.9};
};
class Rule_1: RscText
{
	idc = 1001;
	text = "1. Hacking and mission exploitation will not be tolerated.  "; //--- ToDo: Localize;
	x = 1;
	y = 0.1;
	w = 0.6875;
	h = 0.08;
	SizeEx = 0.03700;
};
class Rule_2: RscText
{
	idc = 1002;
	text = "2. Intentional team-killing will not be tolerated.  "; //--- ToDo: Localize;
	x = 1;
	y = 0.18;
	w = 0.6125;
	h = 0.1;
	SizeEx = 0.03700;
};
class Rule_3: RscText
{
	idc = 1003;
	text = "3. Excessive, unintentional team-killing may result in a Kick/Ban.  "; //--- ToDo: Localize;
	x = 1;
	y = 0.28;
	w = 0.6875;
	h = 0.08;
	SizeEx = 0.03700;
};
class Rule_4: RscText
{
	idc = 1004;
	text = "4. Unnecessary destruction of BLUFOR vehicles will not be tolerated.  "; //--- ToDo: Localize;
	x = 1;
	y = 0.36;
	w = 0.7;
	h = 0.08;
	SizeEx = 0.03700;
};
class Rule_5: RscText
{
	idc = 1005;
	text = "5. Verbal abuse and bullying will not be tolerated.  "; //--- ToDo: Localize;
	x = 1;
	y = 0.44;
	w = 0.6375;
	h = 0.1;
	SizeEx = 0.03700;
};
class Rule_6: RscText
{
	idc = 1006;
	text = "6. Firing a weapon on base may result in a Kick/Ban.  "; //--- ToDo: Localize;
	x = 1;
	y = 0.52;
	w = 0.5875;
	h = 0.1;
	SizeEx = 0.03700;
};
class Rule_7: RscText
{
	idc = 1007;
	text = "7. Griefing and obstructive play will not be tolerated.  "; //--- ToDo: Localize;
	x = 1;
	y = 0.6;
	w = 0.7125;
	h = 0.1;
	SizeEx = 0.03700;
};
class Rule_8: RscText
{
	idc = 1008;
	text = "8. Excessive mic spamming will not be tolerated.  "; //--- ToDo: Localize;
	x = 1;
	y = 0.68;
	w = 0.6;
	h = 0.1;
	SizeEx = 0.03700;
};
class Rule_9: RscText
{
	idc = 1009;
	text = "9. A server moderator or admin's word is final."; //--- ToDo: Localize;
	x = 1;
	y = 0.78;
	w = 0.675;
	h = 0.1;
	SizeEx = 0.03700;
};
class Rule_10: RscText
{
	idc = 1010;
	text = "10. Landing inside of the HQ may result in a warning or kick.  "; //--- ToDo: Localize;
	x = 1;
	y = 0.88;
	w = 0.725;
	h = 0.08;
	SizeEx = 0.03700;
};
class AW_Intro_and_TS_picture: RscPicture
{
	idc = 1200;
	text = "media\images\Aw_Intro_Image.paa";
	x = 0;
	y = 0;
	w = 1;
	h = 1;
};
class Ok_button: RscButton
{
	idc = 1600;
	text = "Ok, Cool. Please make this box disappear"; //--- ToDo: Localize;
	x = 0;
	y = 1;
	w = 1;
	h = 0.1;
	action = "closedialog 0";
};
class General_hints: RscFrame
{
	idc = 1801;
	x = -0.713889;
	y = 0.00208756;
	w = 0.7125;
	h = 1;
	colorBackground[] = {1,1,1,1};
};
class hINTS_background: Box
{
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 2;
    colorBackground[] = { 0.1,0.1,0.1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
	x = -0.713889;
	y = 0.00208756;
	w = 0.7125;
	h = 1;
};
class Genreal_hints_Header: RscText
{
	idc = 1011;
	text = "Some Hints and Tips"; //--- ToDo: Localize;
	x = -0.525;
	y = 0.02;
	w = 0.5;
	h = 0.08;
	SizeEx = 0.05400;
	colorText[] = {.9,.1,.1,.9};
};
class Hint_1: RscText
{
	idc = 1012;
	text = "Support elements should be on standby until called in."; //--- ToDo: Localize;
	x = -0.65;
	y = 0.1;
	w = 0.6375;
	h = 0.08;
	SizeEx = 0.03700;
};
class Hint_2: RscText
{
	idc = 1013;
	text = "Got a question? Look at our FAQ on the map."; //--- ToDo: Localize;
	x = -0.625;
	y = 0.18;
	w = 0.575;
	h = 0.08;
	SizeEx = 0.03700;
};
class Hint_3: RscText
{
	idc = 1014;
	text = "Zues players may be on but that doesn't mean they killed you."; //--- ToDo: Localize;
	x = -0.6875;
	y = 0.26;
	w = 0.6625;
	h = 0.06;
	SizeEx = 0.03700;
};
class Hint_5: RscText
{
	idc = 1015;
	text = "Found a bug? Post it on our forums. Ahoyworld.Co.uk"; //--- ToDo: Localize;
	x = -0.65;
	y = 0.34;
	w = 0.5625;
	h = 0.08;
	SizeEx = 0.03700;
};
class Hint_6: RscText
{
	idc = 1016;
	text = "Looking for a squad? Join us on Teamspeak."; //--- ToDo: Localize;
	x = -0.6125;
	y = 0.42;
	w = 0.4875;
	h = 0.06;
	SizeEx = 0.03700;
};
class Hint_7: RscText
{
	idc = 1016;
	text = "Pilots should be on Teamspeak."; //--- ToDo: Localize;
	x = -0.55;
	y = 0.50;
	w = 0.4875;
	h = 0.06;
	SizeEx = 0.03700;
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

	
};
};

