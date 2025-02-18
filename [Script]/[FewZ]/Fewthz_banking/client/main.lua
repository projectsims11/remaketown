ESX = exports["es_extended"]:getSharedObject()

inMenu                      = false
local PlayerData = {}
local bankMenu = true
local FewZ = GetCurrentResourceName()

-- ATM Object 
local ATMs = {
    {o = -870868698, c = 'blue'}, 
    {o = -1126237515, c = 'blue'}, 
    {o = -1364697528, c = 'red'}, 
    {o = 506770882, c = 'green'}
}

local isMenuOpen = false

if bankMenu then
	Citizen.CreateThread(function()
		while true do
			if nearATM() and not inMenu then
				exports["Fewthz_TextUI"]:ShowHelpNotification('Press ~INPUT_CONTEXT~ Open Banking')
				if IsControlJustPressed(1, 38) then
					inMenu = true
					SetDisplay(not display)
					TriggerServerEvent(FewZ..'balance')
					local ped = GetPlayerPed(-1)
					openPlayersBank('bank')
				end
			else
				Wait(500)
			end
			Citizen.Wait(0)
		end
	end)
end



function closePlayersBank()

    local dict = 'anim@amb@prop_human_atm@interior@male@exit'
    local anim = 'exit'
    local ped = GetPlayerPed(-1)
    local time = 1000


    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    Citizen.Wait(time)
    ClearPedTasks(ped)
    inMenu = false
end

function openPlayersBank(type, color)
    local dict = 'anim@amb@prop_human_atm@interior@male@enter'
    local anim = 'enter'
    local ped = GetPlayerPed(-1)
    local time = 1000


    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end

    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)

    Citizen.Wait(time)
    ClearPedTasks(ped)
    if type == 'bank' then
        inMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'openBank', color = bankColor})
        TriggerServerEvent('orp:bank:balance')
        atATM = false
    elseif type == 'atm' then
        inMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'openBank', color = bankColor})
        TriggerServerEvent('orp:bank:balance')
        atATM = true
    end
end

if Config.BankBlip then 
	Citizen.CreateThread(function()
		if Config.Blip then
			for k,v in ipairs(Config.banks)do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, v.id)
			SetBlipScale(blip, 0.7)
			SetBlipAsShortRange(blip, true)
			if v.principal ~= nil and v.principal then
				SetBlipColour(blip, 77)
			end
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(tostring(v.name))
			EndTextCommandSetBlipName(blip)
			end
		end
	end)
end

if Config.AtmBlip then 
	Citizen.CreateThread(function()
		if Config.Blip then
			for k,v in ipairs(Config.atms)do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, v.id)
			SetBlipScale(blip, 0.7)
			SetBlipAsShortRange(blip, true)
			if v.principal ~= nil and v.principal then
				SetBlipColour(blip, 77)
			end
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(tostring(v.name))
				EndTextCommandSetBlipName(blip)
			end
		end
	end)
end

RegisterNUICallback("exit", function(data) 
	inMenu = false
	SetDisplay(false)
	closePlayersBank('closeAll')
	SetNuiFocus(false, false)
    isMenuOpen = false
end)


function SetDisplay(bool)
	local PlayerIdme = GetPlayerServerId(PlayerId())
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
		player = GetPlayerName(PlayerId()),
		playerid = PlayerIdme
    })
end



RegisterNetEvent('updateKonto')
AddEventHandler('updateKonto', function(money,monneyacount)
	local PlayerId = GetPlayerServerId(PlayerId())
	SendNUIMessage({
		type = "update",
		money = money,
		monneyacount = monneyacount,
		logo =  Config.supderlogo,
		player = playername,
		playerid = PlayerId

	})
end)


RegisterNUICallback('deposit', function(data)
	TriggerServerEvent(FewZ..'deposit', tonumber(data.amountw))
	TriggerServerEvent(FewZ..'balance')
 
end)

RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent(FewZ..'withdraw', tonumber(data.withdrawl))
	TriggerServerEvent(FewZ..'balance')
end)

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent(FewZ..'transfer', data.transferIdInput, data.transferAmountInput)
	TriggerServerEvent(FewZ..'balance')
end)

function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(Config.banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 3 then
			return true
		end
	end
end

function nearATM()
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player)

    for i = 1, #ATMs do
        local atm = GetClosestObjectOfType(playerloc.x, playerloc.y, playerloc.z, 1.0, ATMs[i].o, false, false, false)
        local atmPos = GetEntityCoords(atm)
        local dist = GetDistanceBetweenCoords(playerloc.x, playerloc.y, playerloc.z, atmPos.x, atmPos.y, atmPos.z, true)
        if dist < 1.5 then
            return true
        end
    end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent(FewZ..'bank:notify')
AddEventHandler(FewZ..'bank:notify', function(type, message)
    exports['mythic_notify']:DoHudText(type, message)
end)

AddEventHandler("Fewthz_core:ClientMemoryGarbage", function()
	Citizen.CreateThread(function()
		Wait(math.random(100, 2000))
		collectgarbage()
	end)
end)