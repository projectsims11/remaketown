ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local qcount = 0

 
ESX.RegisterServerCallback('esx_vehicleshop::checkPlatePrice', function(source, cb, plate) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local xi = tonumber(xPlayer.getMoney())
	 

    if Config.PlatePayItem ~= false then 
      if xPlayer.getInventoryItem(Config.PlatePayItem) then 
        xi = tonumber(xPlayer.getInventoryItem(Config.PlatePayItem).count)
      end
    end
 

    if xi >= Config.PlatePrice then 
      cardata = MySQL.Async.fetchSync("SELECT plate FROM owned_vehicles WHERE plate='"..plate.."' ", {})
	  
      if #cardata == 0 then 
        
        if Config.PlatePayItem ~= false then 
		 if xPlayer.getInventoryItem(Config.PlatePayItem) then 
          xPlayer.removeInventoryItem(Config.PlatePayItem, Config.PlatePrice)
		  cb(true)
		 end
        else 
          xPlayer.removeMoney(Config.PlatePrice)
		  cb(true)
        end
      end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough money.'})
    end
end)
 
ESX.RegisterServerCallback('esx_vehicleshop:retrieveJobVehicles', function (source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
		}, function (result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_vehicleshop:checkPrice', function(source, cb, data) 
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = "cash"
	  local curGarage = data.curGarage
	
    local i = tonumber(xPlayer.getMoney())

    if curGarage.MoneyIsItem ~= false then 
	  item = curGarage.MoneyIsItem
      if xPlayer.getInventoryItem(item) then 
        i = tonumber(xPlayer.getInventoryItem(item).count)
      end
    end
	
	if data.blackMoney == true then 
       i = tonumber(xPlayer.getAccount("black_money").money)
	   
	   if i >= data.price then 
         xPlayer.removeAccountMoney("black_money", data.price)
         if tonumber(xPlayer.getAccount("black_money").money) == (i - data.price) then -- two auth
            cb(true)
         end
	   end
	   
	else
   
    if i >= data.price then 
       if curGarage.MoneyIsItem ~= false then 
         xPlayer.removeInventoryItem(item, data.price)
         if tonumber(xPlayer.getInventoryItem(item).count) == (i - data.price) then -- two auth
            cb(true)
         end
       else 
         xPlayer.removeMoney(data.price)
         if tonumber(xPlayer.getMoney()) == (i - data.price) then -- two auth
            cb(true)
         end
       end
             
    end
	
	end
end)
 

RegisterNetEvent('esx_vehicleshop::server:givecar')
AddEventHandler('esx_vehicleshop::server:givecar', function(props, curGarage, vehiclemodel)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    local date = os.date("%Y-%m-%d %H:%M:%S")
    MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES ('"..Player.identifier.."', '"..props.plate.."', '"..json.encode(props).."', '"..curGarage.type.."')",
     {  },function (rowsChanged)
      
		TriggerClientEvent("esx_inventoryhud:getOwnerVehicle", src)
    -- TriggerEvent('azael_ui-itemnotify:sendInventoryItem', 'set', props.plate, 1)
    
    -- สำหรับ แจ้งเตือนได้รับ กุญแจ azael_ui-itemnotify
    -- TriggerClientEvent('azael_ui-itemnotify:sendNotification', src, {
    --   text = 'add',
    --   name = 'vehicle_key',  
    --   label = props.plate,
    --   count = '🚗'..ESX.Math.GroupDigits(1)
    -- })
    
    -- สำหรับ my_thic 
    TriggerClientEvent('mythic_notify:client:SendAlert', src, {
      type = 'success',
      text = 'คุณได้รับกุญแจรถ ' .. props.plate .. '.'
    })

    local sendToDiscord = 'ผู้เล่น'..Player.name..'ซื้อรถทะเบียน'..props.plate..'แล้ว'
    TriggerEvent('RePlayX_LogDiscord:sendToDiscord', 'Buycar', sendToDiscord, src , '^2')
    end)
end)


ESX.RegisterServerCallback('esx_vehicleshop:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)



ESX.RegisterServerCallback('esx_vehicleshop::QPlayer', function(source, cb)
	if qcount < Config.PlayerCount then
		cb(true)
	else
		cb(false)
	end
end)

RegisterNetEvent('esx_vehicleshop::QPlayerCount')  -- for gacha
AddEventHandler('esx_vehicleshop::QPlayerCount', function()
	qcount = qcount + 1
end)

RegisterNetEvent('esx_vehicleshop::QPlayerCheck')  -- for gacha
AddEventHandler('esx_vehicleshop::QPlayerCheck', function()
	qcount = 0
	TriggerClientEvent('esx_vehicleshop::PutC', -1)
end)







