-- ผู้เล่นเข้าเกมส์


--  บล็อตชุดพวกนี้เพื่อให้ใส่ได้เฉพาะ ไอเทมกดเปลีย่นชุด

local block = {
    {
        cloth = 'torso_1',
        clothValue = 0,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 0,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 1,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 1,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },	
    {
        cloth = 'torso_1',
        clothValue = 2,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 2,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },	
    {
        cloth = 'torso_1',
        clothValue = 3,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 3,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },	
    {
        cloth = 'torso_1',
        clothValue = 4,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 4,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },	
    {
        cloth = 'torso_1',
        clothValue = 5,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 5,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },	
    {
        cloth = 'torso_1',
        clothValue = 6,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 6,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },	

	
    {
        cloth = 'torso_1',
        clothValue = 7,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 8,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },	
	
	
    {
        cloth = 'torso_1',
        clothValue = 9,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'torso_1',
        clothValue = 21,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },	

    {
        cloth = 'tshirt_1',
        clothValue = 3,
        clothColor = 0,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'tshirt_1',
        clothValue = 3,
        clothColor = 1,
        sex = 0 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'tshirt_1',
        clothValue = 4,
        clothColor = 0,
        sex = 1 -- ชาย 0 หญิง 1
    },
    {
        cloth = 'tshirt_1',
        clothValue = 4,
        clothColor = 1,
        sex = 1 -- ชาย 0 หญิง 1
    },	
	
}

-- if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then


function clothblock(list,sex)
    ok = false
    for k,v in pairs(list) do 
            for key,value in pairs(block) do 
                   
                                    if sex == value.sex then
                                        if value.color == nil and value.clothColor == nil then
                                            if value.cloth == v.name and value.clothValue == v.value  then
                                                TriggerEvent("skinchanger:change", value.cloth, 0)
                                            end
                                        else
                                            if value.cloth == v.name and value.clothValue == v.value  then
                                                ok = true
                                            end
                                            if value.color == v.name and value.clothColor == v.value and ok then
                                            TriggerEvent("skinchanger:change", value.color, 0)
                                            end
                                        end
                                        

                                    elseif sex == value.sex then
                                    
                                        if value.color == nil and value.clothColor == nil then
                                            if value.cloth == v.name and value.clothValue == v.value  then
                                            
                                                TriggerEvent("skinchanger:change", value.cloth, 0)
                                            end
                                        else
                                            if value.cloth == v.name and value.clothValue == v.value  then
                                                ok = true
                                            end
                                            if value.color == v.name and value.clothColor == v.value and ok then
                                            TriggerEvent("skinchanger:change", value.color, 0)
                                            end
                                        end
                                    
                                    end
            


            end
    end
end   
