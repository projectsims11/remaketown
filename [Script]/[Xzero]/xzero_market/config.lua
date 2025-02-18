--[[
    Script for FiveM (GTAV)
    Created: xZero
]]
Config = {}

-- Base Extended
Config.Base = {
    getSharedObject = 'esx:getSharedObject'
}

Config.STATIC = {
    URL_Base = "http://xzero_market/",
    URL_Images = "nui://Fewthz_inventory/html/img/items/"
}
Config.SQL = {
    Tables = {
        Market_Players = "xmarket_players",
        Market_Items_Selling = "xmarket_items_selling",
        Market_Items_Sell_History = "xmarket_items_sell_history"
    }
}

-- DrawText Font
Config.DrawText_Font = 'sarabun'

-- es_extended Weight (Use canCarryItem)
Config.canCarryItem = false

--[[
    ===== gcPhone =====
]]
Config.gcPhone = {
    Notify_Buy = true, -- true = แจ้งเตือนไปยังโทรศัพเมื่อขายไอเทมออก
    Notify_Buy_Message = [[
        มีคนซื้อไอเทม %s จำนวน %s เงินที่ได้ $%s
    ]],
    Events = {
        internalAddMessage = 'gcPhone:_internalAddMessage',
        receiveMessage = 'gcPhone:receiveMessage'
    }
}

--[[
    ===== Admin =====
    กรอกเลข Identifier (SteamID) สำหรับแอดมิน
]]
Config.AdminList = {
    --"steam:110000xxxxxxxxx",
    --"steam:110000xxxxxxxxx"
}