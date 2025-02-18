ESX = nil

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- Config = {}
local cam, isCameraActive, rotateActive
local firstSpawn, zoomOffset, camOffset, heading,sex = true, 0.0, 0.0, 90.0,0
local total = 0
local hasPaid = false
local loopcheckdie = false
local PlayerData = {}
local playerLoaded = false
local typeofshop = ''
local openshopalready = false
dataitem = {}
-- 13-6-65
-- วิธีเพิ่มข้อมูลต่างๆ ให้เพิ่มใน array ด้านล่าง แล้วต้องไปเพิ่มในร้านต่างๆ ด้วย
-- ลบร้านต่างๆ ออกให้เปลีย่นจากเสื้อเอา

-- เปลี่ยนระบบ rotate ped ใหม่ ให้ ped หมุน ไม่ใช่มุมกล้องหมุน done
--
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(100)
        end
     
        PlayerLoaded = true
        ESX.PlayerData = ESX.GetPlayerData()

    end
)

TriggerEvent(
   "skinchanger:getSkin",
   function(skin)
      if skin.sex == 0 then
         sex = 0
      else
         sex = 1
      end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    --ESX.PlayerData = xPlayer
    PlayerLoaded = true
end)

-- เปลี่ยน job

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

    ESX.PlayerData.job = job
    openmenu = false
end)


function CreateSkinCam()
    
    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    end
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, true)

    isCameraActive = true
    -- SetCamRot(cam, 0.0, 0.0, 270.0, true)
    local playerPed = PlayerPedId()
    -- SetEntityHeading(playerPed, 0.0)
    local h = GetEntityHeading(playerPed)
    -- SetEntityHeading(playerPed, h*1.5)
    heading = h + 90
    -- print(heading) --ค่าตัวละครหันหน้า
    --  print(h)-- ค่ามุมกล้อง

    Citizen.Wait(500)
    
    CameraRotate("whole")
end



--///////////////////////////////////////////////////////////  ESX //////////////////////////////////////////////////////////////////




function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local restrict = {}
	if _accessory == 'clothes' then
		restrict = Config.clotheslist
    elseif _accessory == 'villa' then
		restrict = Config.clotheslist
	elseif _accessory == 'barber' then
		restrict= Config.barberlist
	else
		restrict = { _accessory .. '_1', _accessory .. '_2' }
	end

    typeofshop = _accessory
	
	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()
	end, function(data, menu)
		menu.close()
	end, restrict)
end


function openWardrobe()


 
        typeshop = 'ตู้เสื้อผ้า' --  Clothes Menu
        price = 0
        clothes = true


    local playerPed = PlayerPedId()
    SetNuiFocus(true, true)
    CreateSkinCam()
    -- FreezeEntityPosition(playerPed, true)
    -- reskin เมนู
    --  รีสกิน
  
        zoomOffset = 1.25
        camOffset = 0.35
        clothes = true
 
    -- print(json.encode(data))
    local h = GetEntityHeading(playerPed)
    loopcheckdie = true
    if h <= 75 then
        h = 100
    end

    SendNUIMessage(
        {
            type = "wardrobe",
            typeshop = typeshop,
            head = {head = h, min = (h-h)-90, max =(h+h)+90  },
            price = price,
            wardrobePrice = Config.wardrobePrice,
            limitslot = Config.limitWardrobe,
            wardslotprice = Config.wardrobeslot,
            logo = Config.logo,
            clothes = clothes
        }
    )

end



function OpenRoomMenu()

    local restrict = Config.clotheslist

    TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()
	end, function(data, menu)
		menu.close()
	end, restrict)
	

end






-- /////////////////////////////////////////////////////////////// function //////////////////////////////////////////////////////////



local HasAlreadyEnteredZone = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if not openshopalready then 
            player = PlayerPedId()
            coords = GetEntityCoords(player)
            test  = true
            local isInZone = false

            for k,v in pairs(Config.Zones) do
                for i = 1, #v.Pos, 1 do
                    if GetDistanceBetweenCoords(coords, v.Pos[i], true) < 10 then
                        test  = false
                        DrawMarker(v.Marker.Type, v.Pos[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Marker.Size.x, v.Marker.Size.y, v.Marker.Size.z, v.Marker.r, v.Marker.g, v.Marker.b, 200, false,0, 0,true, false, false, false)
                        if GetDistanceBetweenCoords(coords, v.Pos[i], true) < 2 then
                            isInZone = true
                            if IsControlJustPressed(1, Keys['E']) then
                            
                                if k == 'Villa' then
                                    -- OpenShopMenu(k)
                                    openWardrobe()
                                    Alertnotifiexitmarker()
                                    openshopalready = true
                                    -- OpenRoomMenu()
                                else
                                    OpenShopMenu(k)
                                    Alertnotifiexitmarker()
                                    openshopalready = true
                                    
                                end
                                break
                            end
                        end

                        if IsEntityDead(player) and loopcheckdie then
                            SendNUIMessage( { type = "closemenuskin" } )
                            DeleteSkinCam()
                            SetNuiFocus(false, false)
                            FreezeEntityPosition(PlayerPedId(), false)
                            loopcheckdie = false
                        end

                    end
                end
            end
            
            if (isInZone and not HasAlreadyEnteredZone) then
                HasAlreadyEnteredZone = true
                AlertnotifiEntermarker()
                
            end

            if not isInZone and HasAlreadyEnteredZone then
                HasAlreadyEnteredZone = false
                Alertnotifiexitmarker()
                hasExitedMarker()
            end	

            if test then
                Wait(2000)
            end
        else
            Citizen.Wait(1000)
        end
	end
end)


function hasExitedMarker()

	ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

end



RegisterFontFile('font4thai')
fontId = RegisterFontId('font4thai')


function Draw3DText(coords, text)
	EndTextCommandDisplayText(coords.x, coords.y)  
	SetTextScale(0.1 * 2, 0.45* 2)
	SetTextFont(fontId)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
	SetDrawOrigin(coords.x, coords.y, coords.z, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end


function pNotify(text, timeout, layout)
	exports.pNotify:SendNotification(
		{
			text = text,
			type = "error",
			timeout = timeout,
			layout = layout,
			queue = "clotheshop"
		}
	)
end

-- Citizen.CreateThread(function()
-- 	for k,v in pairs(Config.Zones) do
-- 		if v.Blip ~= nil then
-- 			for i=1,  #v.Pos, 1 do
-- 				local blip = AddBlipForCoord(v.Pos[i])
-- 				SetBlipSprite (blip, v.Blip.Sprite)
-- 				SetBlipDisplay(blip, v.Blip.Display)
-- 				SetBlipScale  (blip, v.Blip.Scale)
-- 				SetBlipColour (blip, v.Blip.Colour)
-- 				SetBlipAsShortRange(blip, true)
-- 				BeginTextCommandSetBlipName("STRING")
-- 				Text = '<font face="font4thai">'..v.Blip.Text..'</font>'
-- 				AddTextComponentString(Text)
-- 				EndTextCommandSetBlipName(blip)
-- 			end
-- 		end
-- 	end
-- end)




function CreateBlip(ssdss,Sprite,Display,Scale,Colour,Text)
    
	local blip = AddBlipForCoord(ssdss)
       
    SetBlipSprite (blip, Sprite)
    SetBlipDisplay(blip, Display)
    SetBlipScale  (blip, Scale)
    SetBlipColour (blip, Colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")   
    AddTextComponentString(Text)
    EndTextCommandSetBlipName(blip)

	return blip
end


Citizen.CreateThread(function()
	local currentGasBlip = 0

	while true do
		Citizen.Wait(1000)

		local coordss = GetEntityCoords(PlayerPedId())
		local closest = 2000.0
		local ssdss
        local Sprite
        local Display
        local Scale
        local Colour
        local Text
        
		for k,v in pairs(Config.Zones) do 
            if k == 'Clothes' then
            for i=1,  #v.Pos, 1 do               
                local ssd = v.Pos[i]
                local dstcheck = GetDistanceBetweenCoords(coordss, v.Pos[i])               
                if dstcheck < closest then
                    closest = dstcheck
                    ssdss = v.Pos[i]
                    Sprite = v.Blip.Sprite
                    Display = v.Blip.Display
                    Scale = v.Blip.Scale
                    Colour = v.Blip.Colour
                    Text = '<font face="font4thai">'..v.Blip.Text..'</font>'
                end
            end
        end            
		end
        

		if DoesBlipExist(currentGasBlip) then
			RemoveBlip(currentGasBlip)
		end
        if ssdss ~= nil and Sprite ~= nil and Display ~= nil and Scale ~= nil and Colour ~= nil and Text ~= nil then
		    currentGasBlip = CreateBlip(ssdss,Sprite,Display,Scale,Colour,Text)
        end
	end
end)



function CreateBlipf(ssdss,Sprite,Display,Scale,Colour,Text)
    
	local blip = AddBlipForCoord(ssdss)
       
    SetBlipSprite (blip, Sprite)
    SetBlipDisplay(blip, Display)
    SetBlipScale  (blip, Scale)
    SetBlipColour (blip, Colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")   
    AddTextComponentString(Text)
    EndTextCommandSetBlipName(blip)

	return blip
end


Citizen.CreateThread(function()
	local currentGasBlip = 0

	while true do
		Citizen.Wait(1000)

		local coordss = GetEntityCoords(PlayerPedId())
		local closest = 2000.0
		local ssdss
        local Sprite
        local Display
        local Scale
        local Colour
        local Text
        
		for k,v in pairs(Config.Zones) do 
            if k == 'Barber' then
            for i=1,  #v.Pos, 1 do               
                local ssd = v.Pos[i]
                local dstcheck = GetDistanceBetweenCoords(coordss, v.Pos[i])               
                if dstcheck < closest then
                    closest = dstcheck
                    ssdss = v.Pos[i]
                    Sprite = v.Blip.Sprite
                    Display = v.Blip.Display
                    Scale = v.Blip.Scale
                    Colour = v.Blip.Colour
                    Text = '<font face="font4thai">'..v.Blip.Text..'</font>'
                end
            end
        end            
		end
        

		if DoesBlipExist(currentGasBlip) then
			RemoveBlip(currentGasBlip)
		end
        if ssdss ~= nil and Sprite ~= nil and Display ~= nil and Scale ~= nil and Colour ~= nil and Text ~= nil then
		    currentGasBlip = CreateBlipf(ssdss,Sprite,Display,Scale,Colour,Text)
        end
	end
end)


function CreateBlips(ssdss,Sprite,Display,Scale,Colour,Text)
    
	local blip = AddBlipForCoord(ssdss)
       
    SetBlipSprite (blip, Sprite)
    SetBlipDisplay(blip, Display)
    SetBlipScale  (blip, Scale)
    SetBlipColour (blip, Colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")   
    AddTextComponentString(Text)
    EndTextCommandSetBlipName(blip)

	return blip
end









--===============================================
--==           openmenuskin Event                   ==
--===============================================
RegisterNetEvent("openmenuskin")
AddEventHandler(
    "openmenuskin",
    function(data, list)
        -- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        -- 	TriggerEvent('skinchanger:loadSkin', skin)
        -- end)
        -- แบ่งการส่งค่าข้อมูล แย่งประเภทร้านต่างๆ

        -- table.insert(datalist, list)
        TriggerEvent("skinchanger:getSkin",function(skin) if skin.sex == 0 then  sex = 0  else sex = 1 end end)
        datalist = list
        local typeshop = ""
        if Config.checklist then
            --print(#data)
        end
        local clothes = false
        local price = 0

        if typeofshop == 'clothes' then
            typeshop = Config.nameClothes --  Clothes Menu
            price = Config.Price2
        elseif typeofshop == 'barber' then
            typeshop = Config.nameBarber -- Barber Menu
            price = Config.Price
        end



        if #data == Config.reskin then
            typeshop = Config.nameskin -- Skin Menu
            price = 0
        elseif #data == 2 then
            typeshop = Config.nameCostume -- Costume Shop
            price = Config.Price3
        end

        local playerPed = PlayerPedId()
        SetNuiFocus(true, true)
        CreateSkinCam()
        -- FreezeEntityPosition(playerPed, true)
        -- reskin เมนู
        --  รีสกิน
        if #data == Config.reskin then
            -- ร้านทำผม
            zoomOffset = 1
            camOffset = 0.35
        elseif typeofshop == 'barber' then
            -- ร้านเสื้อผ้า
            zoomOffset = 0.6
            camOffset = 0.65
        elseif typeofshop == 'clothes' then
            zoomOffset = 1.25
            camOffset = 0.35
            clothes = true
        elseif #data == 2 then
            zoomOffset = 0.6
            camOffset = 0.65
        end
        -- print(json.encode(data))
        local h = GetEntityHeading(playerPed)
        loopcheckdie = true
        if h <= 75 then
            h = 100
        end
        SendNUIMessage(
            {
                type = "openskin",
                data = data,
                typeshop = typeshop,
                -- head = {head = 0, min = -180, max =180  },
                head = {head = h, min = (h-h)-90, max =(h+h)+90  },
                price = price,
                wardrobePrice = Config.wardrobePrice,
                limitslot = Config.limitWardrobe,
                wardslotprice = Config.wardrobeslot,
                logo = Config.logo,
                clothes = clothes
            }
        )
    end
)
RegisterNUICallback(
    "changeZoom",
    function(data, cb)
        if data.z == "plus" then
            zoomOffset = zoomOffset + 0.1
        elseif (data.z == "minus") then
            zoomOffset = zoomOffset - 0.1
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "changeH",
    function(data, cb)
        if data.h == "plus" then
            camOffset = camOffset + 0.1
        elseif (data.h == "minus") then
            camOffset = camOffset - 0.1
        end



        cb("ok")
    end
)

RegisterNUICallback(
    "rotateview",
    function(data, cb)
        if data.angle then
            -- angle = tonumber(data.angle)
            n = tonumber(data.angle) + .0
            local playerPed = PlayerPedId()

            -- print(n)
            SetEntityHeading(playerPed, n)
            local h = GetEntityHeading(playerPed)
            -- print(h)
        end

        rotateActive = true
        cb("ok")
    end
)

function buyaccessories(accessory)
    ESX.UI.Menu.Open(
        "dialog",
        GetCurrentResourceName(),
        "outfit_name_acessory",
        {
            title = "Input " .. accessory .. "(4-30 charactor) name"
        },
        function(data3, menu3)
            if data3.value == nil then
       
                alertAccessoryblank()
             
            else
                if utf8.len(data3.value) >= 30 then
                 
                        alertAccessoryLong()
                
                elseif utf8.len(data3.value) < 4 then
                
                    alertAccessoryShort()
              
                else
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        TriggerServerEvent('replayx.skinui:saveOutfitaccessory', data3.value, skin, accessory,Config.Price3)
                    end)
                    menu3.close()
                    Wait(1000)
                end
            end
        end,
        function(data3, menu3)
            menu3.close()
        end
    )
end

RegisterNUICallback(
    "setview",
    function(data, cb)
        local status = true
        if data.data == "close" then
            openshopalready = false
            if total == Config.reskin then
               
                loopcheckdie = false
                DeleteSkinCam()
                SetNuiFocus(false, false)
                FreezeEntityPosition(PlayerPedId(), false)
                Wait(200)
                ESX.TriggerServerCallback(
                        "esx_skin:getPlayerSkin",
                        function(skin)
                            TriggerEvent("skinchanger:loadSkin", skin)
                        end
                    )
            else
                loopcheckdie = false
                DeleteSkinCam()
                SetNuiFocus(false, false)
                FreezeEntityPosition(PlayerPedId(), false)
                Wait(2000)
                ESX.TriggerServerCallback(
                        "esx_skin:getPlayerSkin",
                        function(skin)

                            TriggerEvent("skinchanger:loadSkin", skin)
                        end
               )
            end
        end
        if data.data == "save" then
            openshopalready = false
            loopcheckdie = false
            FreezeEntityPosition(PlayerPedId(), false)
         
           print(total)
            if total ~= Config.reskin then
                ESX.TriggerServerCallback(
                    "replayx.skinui:checkMoney",
                    function(hasEnoughMoney)
                        if hasEnoughMoney then
                            TriggerEvent(
                                "skinchanger:getSkin",
                                function(skin)
                                    if Config.accessoriesNcsave then
                                        if total == 2 then
                                            if data.list[1].name == "helmet_1" then
                                                if skin["helmet_1"] ~= -1 then
                                                    local _accessory = "helmet"

                                                    buyaccessories(_accessory)
                                                    skin["helmet_1"] = -1
                                                    skin["helmet_2"] = 0
                                                end
                                            elseif data.list[1].name == "mask_1" then
                                                if skin["mask_1"] ~= 0 then
                                                    local _accessory = "mask"

                                                    buyaccessories(_accessory)

                                                    skin["mask_1"] = 0
                                                    skin["mask_2"] = 0
                                                end
                                             elseif data.list[1].name == "chain_1" then
                                                    if skin["chain_1"] ~= 0 then
                                                        local _accessory = "chain"
    
                                                        buyaccessories(_accessory)
    
                                                        skin["chain_1"] = 0
                                                        skin["chain_2"] = 0
                                                    else
                                                    end
                                            elseif data.list[1].name == "glasses_1" then
                                                if skin["sex"] == 0 then
                                                    if skin["glasses_1"] ~= 0 then
                                                        local _accessory = "glasses"

                                                        buyaccessories(_accessory)
                                                        skin["glasses_1"] = 0
                                                        skin["glasses_2"] = 0
                                                    end
                                                else
                                                    if skin["glasses_1"] ~= 5 then
                                                        local _accessory = "glasses"

                                                        buyaccessories(_accessory)
                                                        skin["glasses_1"] = 5
                                                        skin["glasses_2"] = 0
                                                    end
                                                end
                                            elseif data.list[1].name == "ears_1" then
                                                if skin["ears_1"] ~= -1 then
                                                    local _accessory = "ears"

                                                    buyaccessories(_accessory)

                                                    skin["ears_1"] = -1
                                                    skin["ears_2"] = 0
                                          
                                                else
                                                end
                                            end

                                            -- ถ้ามีการเปลี่ยน หมวก แว่น หน้ากาก ตุ้มหู จะเข้าฟังชั้นบนหมดแล้ว แล้วมาโหลดเก็บข้อมูลตรงนี้ให้เป็น defult
                                            skin["ears_1"] = -1
                                            skin["ears_2"] = 0
                                            if skin["sex"] == 0 then
                                                skin["glasses_1"] = 0
                                                skin["glasses_2"] = 0
                                            else
                                                skin["glasses_1"] = 5
                                                skin["glasses_2"] = 0
                                            end
                                            skin["mask_1"] = 0
                                            skin["mask_2"] = 0
                                            skin["helmet_1"] = -1
                                            skin["helmet_2"] = 0
                                        else

                                            -- ป้องกันพวกใส่ หมวก แว่น หน้ากาก ตุ้มหู มาเปลี่ยนชุดแล้วติดเป็น skin ไปด้วย
                                            -- เดินออกร้าน 
                                            -- skin["helmet_1"] = -1
                                            -- skin["helmet_2"] = 0
                                            -- skin["mask_1"] = 0
                                            -- skin["mask_2"] = 0

                                            -- if skin["sex"] == 0 then
                                            --     if skin["glasses_1"] ~= 0 then
                                            --         skin["glasses_1"] = 0
                                            --         skin["glasses_2"] = 0
                                            --     end
                                            -- else
                                            --     if skin["glasses_1"] ~= 5 then
                                            --         skin["glasses_1"] = 5
                                            --         skin["glasses_2"] = 0
                                            --     end
                                            -- end
                                            -- skin["ears_1"] = -1
                                            -- skin["ears_2"] = 0
                                        end
                                    else

                                        if data.list[1].name == 'mask_1' then
                                            if skin['mask_1'] ~= 0 then 
                                                local _accessory = 'mask'
                                            
                                            
                                                buyaccessories(_accessory)
                                                -- # หากต้องการ "ลบ" เครื่องประดับที่แสดงในกระเป๋า Export Function ด้านล่างนี้
                                            
                                                
                                                skin['mask_1'] = 0
                                                skin['mask_2'] = 0
                                            end
                                        end


                                    end

                                  
                                    TriggerServerEvent("esx_skin:save", skin)
                                end )
                            
                            if total > 2 then

                                local playerPed = PlayerPedId()
                                local coords = GetEntityCoords(playerPed)
                                if GetDistanceBetweenCoords(coords, vector3(-2483.59, 6987.76, 41.07), true) < 100 then
                                else
                                    TriggerServerEvent("replayx.skinui:pay", Config.Price2)
                                end
                          
                            end

                            hasPaid = true
                            total = 0
                        else
                            Wait(200)
                            ESX.TriggerServerCallback(
                                "esx_skin:getPlayerSkin",
                                function(skin)
                                    TriggerEvent("skinchanger:loadSkin", skin)
                                end
                            )

                            local priceList
                            if total == Config.barbershop then
                                priceList = Config.Price
                            elseif total == Config.clotheshop then
                                priceList = Config.Price2
                            else
                                priceList = Config.Price3
                            end

                            PaybutMoneyNotEnough(priceList)
                        end
                    end
                )
            else
                --  แสดงข้อมูลอัพเดท
                -- print("reskin เสร็จแล้ว")
                TriggerEvent(
                    "skinchanger:getSkin",
                    function(skin)
                        -- ไม่ให้รีสกิน เซฟ หมวก แว่น หน้ากาก ตุ้มหู
                        if Config.accessoriesNcsave then

                        else
                            skin["ears_1"] = -1
                            skin["ears_2"] = 0
                            if skin["sex"] == 0 then
                                skin["glasses_1"] = 0
                                skin["glasses_2"] = 0
                            else
                                skin["glasses_1"] = 5
                                skin["glasses_2"] = 0
                            end
                            skin["mask_1"] = 0
                            skin["mask_2"] = 0
                            skin["helmet_1"] = -1
                            skin["helmet_2"] = 0
                        end
                        -- -- ไม่บันทึกหน้ากาก
                        -- skin["mask_1"] = 0
                        -- skin["mask_2"] = 0

                        TriggerServerEvent("esx_skin:save", skin)
                    end
                )

                DoneUpdateSkin()
                
                -- 
                Wait(500)
                ESX.TriggerServerCallback(
                    "esx_skin:getPlayerSkin",
                    function(skin)
                        TriggerEvent("skinchanger:loadSkin", skin)
                    end)
            end

            DeleteSkinCam()
            SetNuiFocus(false, false)
            status = false
        end
        -- CameraRotate(data)
        cb(status)
    end
)

RegisterNUICallback("viewstyle",function(data, cb)
        CameraRotate(data)
        -- print(json.encode(data))
        cb(status)
    end
)

RegisterNUICallback('holdup', function(data, cb)
	local lPed = PlayerPedId()
	-- print(data)
	if data.data then
        
		local dict = "missminuteman_1ig_2"
		RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
		TaskPlayAnim(lPed, dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
	
	else
		ClearPedSecondaryTask(lPed)
	end	
	cb(status)	
end)

function CameraRotate(data)
    if data.data == "head" then
        zoomOffset = 0.6
        camOffset = 0.65
    elseif data.data == "body" then
        zoomOffset = 0.80
        camOffset = 0.30
    elseif data.data == "leg" then
        zoomOffset = 0.95
        camOffset = -0.30
    elseif data.data == "foot" then
        zoomOffset = 0.8
        camOffset = -0.6
    elseif data.data == "whole" then
        zoomOffset = 2.5
        camOffset = 0.35
    else
        zoomOffset = 2.5
        camOffset = 0.35
    end
  



end

function DeleteSkinCam()
    isCameraActive = false
    rotateActive = false
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 500, true, true)
    cam = nil
end

RegisterNUICallback(
    "getSkininfo",
    function(data, cb)
        --  ต้องแยกข้อมูล หมวด skin และร้านเสื้อผ้า ร้านตัดผม
        local restrict = datalist
        total = data.total

        TriggerEvent(
            "skinchanger:getData",
            function(components, maxVals)
                local elements = {}
                local _components = {}

                -- Restrict menu
                if restrict == nil then
                    for i = 1, #components, 1 do
                        _components[i] = components[i]
                    end
                else
                    for i = 1, #components, 1 do
                        local found = false

                        for j = 1, #restrict, 1 do
                            if components[i].name == restrict[j] then
                                found = true
                            end
                        end

                        if found then
                            table.insert(_components, components[i])
                        end
                    end
                end

                -- Insert elements
                for i = 1, #_components, 1 do
                    local value = _components[i].value
                    local componentId = _components[i].componentId
                    
                    if componentId == -1 then
                        value = GetPedPropIndex(playerPed, _components[i].componentId)
                    end

                    local data = {
                        label = _components[i].label,
                        name = _components[i].name,
                        value = value,
                        min = _components[i].min,
                        textureof = _components[i].textureof,
                        zoomOffset = _components[i].zoomOffset,
                        camOffset = _components[i].camOffset,
                        type = "slider"
                    }

                    for k, v in pairs(maxVals) do
                        if k == _components[i].name then
                            data.max = v
                            -- เพิ่มตรงนี้เพื่อเวลามีค่า max มากกว่า value ให้ค่ากลับไปเป็น min เวลาโหลดจะได้ไม่พัง
                            if data.value > data.max then
                                data.value = data.min
                                TriggerEvent("skinchanger:change", data.name, tonumber(data.value))
                            end
                            break
                        end
                    end

                    table.insert(elements, data)
                end

                   -- Block cloth
                   if Config.blockCloth then
                    clothblock(elements,sex)
                   end

                cb(elements)
            end
        )
    end
)
RegisterNUICallback(
    "changeskin",
    function(data, cb)
        -- -- เปลี่ยนชุด แต่ยังไม่ save
        if data.name == 'sex' then
            sex = tonumber(data.value)
         end
        TriggerEvent("skinchanger:change", data.name, tonumber(data.value))
        -- end)
        cb("ok")
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)

            if isCameraActive then
                -- heading = h*2
                -- ESX.ShowHelpNotification(_U('use_rotate_view'))
                DisableControlAction(2, 30, true)
                DisableControlAction(2, 31, true)
                DisableControlAction(2, 32, true)
                DisableControlAction(2, 33, true)
                DisableControlAction(2, 34, true)
                DisableControlAction(2, 35, true)
                DisableControlAction(0, 25, true) -- Input Aim
                DisableControlAction(0, 24, true) -- Input Attack

                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)

                local angle = heading * math.pi / 180.0
                local theta = {
                    x = math.cos(angle),
                    y = math.sin(angle)
                }

                local pos = {
                    x = coords.x + (zoomOffset * theta.x),
                    y = coords.y + (zoomOffset * theta.y)
                }
                -- ปรับมุมกล้อง ซ้ายขวา ให้เลื่อนหาตัวละคร
                local angleToLook = heading - 220.0
                if angleToLook > 360 then
                    angleToLook = angleToLook - 360
                elseif angleToLook < 0 then
                    angleToLook = angleToLook + 360
                end

                angleToLook = angleToLook * math.pi / 180.0 -- 180
                local thetaToLook = {
                    x = math.cos(angleToLook),
                    y = math.sin(angleToLook)
                }

                local posToLook = {
                    x = coords.x + (zoomOffset * thetaToLook.x),
                    y = coords.y + (zoomOffset * thetaToLook.y)
                }

                SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
                PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)
             
                -- targetPos = GetPedBoneCoords(previewPed, 11816, 0.0, 0.0, 0.0)
                -- PointCamAtCoord(cam, targetPos.x, targetPos.y, targetPos.z )
            else
                Citizen.Wait(500)
            end
        end
    end
)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
        local playerPed = GetPlayerPed(-1)
        if IsEntityDead(playerPed) and loopcheckdie then
            SendNUIMessage( { type = "closemenuskin" } )
            DeleteSkinCam()
            SetNuiFocus(false, false)
            FreezeEntityPosition(PlayerPedId(), false)
            loopcheckdie = false
            Wait(2000)
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        	TriggerEvent('skinchanger:loadSkin', skin)
            end)
            openshopalready = false
        end
	end
end)

