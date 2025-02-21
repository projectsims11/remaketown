local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169,
	["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162,
	["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199,
	["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82,
	["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61,
	["N9"] = 118
}



ESX              = nil
local MRBName    = GetCurrentResourceName()
local PlayerData = nil

Bunny = {
	player 	= nil,
	name 	= nil,
	Coords 	= nil,
}
Box = nil
Hunting = false
TimePlay = nil

local myserverid = nil



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config['Event'].FrameWork_Client, function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
	PlayerData = ESX.GetPlayerData()
	myserverid = GetPlayerServerId(PlayerId())
	
	Citizen.Wait(3000)
	SendNUIMessage({
		
		action = "sendInfo",
		SoundStart = Config['Sounds'].Begin,
		SoundEnd =  Config['Sounds'].Finish,

	})

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent(MRBName .. "CheckEvent")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

local ObjectStackPlayer = {}


RegisterNetEvent(MRBName .. "SendinfoUnlucky")
AddEventHandler(MRBName .. "SendinfoUnlucky", function(data, flag, Time)
	ClearObjectStack()
	DeleteBox()
	TimePlay = Time
	Hunting = flag
	Bunny = data
	if Config['Object_attach'] ~= nil and next(Config['Object_attach']) ~= nil then
		if myserverid == Bunny.player then
			for k,v in pairs(Config['Object_attach']) do
				WhileHasModelLoaded(GetHashKey(v.Model))
				local HandObject = CreateObject(GetHashKey(v.Model), 0, 0, 0, true, false, false)
				SetObjectAsNoLongerNeeded(GetHashKey(v.Model))
				SetEntityAsMissionEntity(HandObject, 1, 1)
				SetNetworkIdCanMigrate(HandObject, true)
				AttachEntityToEntity(HandObject, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), v.Bone), v.xPos, v.yPos, v.zPos,v.xRot, v.yRot, v.zRot, false, false, false, false, 0, true)
				table.insert(ObjectStackPlayer, HandObject)
			end
		end
	end
	if Hunting == true then --* เกมเริ่ม
		CaptureFace()
		if Bunny.player ~= nil then
			DeleteBox()
		else
			SpawnBoxObject()
		end
	else --* จบเกม รับของรางวัล
		ClearObjectStack()
		if Config.Object_attach ~= nil then
			local weather = string.upper("CLEAR")
			SetWeatherTypePersist(weather)
			SetWeatherTypeNow(weather)
			SetWeatherTypeNowPersist(weather)
		end
		DeleteBox()
		CloseUi(Bunny.name)
		if myserverid == Bunny.player then
			TriggerServerEvent(MRBName .. "FinishHunt")
		end
	end
end)

Citizen.CreateThread(function()
  while true do
	Citizen.Wait(1000)
	if Hunting == true then
		local Found = false
		for k,v in pairs(Config.Object_attach) do
			if v.weather ~= nil then
				Found = true
				local weather = string.upper(v.weather)
				SetWeatherTypePersist(weather)
				SetWeatherTypeNow(weather)
				SetWeatherTypeNowPersist(weather)
			end
		end
		if Found == false then
			break
		end
	end
   end
end)

function WhileHasModelLoaded(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
end

RegisterNetEvent(MRBName.."getlocations")
AddEventHandler(MRBName.."getlocations", function(crs)
	Bunny.Coords = crs
end)


function CaptureFace()
	if Bunny.player ~= nil then
		ShowFace()
	else
		SendNUIMessage({
			action = "setData",
			type = "box",
			name = ".............",
			url = Config['Systems'].img_box	
		})
	end
end




function ShowFace()
	local player = GetPlayerFromServerId(Bunny.player)
	if player ~= -1 then
		local playerPed = GetPlayerPed(player)
		local handle = RegisterPedheadshot(playerPed)
		while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
			Wait(100)
		end
		local headshot = GetPedheadshotTxdString(handle)
		SendNUIMessage({
			action = "setData",
			type = "person",
			name = Bunny.name,
			url = headshot
		})
	else
		Citizen.Wait(5000)
		if Hunting == true then
			if Bunny.player ~= nil then
				ShowFace()
			end
		end
	end
end



function CloseUi(name)
	--TODO ปิด Ui ตรงนี้
	SendNUIMessage({
		action = "nuiStatus",
		display = false,
		name = name,
		time =  Config['Set_DefaultCommands'].timeShow

	})
end

function SpawnBoxObject()
	if Bunny.Coords ~= nil then
		print("SPawn !! ")
		if Box ~= nil then
			DeleteEntity(Box)
			Box = nil
		end
		if Box == nil then
			local modelHash = Config.Systems.Object
			if not HasModelLoaded(modelHash) then

				RequestModel(modelHash)
			
				while not HasModelLoaded(modelHash) do
					Citizen.Wait(1)
				end
			end
			local newcoords = GenerateCrabCoords(Bunny.Coords.x,Bunny.Coords.y,Bunny.Coords.z)
			Box = CreateObject(modelHash, newcoords, false)
			PlaceObjectOnGroundProperly(Box)
		end
	end
end

function DeleteBox()
	if Box ~= nil then
		DeleteEntity(Box)
		Box = nil
	end
end


Citizen.CreateThread(function() --* เวลา จบเกม
	while true do
		Citizen.Wait(1000)
		if Hunting == true then
			if TimePlay ~= nil then
				SendNUIMessage({
					action = "nuiStatus",
					display = true
				})
				TimePlay = TimePlay - 1
				if TimePlay <= 0 then
					Hunting = false
					print("dddddd",Bunny.name)
					CloseUi(Bunny.name)
					DeleteBox()
				end
			end
			SendNUIMessage({
				action = "setTime",
				time = TimePlay
			})
		else
			Citizen.Wait(1000)
		end
	end
end)

function ClearObjectStack()
	if next(ObjectStackPlayer) ~= nil then
		for k,v in pairs(ObjectStackPlayer) do
			DeleteEntity(v)
		end
	end
end

AddEventHandler(Config['Event'].onPlayerDeath, function(data)
	ClearObjectStack()
	if Hunting == true then
		if Bunny.player == myserverid then
			TriggerServerEvent(MRBName .. "BunnyDeath",GetEntityCoords(PlayerPedId()))
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if Box ~= nil then
			DeleteEntity(Box)
		end
		for k,v in pairs(ObjectStackPlayer) do
			DeleteEntity(v)
		end
	end
end)

local Press = false

Citizen.CreateThread(function() --* สร้าง Marker และ เก็บกล่อง
	while true do
		Citizen.Wait(0)
		if Hunting == true then
			if Bunny.player ~= nil then
				local player = GetPlayerFromServerId(Bunny.player)
				local plPed = GetPlayerPed(player)
				local coords = GetEntityCoords(plPed)
				if player == -1 and Bunny.player ~= myserverid then
					--TODO ทำรูปคนหน้างง
					SendNUIMessage({
						action = "setData",
						type = "unknown",
						name = Bunny.name,
					})
				else
					if GetDistanceBetweenCoords(coords, GetEntityCoords(PlayerPedId()), true) < 100 then
						if Config.Systems.Show_Myself_Marker == true then
							ShowMarker(coords.x, coords.y, coords.z)
						else
							if myserverid ~= Bunny.player then
								if player ~= -1 then
									ShowMarker(coords.x, coords.y, coords.z)
								else
									Citizen.Wait(500)
								end
							end
						end
					else
						Citizen.Wait(1000)
					end
					
				end
			else
				if Box ~= nil then
					local myc = GetEntityCoords(PlayerPedId())
					local Coords = GetEntityCoords(Box)
					local Dist = GetDistanceBetweenCoords(myc,Coords,true)
					if Press== false then
						if Dist < 60.5 then
							SeeMarkerBox(Coords.x,Coords.y,Coords.z)
							if Dist < 1.5 then
								ShowTextOnBox(Coords.x,Coords.y,Coords.z)
								if IsDisabledControlJustPressed(0,Keys[Config.Systems.Keys]) then
									Press = true
									LootBox()
								end
							end
						else
							Citizen.Wait(1000)
						end
					else
						Citizen.Wait(1000)
					end
				end
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

function LootBox()
	Loading()
	Press = false
	local playerPed = GetPlayerPed(-1)
	if IsEntityDead(playerPed) then
		CannotLoot()
	else
		Citizen.Wait(math.random(100,350))
		TriggerServerEvent(MRBName .. "PickupBox")
	end
end

RegisterNetEvent('SendCoordsNa')
AddEventHandler('SendCoordsNa', function()
	local coords = GetEntityCoords(PlayerPedId())
	TriggerServerEvent(MRBName .. "SendCoordsNa",coords)
end)

Citizen.CreateThread(function()
  while true do
	Citizen.Wait(1000)
	 if Hunting == true then
		if Bunny.player ~= nil then
			if Bunny.player == myserverid then
				if Config.Systems.clientcoords == true then
					if Config['Systems'].Onesync_Legacy_Or_Infinity == true then
						local coords = GetEntityCoords(PlayerPedId())
						TriggerServerEvent(MRBName .. "SendCoordsNa",coords)
					end
				end
			end
		end
	 else
		Citizen.Wait(1000)
	 end
   end
end)

local BlipNow = nil
Citizen.CreateThread(function() --* สร้าง Blips
	while true do
		Citizen.Wait(250)
		if BlipNow ~= nil then
			RemoveBlip(BlipNow)
			BlipNow = nil
		end
		if Hunting == true then
			local Pass = true
			if Config.Systems.Show_Myself_Blip == false then
				if Bunny.player ~= nil then
					if Bunny.player == myserverid then
						Pass = false
					end
				end
			end
			if Pass == true then
				if Bunny.player ~= nil then
					local player = GetPlayerFromServerId(Bunny.player)
					if player == -1 and Bunny.player ~= myserverid then
						local blip1 = AddBlipForCoord(Bunny.Coords.x, Bunny.Coords.y, Bunny.Coords.z)
						SetBlipSprite(blip1, Config.Blips.Id)
						SetBlipDisplay(blip1, 4)
						SetBlipScale(blip1, Config.Blips.Size)
						SetBlipColour(blip1, Config.Blips.Color)
						SetBlipAsShortRange(blip1, true) 
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(Config.Blips.Text)
						EndTextCommandSetBlipName(blip1)
						BlipNow = blip1
					else
						local plPed = GetPlayerPed(player)
						local coords = GetEntityCoords(plPed)
						local blip1 = AddBlipForCoord(coords.x, coords.y, coords.z)
						SetBlipSprite(blip1, Config.Blips.Id)
						SetBlipDisplay(blip1, 4)
						SetBlipScale(blip1, Config.Blips.Size)
						SetBlipColour(blip1, Config.Blips.Color)
						SetBlipAsShortRange(blip1, true) 
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(Config.Blips.Text)
						EndTextCommandSetBlipName(blip1)
						BlipNow = blip1
					end
				elseif Bunny.Coords ~= nil then
					local blip1 = AddBlipForCoord(Bunny.Coords.x, Bunny.Coords.y, Bunny.Coords.z)
					SetBlipSprite(blip1, Config.Blips.Id)
					SetBlipDisplay(blip1, 4)
					SetBlipScale(blip1, Config.Blips.Size)
					SetBlipColour(blip1, Config.Blips.Color)
					SetBlipAsShortRange(blip1, true) 
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(Config.Blips.Text)
					EndTextCommandSetBlipName(blip1)
					BlipNow = blip1
				end
			end

		else
			Citizen.Wait(1000)
		end
	end
end)

local flagUi = true
local OpenFlag = false
RegisterCommand('ShowWanted'..Config['Systems'].Show_Big_wanted, function()
	if OpenFlag == false then
		OpenFlag = true
		Citizen.CreateThread(function()
		   Citizen.Wait(800)
		   OpenFlag = false
		end)
		if flagUi then
			SendNUIMessage({
				action= "checkPaper",
				display= true
			})
			flagUi = false
		else 
			SendNUIMessage({
				action= "checkPaper",
				display= false
			})
			flagUi = true
		end
	end
	
end, false)


Citizen.CreateThread(function()
  while true do
	Citizen.Wait(1000)
	if Hunting == true then
		if Bunny.player ~= nil and Bunny.player == myserverid then
			local ped = PlayerPedId()
			local health = GetEntityHealth(ped)
			for k,v in pairs(Config['ability']) do
				if k == "onwater" and v.Enable == true then
					if IsEntityInWater(PlayerPedId()) then
						SetEntityHealth(ped, health-v.health)
					end
				elseif k == "invehicle" and v.Enable == true then
					if IsPedInAnyVehicle(ped, false) then
						SetEntityHealth(ped, health-v.health)
					end
				elseif k == "Zones_Blacklist" then
					if v ~= nil and next(v) ~= nil then
						local myc = GetEntityCoords(ped)
						for _,info in pairs(v) do
							if GetDistanceBetweenCoords(myc,info.coords,true) < info.range then
								SetEntityHealth(ped, health-info.health)
							end
						end
					end
				end
			end
		else
			Citizen.Wait(2000)
		end
	else
		Citizen.Wait(2000)
	end
   end
end)

RegisterKeyMapping('ShowWanted'..Config['Systems'].Show_Big_wanted, 'ShowWanted', 'keyboard', Config['Systems'].Show_Big_wanted)

function MRB_IsHunting()
	return Hunting
end