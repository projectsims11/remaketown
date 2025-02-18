
--[[
	Author: CanonX2
	Special: Fivem Server
--]]

ESX ,PlayerData, Fashion = nil , {}, {}

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent(Config["routers"]["getSharedObject"], function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
	PlayerData = ESX["GetPlayerData"]()
end)

function client_debug(...)
	if Config["debug"] then
		print("^7 [^1CLP^7][^4NEXZ_SCRIP^7][^3"..string.upper(GetCurrentResourceName()).."^7]",...,"^7")
	end
end

function rsc_name(s)
	return GetCurrentResourceName()..":"..s
end

function Start_Scrip()

	RegisterNetEvent(rsc_name("use_fashion_prop"))
	AddEventHandler(rsc_name("use_fashion_prop"), function(hex_model)
        local player_ped = GetPlayerPed(-1)
        local config_data = Config["item_setting"][ hex_model ]
        local obj_model = Config["item_setting"][ hex_model ]["obj_model"]
        local obj_data = Config["item_setting"][ hex_model ]["obj_setting"]
        if not Fashion[ hex_model ] then
            config_data["spawn_prop_model"](function(process_bar)
                if process_bar then
                    local x,y,z = table.unpack(GetEntityCoords(player_ped))
                    local obj_hex = CreateObject( GetHashKey( obj_model ) , x, y, z - 5.0, true, true, true)
                    local ObjNetID = ObjToNet(obj_hex)
                    local boneIndex = GetPedBoneIndex(player_ped, obj_data["bone"])
                    AttachEntityToEntity(obj_hex, PlayerPedId(), boneIndex, obj_data["position"]["x"], obj_data["position"]["y"], obj_data["position"]["z"], obj_data["rotation"]["x"],  obj_data["rotation"]["y"],  obj_data["rotation"]["z"], 1, 1, 0, 1, 1, 1)
                    Fashion[ hex_model ] = { ["ObjNetID"] = ObjNetID, ["model_hex"] =  obj_hex, ["status"] = true, ["model"] = obj_model }
                    TriggerServerEvent(rsc_name("save_data_prop"), ObjNetID)
                end
            end)
        else        
            config_data["delete_prop_model"](function(process_bar)
                if process_bar then
                    TriggerServerEvent(rsc_name("remove_data_prop"), Fashion[ hex_model ]["ObjNetID"])
                    DeleteEntity( Fashion[ hex_model ]["model_hex"] )
                    DeleteObject( Fashion[ hex_model ]["model_hex"] )
                    ClearPedTasks(player_ped)
                    Fashion[ hex_model ] = nil
                end
            end)
        end
	end)

	RegisterNetEvent(rsc_name("clear_fashion_prop"))
	AddEventHandler(rsc_name("clear_fashion_prop"), function(data)
        for index, idobj in pairs(data) do 
            local d_object = NetToObj(idobj)
            SetEntityAsMissionEntity(d_object, true, true)
            Citizen.Wait(500)	
            DeleteEntity( d_object )
            DeleteObject( d_object )
        end
    end)

    AddEventHandler('onResourceStop', function(resource)
        if resource == GetCurrentResourceName() then
            for index, data in pairs(Fashion) do 
                DeleteEntity( data["model_hex"] )
                DeleteObject( data["model_hex"] )
            end
        end
    end)
end

Citizen.CreateThread(function()
	Citizen.Wait(2500)
	while true do
		Citizen.Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
			Start_Scrip()
			break
		end
	end
end)

for k,v in pairs(Config["item_setting"]) do
    if v.effect then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(data.time)
                if IsUsingFashion(fashionName) then
                    local particleDictionary = data.practicle1
                    local particleName = data.practicle2

                    RequestNamedPtfxAsset(particleDictionary)

                    while not HasNamedPtfxAssetLoaded(particleDictionary) do
                        Citizen.Wait(0)
                    end
                    
                    SetPtfxAssetNextCall(particleDictionary)
                    StartNetworkedParticleFxNonLoopedOnPedBone(particleName, PlayerPedId(), 0.2, 0.0, 0.0, 0.0, -45.0, 0.0, 57005, data.scale, false, false, false)
                end
            end
        end)
    end
end