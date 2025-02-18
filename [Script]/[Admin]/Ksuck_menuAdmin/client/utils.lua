function Clamp(x, min, max)
  return math.min(math.max(x, min), max)
end

function GetDisabledControlNormalBetween(inputGroup, control1, control2)
  local normal1 = GetDisabledControlNormal(inputGroup, control1)
  local normal2 = GetDisabledControlNormal(inputGroup, control2)
  return normal1 - normal2
end

function EulerToMatrix(rotX, rotY, rotZ)
  local radX = math.rad(rotX)
  local radY = math.rad(rotY)
  local radZ = math.rad(rotZ)

  local sinX = math.sin(radX)
  local sinY = math.sin(radY)
  local sinZ = math.sin(radZ)
  local cosX = math.cos(radX)
  local cosY = math.cos(radY)
  local cosZ = math.cos(radZ)

  local vecX = {}
  local vecY = {}
  local vecZ = {}

  vecX.x = cosY * cosZ
  vecX.y = cosY * sinZ
  vecX.z = -sinY

  vecY.x = cosZ * sinX * sinY - cosX * sinZ
  vecY.y = cosX * cosZ - sinX * sinY * sinZ
  vecY.z = cosY * sinX

  vecZ.x = -cosX * cosZ * sinY + sinX * sinZ
  vecZ.y = -cosZ * sinX + cosX * sinY * sinZ
  vecZ.z = cosX * cosY

  vecX = vector3(vecX.x, vecX.y, vecX.z)
  vecY = vector3(vecY.x, vecY.y, vecY.z)
  vecZ = vector3(vecZ.x, vecZ.y, vecZ.z)

  return vecX, vecY, vecZ
end


local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateObjects()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function DeleteVehicles()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end
end

local removeprops = ConfigCL["DeleteProp"]
local Delete = false

Citizen.CreateThread(function() 
    while true do
        Wait(0)
        if Delete then
            for i = 1, #removeprops do 
              local player = PlayerId()
              local plyPed = GetPlayerPed(player)
              local plyPos = GetEntityCoords(plyPed, false)
            
              local prop = GetClosestObjectOfType(plyPos.x, plyPos.y, plyPos.z, 200.0, GetHashKey(removeprops[i]), false, 0, 0)
              if prop ~= 0 then
                  SetEntityAsMissionEntity(prop, true, true)
                  DeleteObject(prop)
                  SetEntityAsNoLongerNeeded(prop)
                  --print(prop .. " Prop deleted")
                end
              end
        else
            Citizen.Wait(1000)
        end
    end
end)

function DeleteObjects()
  Delete = true
  Wait(5000)
  Delete = false
end