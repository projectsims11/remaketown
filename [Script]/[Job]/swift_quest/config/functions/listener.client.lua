listener = {}

--- จะถูกเรียกใช้งานเมื่อระบบโหลดข้อมูลเสร็จสิ้น
--- @param playerData table ข้อมูลของผู้เล่น
listener.onLoaded = function(playerData)
    
end

--- @return boolean อนุญาติให้กระทำกับปุ่ม
--- @param taskId number ไอดีของเควส
listener.WillInteractWithButton = function(taskId)
    return true
end

--- จะถูกเรียกใช้งานเมื่อมีการตอบกลับจากเซิฟเวอร์หลังจากกดปุ่ม
--- @param taskId number ไอดีของเควส
--- @param status string สถานะของการตอบกลับ (completed, claimed, success, max_accepted, cancel)
listener.InteractResponse = function(taskId, status)
    
end

--- จะถูกเรียกใช้งานเมื่อกระดานเควสถูกรีเซ็ต
listener.onRefreshed = function()
    
end

--- จะถูกเรียกเมื่อมีการอัพเดตข้อมูลของเควส
--- @param taskId number ไอดีของเควส
--- @param current_value number จำนวนปัจจุบัน
--- @param total_value number จำนวนที่ต้องทำ
--- @param IsCompleted boolean เควสเสร็จสิ้นหรือไม่
listener.onUpdate = function(taskId, current_value, total_value, IsCompleted)
    
end