// Author: BACONMOP
// Connects Headless Client

if !(hasInterface && isServer) then {
  HeadlessVariable = true;
  publicVariable "HeadlessVariable";
};