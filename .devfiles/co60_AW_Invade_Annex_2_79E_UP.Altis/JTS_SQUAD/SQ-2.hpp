#define JTS_CT_STATIC			0
#define JTS_CT_EDIT			2
#define JTS_CT_COMBO			4
#define JTS_CT_ACTIVETEXT       	11

#define JTS_ST_LEFT			0x00
#define JTS_ST_SINGLE			0
#define JTS_ST_MULTI			16
//#define ST_WITH_RECT			160
#define JTS_ST_NO_RECT			0x200

#define JTS_FontM			"PuristaMedium"
#define JTS_FontTitle			"PuristaBold"

class JTS_GUI_Group
{
	type = 0;
	idc = -1;
	style = 128;
	colorText[] = {1,1,1,1};
	font = JTS_FontM;
	sizeEx = 0.04;
	shadow = 0;

	colorbackground[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',1])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',1])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
	};
};

class JTS_GroupButton
{
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	font = JTS_FontM;

	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";

	colorBackground[] = {0,0,0,0.8};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};

	soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};

	w = 0.095 * SafeZoneW;
	h = 0.03 * SafeZoneH;

	class TextPos
	{
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0;
	};

	class Attributes
	{
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};

	class ShortcutPos
	{
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};

	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
};

class JTS_GroupActiveText
{
	access = ReadAndWrite;
	type = JTS_CT_ACTIVETEXT;
	style = JTS_ST_LEFT;
	font = JTS_FontTitle;
	sizeEx = 0.06;
	text = "";
	default = 0;

	color[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};

	colorActive[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',1])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',1])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',1])"
	};
	
	soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};

	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class JTS_GroupEdit
{
	access = ReadAndWrite;
	type = 2;

	colorBackground[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {0.95,0.95,0.95,1};

	colorSelection[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
		1
	};

	autocomplete = "";
	text = "";
	size = 0.2;
	style = "0x00 + 0x40";
	font = "PuristaMedium";
	shadow = 2;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	canModify = 1;

	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class JTS_GroupText
{
	type = JTS_CT_STATIC;
	style = JTS_ST_LEFT;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0, 0, 0, 0};
	font = JTS_FontTitle;
	sizeEx = 0.05;
};

class JTS_GroupTextInfo: JTS_GroupText
{
	font = JTS_FontM;
	sizeEx = 0.04;
};

class JTS_GroupCombo
{
	style = 0x10 + 0x200;
	access = ReadAndWrite;
	type = JTS_CT_COMBO;
	maxHistoryDelay = 1;
	wholeHeight = 0.44 * SafeZoneH;
	font = JTS_FontM;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

	colorSelect[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,0.7};
	colorDisabled[] = {1,1,1,0.25};

	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
	soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};

	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";

	class ComboScrollBar
	{
		autoScrollEnabled = 1;
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};

class JTS_Squad
{
	idd = -1;
	movingEnable = false;
	controlsBackground[] = {JTS_G,JTS_G2,PLAYERS_T,GROUPS_T,JTS_PRIVACY,JTS_SM};

	class JTS_G: JTS_GroupText
	{
		idc = -1;
		moving = 1;
 		text = ;
		colorBackground[] = {0, 0, 0, 0.75};
 		x = 0.15 * SafeZoneW + SafeZoneX;
 		y = 0.2 * SafeZoneH + SafeZoneY;
 		w = 0.695 * SafeZoneW;
 		h = 0.5 * SafeZoneH;
	};

	class JTS_G2: JTS_GroupText
	{
		idc = 0008;
		moving = 0;
 		text = ;
		colorBackground[] = {0, 0, 0, 0.75};
 		x = 0.15 * SafeZoneW + SafeZoneX;
 		y = 0.77 * SafeZoneH + SafeZoneY;
 		w = 0.45 * SafeZoneW;
 		h = 0.08 * SafeZoneH;
	};

	class PLAYERS_T: JTS_GroupActiveText
	{
		idc = -1;
		text = "Игроки";
		toolTip = "Дать лидера этому игроку";
		action = "lbValue [0002, lbCursel 0002] spawn JTS_FNC_LEADERSHIP";
		x = 0.3975 * SafeZoneW + SafeZoneX;
		y = 0.2 * SafeZoneH + SafeZoneY;
		w = 0.399 * SafeZoneW;
		h = 0.06 * SafeZoneH;
	};

	class GROUPS_T: JTS_GroupActiveText
	{
		idc = -1;
		text = "Отряд";
		toolTip = "Отправить запрос на статус этого игрока";
		action = "lbValue [0001, lbCursel 0001] spawn JTS_FNC_STATUS";
		x = 0.16 * SafeZoneW + SafeZoneX;
		y = 0.2 * SafeZoneH + SafeZoneY;
		w = 0.24 * SafeZoneW;
		h = 0.06 * SafeZoneH;
	};

	class JTS_PRIVACY: JTS_GroupActiveText
	{
		idc = -1;
		text = "Приватность";
		toolTip = "Разрешить/запретить игрокам запрашивать ваш статус";
		action = "[] spawn JTS_FNC_REQUESTS";
		x = 0.635 * SafeZoneW + SafeZoneX;
		y = 0.2 * SafeZoneH + SafeZoneY;
		w = 0.24 * SafeZoneW;
		h = 0.06 * SafeZoneH;
	};

	class JTS_SM: JTS_GUI_Group
	{
		idc = -1;
		moving = 1;
		text = "Менеджер отрядов";
		x = 0.15 * SafeZoneW + SafeZoneX;
		y = 0.167 * SafeZoneH + SafeZoneY;
		w = 0.695 * SafeZoneW;
		h = 0.03 * SafeZoneH;
	};

	controls[] = {GROUP,PLAYERS,INFO_TEXT,EDIT,ACTION,DESC_TEXT,INVITE,BUT1,BUT2,BUT3,BUT4,BUT5,BUT6,BUT7}; 

	class GROUP: JTS_GroupCombo
	{
		idc = 0001;
		onLBSelChanged = "lbValue [0001, lbCursel 0001] call JTS_FNC_PLAYERS;[[0003,true,true,''],[0004, false,false,''],[0005,false,false,''],[0008,true,false,'']] call JTS_FNC_SWITCH";
		x = 0.16 * SafeZoneW + SafeZoneX;
		y = 0.27 * SafeZoneH + SafeZoneY;
		w = 0.2 * SafeZoneW;
		h = 0.03 * SafeZoneH;

	};

	class PLAYERS: JTS_GroupCombo
	{
		idc = 0002;
		x = 0.3975 * SafeZoneW + SafeZoneX;
		y = 0.27 * SafeZoneH + SafeZoneY;
		w = 0.2 * SafeZoneW;
		h = 0.03 * SafeZoneH;

	};

	class INFO_TEXT: JTS_GroupTextInfo
	{
		idc = 0003;
		text = "";
		sizeEx = 0.06;
		style = JTS_ST_SINGLE + JTS_ST_NO_RECT;
		x = 0.16 * SafeZoneW + SafeZoneX;
		y = 0.785 * SafeZoneH + SafeZoneY;
		w = 0.24 * SafeZoneW;
		h = 0.045 * SafeZoneH;
	};

	class EDIT: JTS_GroupEdit
	{
		idc = 0004;
		text = "";
		tooltip = "Допустимые символы: a-z, A-Z, 0-9";
		x = 0.395 * SafeZoneW + SafeZoneX;
		y = 0.786 * SafeZoneH + SafeZoneY;
		w = 0.2 * SafeZoneW;
		h = 0.05 * SafeZoneH;
	};

	class ACTION: JTS_GroupButton
	{
		idc = 0005;
		text = "Принять";
		action = "";
		x = 0.15 * SafeZoneW + SafeZoneX;
		y = 0.855 * SafeZoneH + SafeZoneY;
	};

	class DESC_TEXT: JTS_GroupTextInfo
	{
		idc = 0006;
		style = JTS_ST_SINGLE + JTS_ST_MULTI + JTS_ST_NO_RECT;
		linespacing = 1;
		text = "";
		x = 0.155 * SafeZoneW + SafeZoneX;
		y = 0.32 * SafeZoneH + SafeZoneY;
		w = 0.65 * SafeZoneW;
		h = 0.34 * SafeZoneH;
	};

	class INVITE: JTS_GroupCombo
	{
		idc = 0007;
		onLBSelChanged = "player setVariable ['JTS_INVITES', lbValue [0007, lbCursel 0007], true]";
		x = 0.635 * SafeZoneW + SafeZoneX;
		y = 0.27 * SafeZoneH + SafeZoneY;
		w = 0.2 * SafeZoneW;
		h = 0.03 * SafeZoneH;

	};
	
	class BUT1: JTS_GroupButton
	{
		idc = 0009;
		text = "Присоединиться";
		toolTip = "Присоединиться к выбранному отряду";
		action = "[lbValue [0001, lbCursel 0001],0] spawn JTS_FNC_JOIN";
		x = 0.15 * SafeZoneW + SafeZoneX;
		y = 0.705 * SafeZoneH + SafeZoneY;
	};
	
	class BUT2: JTS_GroupButton
	{
		idc = 0010;
		text = "Покинуть";
		toolTip = "Покинуть отряд и стать лидером";
		action = "[] spawn JTS_FNC_LEAVE";
		x = 0.25 * SafeZoneW + SafeZoneX;
		y = 0.705 * SafeZoneH + SafeZoneY;

	};

	class BUT3: JTS_GroupButton
	{
		idc = 0011;
		text = "Пригласить";
		toolTip = "Пригласить выбранного игрока в свой отряд";
		action = "lbValue [0001, lbCursel 0001] spawn JTS_FNC_INVITE";
		x = 0.35 * SafeZoneW + SafeZoneX;
		y = 0.705 * SafeZoneH + SafeZoneY;
	};

	class BUT4: JTS_GroupButton
	{
		idc = 0012;
		text = "Блок";
		toolTip = "Блокировать свой отряд паролем. Допустимые символы: a-z, A-Z, 0-9. Чтобы удалить пароль, оставьте поле ввода пустым";
		action = "'Create' spawn JTS_FNC_PASSWORD";
		x = 0.45 * SafeZoneW + SafeZoneX;
		y = 0.705 * SafeZoneH + SafeZoneY;

	};

	class BUT5: JTS_GroupButton
	{
		idc = 0013;
		text = "Выгнать";
		toolTip = "Выгнать выбранного игрока из списка. Вы не можете выгнать игрока если вы не лидер";
		action = "lbValue [0002, lbCursel 0002] spawn JTS_FNC_KICK";
		x = 0.55 * SafeZoneW + SafeZoneX;
		y = 0.705 * SafeZoneH + SafeZoneY;

	};

	class BUT6: JTS_GroupButton
	{
		idc = 0014;
		text = "Обновить";
		toolTip = "Обновить сисок отрядов";
		action = "[] spawn JTS_FNC_ADD";
		x = 0.65 * SafeZoneW + SafeZoneX;
		y = 0.705 * SafeZoneH + SafeZoneY;

	};


	class BUT7: JTS_GroupButton
	{
		idc = -1;
		text = "Закрыть";
		toolTip = "Выйти из этого меню и вернуться к игре";
		action = "closedialog 0";
		x = 0.75 * SafeZoneW + SafeZoneX;
		y = 0.705 * SafeZoneH + SafeZoneY;

	};
};