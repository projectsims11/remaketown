---------------------------------------* CLIENT
function CannotLoot()
    TriggerEvent('pNotify:SendNotification', {
        text = '<span class="red-text">'.."ตายก่อนจบเลย"..'</span> ',
        type = 'error',
        timeout = 3000,
        layout = 'centerLeft',
        queue = 'global'
    })
end
---------------------------------------* SERVER
function Misslootbox(source)
    TriggerClientEvent('pNotify:SendNotification', source, {
        text = '<span class="red-text">'.."เก็บไม่ทัน"..'</span> ',
        type = 'error',
        timeout = 3000,
        layout = 'centerLeft',
        queue = 'global'
    })
end