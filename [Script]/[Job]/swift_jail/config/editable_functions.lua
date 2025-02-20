functions = {}

-- Client
functions.sendBillToTarget = function(targetId, label, amount)
    TriggerServerEvent('esx_billing:sendBill', targetId, 'society_police', label, amount)
end

---@param targetXPlayer table ผู้ต้องหา
---@param xPlayer table ผู้ทำคดี
---@param summary string คดี
---@param data table ข้อมูลคดี
--? data.id ไอดีของผู้ต้องหา
--? data.time เวลาที่ถูกเจล
--? data.fine ค่าปรับ
--? data.summary ลิสต์คดี (แบบยังไม่ format เหมือน summary)
functions.announce = function(targetXPlayer, xPlayer, summary, data)
    TriggerClientEvent('chat:addMessage', -1, {
        template = [[
            <div style="display: inline-flex; flex-direction: column; align-items: flex-start; position: relative; padding: 0.45vw 0.45vw; width: auto; background: rgb(9,35,103);
            background: linear-gradient(30deg, rgba(3,14,43,1) 0%, rgba(7,45,150,1) 100%);border-radius:8px;">
                <span style="display: flex; align-items: center; color: #fff; padding: 2px 6px; border-radius: 8px; font-size: 1.00rem; font-weight: 500;">
                    <i class='fas fa-book-reader'></i>&nbsp;&nbsp;{0}
                </span>
                <span style="margin-top: 0px; color: #c7c7c7;">{1}</span>
            </div>
        ]],
        args = {("ศาลพิพากษา คุณ %s"):format(targetXPlayer.name), summary}
    })
end