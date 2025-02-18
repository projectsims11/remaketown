
--[[
	Author: CannonX2
	Special: Fivem Server
--]]

ESX, PlayerDataProp = nil, {}

TriggerEvent(Config["routers"]["getSharedObject"], function(obj) ESX = obj end)

function rsc_name(s)
	return GetCurrentResourceName()..":"..s
end

function sv_debug(...)
	if Config["debug"] then
		print("\27[0m[\27[31mSDB\27[0m]\27[33m\27[0m[\27[42m ".. GetCurrentResourceName() .." \27[0m]\27[0m = \27[38m",...,"\27[0m\27[0m")
	end
end

function StartScrip()

    for k,v in pairs(Config["item_setting"]) do
        sv_debug("register use item [ "..k.." ]")
        ESX.RegisterUsableItem(k, function(source)
            TriggerClientEvent(rsc_name("use_fashion_prop"), source, k)
        end)
    end

    RegisterServerEvent(rsc_name("save_data_prop"))
	AddEventHandler(rsc_name("save_data_prop"), function(hex_model)
        local _source = source
        if not PlayerDataProp[_source] then PlayerDataProp[_source] = {} end
        PlayerDataProp[_source][hex_model] = hex_model
	end)

    RegisterServerEvent(rsc_name("remove_data_prop"))
	AddEventHandler(rsc_name("remove_data_prop"), function(hex_model)
        local _source = source
        PlayerDataProp[_source][hex_model] = nil
	end)

    AddEventHandler('playerDropped', function(reason)
        local _source = source
        if PlayerDataProp[_source] ~= nil and PlayerDataProp[_source][1] ~= nil then
            TriggerClientEvent(rsc_name("clear_fashion_prop"), -1, PlayerDataProp[_source])
            PlayerDataProp[_source] = nil
        end
    end)

end
StartScrip()
