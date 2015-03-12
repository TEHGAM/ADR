﻿// by Xeno
#include "x_setup.sqf"
#include "define.hpp"

class XD_SquadManagementDialog {
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable ['X_SQUADMANAGEMENT_DIALOG', _this select 0];d_squadmanagement_dialog_open = true;call d_fnc_squadmanagementfill";
	onUnLoad = "uiNamespace setVariable ['X_SQUADMANAGEMENT_DIALOG', nil];d_SQMGMT_grps = nil;d_squadmanagement_dialog_open = false";
	class controlsBackground {
		class XD_BackGround : RscBG {
			x = "SafeZoneXAbs";
			y = "SafeZoneY";
			w = "safeZoneWAbs";
			h = "SafeZoneH";
			colorBackground[] = {0.106, 0.133, 0.102, 0.9};
		};
	};
	class controls {
		class XD_MainCaption : XC_RscText {
			x = "SafeZoneX + 0.02";
			y = "SafeZoneY + 0.01";
			w = 0.25;
			h = 0.1;
			sizeEx = 0.035;
			colorBackground[] = {1, 1, 1, 0};
			XCMainCapt;
			text = "$STRD_squadm";
		};
		class Dom2 : XD_MainCaption {
			x = "SafeZoneX + 0.05";
			y = "SafeZoneY + SafeZoneH - 0.1";
			XCMainCapt;
			text = "";
		};
		class GroupsControlsGroup : XD_RscControlsGroup {
			x = "SafeZoneX + 0.02";
			y = "SafeZoneY + 0.1";
			w = "SafeZoneW - 0.05";
			h = "SafeZoneH - 0.2";
			__EXEC(bgidc = 1000)
			__EXEC(lbidc = 2000)
			__EXEC(buidc = 3000)
			__EXEC(txtidc = 4000)
			__EXEC(butnum = 5000)
			__EXEC(lockpicidc = 6000)
			__EXEC(lockbutidc = 7000)
			__EXEC(lockbutnum = 7000)
			class Controls {
				class BackGround0 : SXRscText {
					idc = __EVAL(bgidc);
					__EXEC(xposbg = 0.005)
					x = __EVAL(xposbg);
					__EXEC(yposbg = 0.005)
					y = __EVAL(yposbg);
					w = 0.4;
					h = 0.39;
					colorBackground[] = {0,0,0,0.3};
					text = "";
				};
				class GroupListBox0 : SXRscListBox {
					idc = __EVAL(lbidc);
					__EXEC(xposlb = 0.025)
					x = __EVAL(xposlb);
					__EXEC(yposlb = 0.06)
					y = __EVAL(yposlb);
					w = 0.35;
					h = 0.265;
					__EXEC(_numlbstr = str lbidc)
					onLBSelChanged = __EVAL("[" + _numlbstr + ",_this] call d_fnc_squadmgmtlbchanged");
					onKillFocus = __EVAL("[" + _numlbstr + ",_this] call d_fnc_squadmgmtlblostfocus");
				};
			/*	class LeaveJoinButton0 : XD_ButtonBase {
					idc = __EVAL(buidc);
					__EXEC(xposbu = 0.251)
					x = __EVAL(xposbu);
					__EXEC(yposbu = 0.3445)
					y = __EVAL(yposbu);
					text = "$STRD_Join";
					w = 0.15;
					colorFocused[] = { 1, 1, 1, 1 };
					colorBackgroundFocused[] = { 1, 1, 1, 0 };
					__EXEC(_numbstr = str butnum)
					action = __EVAL(_numbstr + " call d_fnc_squadmgmtbuttonclicked");
				}; */
				class GroupText0 : SXRscText {
					idc = __EVAL(txtidc);
					__EXEC(xpostxt = 0.025)
					x = __EVAL(xpostxt);
					__EXEC(ypostxt = 0.017)
					y = __EVAL(ypostxt);
					w = 0.3;
					h = 0.03;
					sizeEx = 0.023;
					shadow = 0;
					text = "$STRD_namegroup";
				};
				class LockPic0: XD_RscPicture {
					idc = __EVAL(lockpicidc);
					__EXEC(xposlockpic = 0.016)
					x = __EVAL(xposlockpic);
					__EXEC(yposlockpic = 0.345)
					y = __EVAL(yposlockpic);
					w = 0.038;
					h = 0.038;
					text = "\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\sessions_locked_ca.paa";
				};
				class LockButton0 : XD_LinkButtonBase {
					idc = __EVAL(lockbutidc);
					style = ST_LEFT;
					__EXEC(xposlockbu = 0.05)
					x = __EVAL(xposlockbu);
					__EXEC(yposlockbu = 0.32)
					y = __EVAL(yposlockbu);
					text = "$STRD_locked";
					__EXEC(_lnumbstr = str lockbutnum)
					action = __EVAL(_lnumbstr + " call d_fnc_squadmgmtlockbuttonclicked");
				};
				
				//------------------------
				class LeaveJoinButton0 : XD_LinkButtonBase {
					idc = __EVAL(buidc);
					__EXEC(xposbu = 0.251)
					//__EXEC(xposlockbu = 0.05)
					x = __EVAL(xposbu);
					//__EXEC(yposbu = 0.3445)
					__EXEC(yposbu = 0.32)
					y = __EVAL(yposbu);
					text = "$STRD_Join";
					//w = 0.15;
					//colorFocused[] = { 1, 1, 1, 1 };
					//colorBackgroundFocused[] = { 1, 1, 1, 0 };
					__EXEC(_numbstr = str butnum)
					action = __EVAL(_numbstr + " call d_fnc_squadmgmtbuttonclicked");
				};
				//---------------------------
				
				
				#define NewControl(tname,xplus,yplus) \
				class BackGround##tname : BackGround0 { \
					__EXEC(bgidc = bgidc + 1) \
					idc = __EVAL(bgidc); \
					__EXEC(xposbg = xposbg + xplus) \
					x = __EVAL(xposbg); \
					__EXEC(yposbg = yposbg + yplus) \
					y = __EVAL(yposbg); \
				}; \
				class GroupListBox##tname : GroupListBox0 { \
					__EXEC(lbidc = lbidc + 1) \
					idc = __EVAL(lbidc); \
					__EXEC(xposlb = xposlb + xplus) \
					x = __EVAL(xposlb); \
					__EXEC(yposlb = yposlb + yplus) \
					y = __EVAL(yposlb); \
					__EXEC(_numlbstr = str lbidc) \
					onLBSelChanged = __EVAL("[" + _numlbstr + ",_this] call d_fnc_squadmgmtlbchanged"); \
					onKillFocus = __EVAL("[" + _numlbstr + ",_this] call d_fnc_squadmgmtlblostfocus"); \
				}; \
				class LeaveJoinButton##tname : LeaveJoinButton0 { \
					__EXEC(buidc = buidc + 1) \
					idc = __EVAL(buidc); \
					__EXEC(xposbu = xposbu + xplus) \
					x = __EVAL(xposbu); \
					__EXEC(yposbu = yposbu + yplus) \
					y = __EVAL(yposbu); \
					__EXEC(butnum = butnum + 1) \
					__EXEC(_numbstr = str butnum) \
					action = __EVAL(_numbstr + " call d_fnc_squadmgmtbuttonclicked"); \
				}; \
				class GroupText##tname : GroupText0 { \
					__EXEC(txtidc = txtidc + 1) \
					idc = __EVAL(txtidc); \
					__EXEC(xpostxt = xpostxt + xplus) \
					x = __EVAL(xpostxt); \
					__EXEC(ypostxt = ypostxt + yplus) \
					y = __EVAL(ypostxt); \
				}; \
				class LockPic##tname: LockPic0 { \
					__EXEC(lockpicidc = lockpicidc + 1) \
					idc = __EVAL(lockpicidc); \
					__EXEC(xposlockpic = xposlockpic + xplus) \
					x = __EVAL(xposlockpic); \
					__EXEC(yposlockpic = yposlockpic + yplus) \
					y = __EVAL(yposlockpic); \
				}; \
				class LockButton##tname : LockButton0 { \
					__EXEC(lockbutidc = lockbutidc + 1) \
					idc = __EVAL(lockbutidc); \
					__EXEC(xposlockbu = xposlockbu + xplus) \
					x = __EVAL(xposlockbu); \
					__EXEC(yposlockbu = yposlockbu + yplus) \
					y = __EVAL(yposlockbu); \
					__EXEC(lockbutnum = lockbutnum + 1) \
					__EXEC(_lnumbstr = str lockbutnum) \
					action = __EVAL(_lnumbstr + " call d_fnc_squadmgmtlockbuttonclicked"); \
				};
				
				NewControl(1,0.47,0);
				NewControl(2,0.47,0);
				NewControl(3,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				NewControl(4,0,0.45);
				NewControl(5,0.47,0);
				NewControl(6,0.47,0);
				NewControl(7,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				NewControl(8,0,0.45);
				NewControl(9,0.47,0);
				NewControl(10,0.47,0);
				NewControl(11,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				NewControl(12,0,0.45);
				NewControl(13,0.47,0);
				NewControl(14,0.47,0);
				NewControl(15,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				NewControl(16,0,0.45);
				NewControl(17,0.47,0);
				NewControl(18,0.47,0);
				NewControl(19,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				NewControl(20,0,0.45);
				NewControl(21,0.47,0);
				NewControl(22,0.47,0);
				NewControl(23,0.47,0);
				
				__EXEC(xposbg = 0.005)
				__EXEC(xposlb = 0.025)
				__EXEC(xposbu = 0.251)
				__EXEC(xpostxt = 0.025)
				__EXEC(xposlockpic = 0.016)
				__EXEC(xposlockbu = 0.05)
				NewControl(24,0,0.45);
				NewControl(25,0.47,0);
				NewControl(26,0.47,0);
				NewControl(27,0.47,0);
			};
		};
		class XD_CloseButton: XD_ButtonBase {
			idc = 9999;
			text = "$STRD_Quit"; 
			action = "closeDialog 0";
			default = true;
			x = "SafeZoneX + SafeZoneW - 0.3";
			y = "SafeZoneY + SafeZoneH - 0.07";
			colorFocused[] = { 1, 1, 1, 1 };
			colorBackgroundFocused[] = { 1, 1, 1, 0 };
		};
	};
};
