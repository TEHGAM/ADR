//  ZeusPlayerUpdate Loop     //
//scripts\misc\zeusupdater.sqf//
//      MykeyRM [AW]          //
////////////////////////////////

//zeusupdater.sqf

waitUntil {time > 3};
call {

    while {true} do {
    objectsToAdd =
    (entities "AllVehicles" - entities "Animal" - entities "RoadCone_L_F" -
    [
        Quartermaster,Quartermaster_1,Quartermaster_2,Quartermaster_3,Quartermaster_4,Quartermaster_5,
        artyMLRS,artySorcher,
        CVN_CIWS_1,CVN_CIWS_2,CVN_CIWS_3,CVN_RAM,CVN_SAM_2,CVN_SAM_3,Base_AA
    ]);

    publicVariable "objectsToAdd";
    {_x addCuratorEditableObjects [(objectsToAdd), true]; } forEach allCurators;

    sleep 180;

    };

};

//player groupChat "Zeus unit updater running";        //Can have hint that updater is running on startup remove // to activate.
