listener = {}

--- จะถูกเรียกเมื่อผู้เล่นกดรับเควส
--- @param playerId number ไอดีผู้เล่น
--- @param taskId number ไอดีของเควส
listener.onAcceptQuest = function(playerId, taskId)
    
end

--- จะถูกเรียกเมื่อผู้เล่นยกเลิกเควส
--- @param playerId number ไอดีผู้เล่น
--- @param taskId number ไอดีของเควส
listener.onCancelQuest = function(playerId, taskId)
    
end

--- จะถูกเรียกเมื่อมีการอัพเดตข้อมูลของเควส
--- @param playerId number ไอดีผู้เล่น
--- @param taskId number ไอดีของเควส
--- @param current_value number จำนวนปัจจุบัน
--- @param total_value number จำนวนที่ต้องทำ
--- @param IsCompleted boolean เควสเสร็จสิ้นหรือไม่
listener.onUpdate = function(playerId, taskId, current_value, total_value, IsCompleted)
    
end

--- จะถูกเรียกเมื่อผู้เล่นกดรับรางวัล
--- @param playerId number ไอดีผู้เล่น
--- @param taskId number ไอดีของเควส
--- @param taskData table ข้อมูลของเควส
listener.onClaim = function(playerId, taskId, taskData)
    
end

--- จะถูกเรียกใช้งานเมื่อกระดานเควสถูกรีเซ็ต
listener.onRefreshed = function()
    
end