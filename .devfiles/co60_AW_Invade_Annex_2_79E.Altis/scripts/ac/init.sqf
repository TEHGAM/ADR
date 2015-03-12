	

    private["_uid", "_name", "_query", "_tmp", "_ret", "_data", "_mainGroup", "_otherGroups", "_title"];
     
    _uid = _this select 0;
    _name = _this select 1;
     
    _query = format
    [
            "
                    SELECT
                            ipbmembers.member_group_id,
                            ipbmembers.mgroup_others
                    FROM
                            ipbmembers
                    LEFT JOIN ipbpfields_content
                            ON ipbmembers.member_id = ipbpfields_content.member_id
                    WHERE
                            ipbpfields_content.field_16 = '%1'
                    LIMIT 1
            ",
            _uid
    ];
     
    _tmp = "Arma2Net.Unmanaged" callExtension format["Arma2NETMySQLCommand ['mxegnxzt_ipb', '%1']", _query];
    _ret = call compile _tmp;
     
    if (count _ret > 0 && ((_ret select 0) select 0) select 0 != "Error") then
    {
            _data = (_ret select 0) select 0;
            _mainGroup = parseNumber (_data select 0);
            _otherGroups = toArray((_data select 1));
           
            _title = switch (_mainGroup) do
            {
                    case 8: { "AW Member"; };
                    case 4: { "AW Core Staff Member"; };
                    case 9: { "AW Developer"; };
                    case 6: { "AW Administrator"; };
                    default { "AW Community Member"; };
            };
           
            if (55 in _otherGroups) then { _title = _title + " and Ahoy+ Subscriber"; };
                   
            GlobalHint = format["<t align='center' size='2.2' color='#CE2123'>Ahoy World</t><br/>%1...<br/><t size='1.4'>%2</t><br/>...has joined the server, To get involved in the Ahoy World community, register an account at www.AhoyWorld.co.uk and get stuck in!</t><br/>", _title, _name];
            publicVariable "GlobalHint";
    };

