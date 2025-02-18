-- Made by Fewthz
AddEventHandler('onClientMapStart', function()
  Citizen.CreateThread(function()
    local display = true

    TriggerEvent('Fewthz-logo', true)
  end)
end)

RegisterNetEvent('Fewthz-logo')
AddEventHandler('Fewthz-logo', function(value)
  SendNUIMessage({
    type = "logo",
    display = value
  })
end)

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end