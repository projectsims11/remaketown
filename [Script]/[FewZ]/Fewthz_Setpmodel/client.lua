ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("setpmodel:setmodel")
AddEventHandler("setpmodel:setmodel",function(models)
  local model = models
  local player = PlayerPedId()
  local pos = GetEntityCoords(player)
  while not HasModelLoaded(model) do
    RequestModel(model)
    Citizen.Wait(10)
  end
  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)
end)

RegisterNetEvent("setpmodel:resetmodel")
AddEventHandler("setpmodel:resetmodel",function()
  local model
  local player = PlayerPedId()
  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
      model = "mp_m_freemode_01"
    elseif skin.sex == 1 then
      model = "mp_f_freemode_01"
    end
  end)
  while not HasModelLoaded(model) do
    RequestModel(model)
    Citizen.Wait(10)
  end
  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
    TriggerEvent('skinchanger:loadSkin', skin)
  end)
end)