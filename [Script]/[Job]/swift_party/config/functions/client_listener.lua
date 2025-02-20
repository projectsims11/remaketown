listener = {}

-- เมื่อกดสร้างปาร์ตี้
---@param partyId number เลข ID ของปาร์ตี้
---@param name string ชื่อของปาร์ตี้
listener.partyCreated = function(partyId, name)
    
end

-- เมื่อปาร์ตี้ถูกยุบ หรือ ออกจากปาร์ตี้
listener.partyDisbanded = function()
    
end

-- เมื่อผู้เล่นเข้าร่วมปาร์ตี้
---@param partyId number เลข ID ของปาร์ตี้
---@param name string ชื่อของปาร์ตี้
---@param players table ผู้เล่นในปาร์ตี้
---@param ownerId number ไอดีของเจ้าของปาร์ตี้
listener.onJoined = function(partyId, name, players, ownerId)
    
end

-- เมื่อจับคู่สำเร็จ
---@param partyId number เลข ID ของปาร์ตี้
---@param players table ผู้เล่นในปาร์ตี้
listener.onMatchFound = function(partyId, players)
    config.notification("จับคู่สำเร็จ เริ่มปาร์ตี้แล้ว", "success")
end

-- เมื่อปาร์ตี้เริ่มทำงาน
---@param isOwner boolean เป็นเจ้าของปาร์ตี้หรือไม่
listener.onStarted = function(isOwner)
    config.notification("เริ่มปาร์ตี้แล้ว", "success")
end

-- เมื่อปาร์ตี้หยุดทำงาน
---@param isOwner boolean เป็นเจ้าของปาร์ตี้หรือไม่
listener.onStopped = function(isOwner)
    config.notification("หยุดปาร์ตี้แล้ว", "warning")
end

-- เมื่อได้รับข้อความใหม่
listener.onChatted = function(message, senderId, senderName, IsSender, IsMenuOpen)
    if IsSender or IsMenuOpen then
        return
    end

    config.notification("[ปาร์ตี้] คุณได้รับข้อความใหม่", "success")
end

-- เมื่อมีการอัพเดตสถานะปาร์ตี้
---@param partyId number เลข ID ของปาร์ตี้
---@param state boolean สถานะของปาร์ตี้
---@param count number จำนวนผู้เล่นในปาร์ตี้
listener.updateState = function(partyId, state, count)
    
end

-- เมื่อมีปาร์ตี้ถูกสร้าง
---@param partyId number เลข ID ของปาร์ตี้
---@param name string ชื่อของปาร์ตี้
---@param locked boolean ปาร์ตี้มีรหัสหรือไม่
listener.onPartyCreated = function(partyId, name, locked)
    
end

-- เมื่อมีปาร์ตี้ถูกยุบ
---@param partyId number เลข ID ของปาร์ตี้
listener.onPartyRemoved = function(partyId)
    
end