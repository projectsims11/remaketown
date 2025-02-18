
Config['ArmorProgbar'] = function(item, time)
    TriggerEvent('Heathens.ItemProgress:progress', {
        item = item, -- ===> ชื่อไอเทม
        text = 'ใส่เกราะ', -- ===> ข้อความ
        duration = time * 1000, -- ===> เวลาคูลดาวน์ 
    }, function()
    end)
end

Config['Armor'] = {
    {
        ['item_name'] = 'armor',
        ['CheckCount'] = true ,
        ['Job'] = nil ,
        ['Zone'] = nil ,
        --[[
        ['Zone'] = {
            coords = vector3(3873.3567, -1656.4917, 627.7646),
            rad = 50.0
        } ,
        ]]
        ['Time'] = 3,
        ['Remove'] = true,
        ["Armor"] = 100,
    },
    {
        ['item_name'] = 'armor_agency',
        ['CheckCount'] = true ,
        ['Job'] = {'police' , 'ambulance' , 'council'} ,
        ['Zone'] = nil ,
        --[[
        ['Zone'] = {
            coords = vector3(3873.3567, -1656.4917, 627.7646),
            rad = 50.0
        } ,
        ]]
        ['Time'] = 3,
        ['Remove'] = false,
        ["Armor"] = 100,
    }
}