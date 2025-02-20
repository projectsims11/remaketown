local nuiStatus = false

RegisterKeyMapping(Config.Command, 'Open Menu Ui', 'keyboard', Config.OpenKey)

RegisterCommand(Config.Command, function()
    nuiStatus = not nuiStatus
    SetNuiFocus(true, true)
    
    local menuData = {}
    
    if nuiStatus then
        for i = 1, #Config.Menu do
            local boxData = Config.Menu[i]
            table.insert(menuData, boxData)
        end
    end
    
    SendNUIMessage({
        type = 'openMenuUi',
        display = nuiStatus,
        box = menuData
    })
end, false)

function closeMenu()
    nuiStatus = not nuiStatus
    SetNuiFocus(false, false)
end

function event(data)
    nuiStatus = not nuiStatus
    SetNuiFocus(false, false)
    TriggerEvent(data)
end

function command(data)
    nuiStatus = not nuiStatus
    SetNuiFocus(false, false)
    ExecuteCommand(data)
end

RegisterNUICallback('action', function(data, cb)
    if data.action == 'closeMenu' then
        closeMenu()
    elseif data.action == 'event' then
        event(data.event)
    elseif data.action == 'command' then
        command(data.event)
    end
end)