function GiveVehicle(ESX,source, hash)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if type(hash) == 'string' then
        hash = GetHashKey(hash)
    end

    local plate = GetRandomLetter(Setting['vehicle_plate_length_text']) .. ' ' .. GetRandomNumber(Setting['vehicle_plate_length_number'])
   
    plate = string.upper(plate)
    
    local vehicleProps = {dirtLevel = 5.0,model = hash,modBrakes = -1,color1 = 6,modRightFender = -1,modExhaust = -1,windowTint = -1,modAPlate = -1,modEngineBlock = -1,modBackWheels = -1,health = 1000,modWindows = -1,tyreSmokeColor = {255, 255, 255},modRearBumper = -1,modAerials = -1,modStruts = -1,modTrimA = -1,modGrille = -1,modTransmission = -1,extras = {[12] = false, [10] = false},modSmokeEnabled = false,modHorns = -1,modTrunk = -1,modArchCover = -1,modShifterLeavers = -1,pearlescentColor = 111,modLivery = -1,modSeats = -1,modSpeakers = -1,modAirFilter = -1,modSuspension = -1,modFrontBumper = -1,modDoorSpeaker = -1,wheels = 0,modEngine = -1,neonColor = {255, 0, 255},modSpoilers = -1,modFender = -1,modDashboard = -1,color2 = 0,modTurbo = false,plate = plate,modArmor = -1,modTrimB = -1,modVanityPlate = -1,plateIndex = 0,modRoof = -1,modSideSkirt = -1,modXenon = false,modSteeringWheel = -1,wheelColor = 156,modFrame = -1,modOrnaments = -1,modTank = -1,modHydrolic = -1,modHood = -1,modFrontWheels = -1,modPlateHolder = -1,modDial = -1,neonEnabled = {false, false, false, false}
    }   

    --แก้เพียงส่วนนี้เท่านั้น
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle,  `stored` ) VALUES (@owner, @plate, @vehicle, 1)',{
        ['@owner'] = xPlayer.identifier, 
        ['@plate'] = vehicleProps.plate, 
        ['@vehicle'] = json.encode(vehicleProps) 
    },function()
        print('Reward ' .. hash .. '    vehicle (PLATE:' .. plate .. ') to ' .. xPlayer.identifier)
        TriggerClientEvent("Fewthz_inventory:getOwnerVehicle", _source)
    end)
end