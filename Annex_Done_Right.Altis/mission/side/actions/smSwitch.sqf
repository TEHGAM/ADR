/*
 Author:
 Quiksilver

 Description:
 Actioning the character triggers mission cycle.
*/

if (SM_SWITCH) exitWith
{
  hint "Дополнительные задания определяются. Ждите дальнейших указаний."
};

//Send hint to player that he's planted the bomb
hint "Дополнительное задание выявлено, ждите подробных инструкций.";

sleep 1;

SM_SWITCH = true; publicVariable "SM_SWITCH";
