listener = {}

--[[
    ฟังก์ชันนี้จะทำงานเมื่อผู้เล่นต้องการใช้ไอเทม Unjail
    
    ?@param playerId ไอดีของผู้เล่นที่ต้องการใช้ไอเทม
    ?@param minutes จำนวนนาทีที่เหลือก่อนออกจากคุก
    ?@param seconds จำนวนวินาทีที่เหลือก่อนออกจากคุก
]]
listener.PlayerWillUseUnjail = function(playerId, minutes, seconds)
    return true
end

--[[
    ฟังก์ชันนี้จะทำงานเมื่อตำรวจจะทำการ Jail ผูู้เล่น

    ?@param playerId ไอดีของตำรวจ
    ?@param data.id ไอดีของผู้เล่นที่ถูกจับ
    ?@param data.time เวลา
    ?@param data.fine จำนวนค่าปรับ
    ?@param data.summary ข้อหา
]]
listener.PoliceWillJail = function(playerId, targetId, time, fine, summary)
    return true
end

--[[
    ฟังก์ชันนี้จะทำงานเมื่อตำรวจจะทำการ Unjail ผู้เล่น

    ?@param playerId ไอดีของตำรวจ
    ?@param targetId ไอดีของผู้เล่นที่เป็นเป้าหมาย (ที่ต้องการปล่อยตัว)
    ?@param targetData ข้อมูลของเป้าหมาย (เช่น identifier, playerId, name, minutes, seconds)
]]
listener.PoliceWillUnjail = function(playerId, targetId, targetData)
    return true
end