GetTimeAddon = function() -- หากจะเชื่อมเวลาฟาร์มจาก Party ให้ใส่  Progress = nil, ในแต่ละงาน ** ส่งค่าเป็นวิเท่านั้น / 1000 หากรับเป็นหน่วยแบบนี้ 3000 / 1000 = 3 วิ**
    
    local inparty = exports.swift_party:InParty()
    local startparty = exports.swift_party:IsStarted()
    -- print("Inparty?"..tostring(inparty))
    -- print("Started?"..tostring(startparty))


  
    -- local partyID = exports.swift_party:GetPartyID()
    -- print("partyID : ".. partyID)
    -- TriggerServerEvent("RubyEvent:GETPARTY", partyID)


    -- RegisterNetEvent("RubyEvent:RECIEVEPARTY")
    -- AddEventHandler("RubyEvent:RECIEVEPARTY", function(party)
    --     print("Client: RECIEVEPARTY ")
    --     print(party)
    -- end)

    local startparty = exports.swift_party:IsStarted()
    if startparty then
        return 2
    end
    return 10
end 