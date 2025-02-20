Progress = function()
    local promise = promise:new() 

    exports['mythic_progbar']:Progress({
        name = "unique_action_name",
        duration = Config.Default.Progress * 1000,
        label = 'Doing Something',
        useWhileDead = true,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        },
    }, function(cancelled)
        if not cancelled then
            promise:resolve(true) -- ถ้าการทำงานสำเร็จ ส่งค่า true กลับ
        else
            promise:resolve(false) -- ถ้ายกเลิก ส่งค่า false กลับ
        end
    end)

    return Citizen.Await(promise) -- คืนค่ารอการทำงานของ promise
end

FreezePlayer = function()
    FreezeEntityPosition(PlayerPedId(), true)
    Citizen.CreateThread(function()
        local elements = {
            {label = "ยืนยัน เพื่อ ปลดล็อคตัวละคร",value = '1'},
        }
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'xMaps', {
            title    = 'ระบบป้องกันตกแมพ',
            align    = 'center',
            elements = elements
        }, function(data,menu)

            if data.current.value == '1' then
                menu.close()
                FreezeEntityPosition(PlayerPedId(),false)
            end
        end, function(data,menu)
            menu.close()
            FreezeEntityPosition(PlayerPedId(),false)
        end)
    end)
end

Reduceblood = function()
    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) -2)
end

Revive = function()
    TriggerEvent('esx_ambulancejob:revive')
    Wait(3000)
    SetEntityHealth(PlayerPedId(), 200)
end

TextUi = function(coords) -- TEXT จะขึ้นตอนอยู่ใกล้ๆ กล่อง
   --exports["Undg_TextUi"]:TEXT_TEXT3D('PRESS <span>E</span> TO GET AIRDROP')
end

HideTextUI = function()
   --exports["Undg_TextUi"]:TEXT_HIDETEXT()
end

Draw3DText = function(zone,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, zone, 1)
    local scale = (1/dist)
    local fov = (1/GetGameplayCamFov()) 
    local scale = 1.0 
    --local fontId = RegisterFontId('font4thai')
    RegisterFontFile('font4thai')
    SetTextScale(scaleXscale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(zone + vector3(0,0,1.0) , 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

SecondsToClock = function(seconds)
    local seconds = tonumber(seconds)
    if seconds <= 0 then
        return "00:00:00";
    else
        hours = string.format("%02.f", math.floor(seconds/3600));
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
        secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
        return hours..":"..mins..":"..secs
    end
end