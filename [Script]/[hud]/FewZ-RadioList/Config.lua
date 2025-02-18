Config = {}

Config.UseRPName = true 							-- If set to true, it uses either esx-legacy or qb-core built-in function to get players' RP name

Config.LetPlayersChangeVisibilityOfRadioList = true	-- Let players to toggle visibility of the list
Config.RadioListVisibilityCommand = "radiolist" 	-- Only works if Config.LetPlayersChangeVisibilityOfRadioList is set to true

Config.LetPlayersSetTheirOwnNameInRadio = true		-- Let players to customize how their name is displayed on the list
Config.ResetPlayersCustomizedNameOnExit = true		-- Only works if Config.LetPlayersSetTheirOwnNameInRadio is set to true - Removes customized name players set for themselves on their server exit
Config.RadioListChangeNameCommand = "nameinradio" 	-- Only works if Config.LetPlayersSetTheirOwnNameInRadio is set to true

Config.RadioChannelsWithName = {
	["0"] = "Admin",
	["1"] = "Police",
	["2"] = "Police",
	["3"] = "Mechanic",
	["4"] = "Mechanic",
	["5"] = "Ambulance",
	["6"] = "Ambulance",
	["7"] = "Alljob",
}


-- ##################
-- rp-radio ไปที่ client ค้นหาคำว่า exports["pma-voice"]:setVoiceProperty("radioEnabled", Radio.On)
-- สั่งเกตุด้านล่างให้แก้ไขตามนี้
-- if Radio.On then
-- 	SendNUIMessage({ sound = "audio_on", volume = 0.3})
-- 	Radio:Add(radioConfig.Frequency.Current)
-- 	TriggerServerEvent("FewZ-RadioList:SV:AddAllUI", radioConfig.Frequency.Current)
-- else
-- 	SendNUIMessage({ sound = "audio_off", volume = 0.5})
-- 	Radio:Remove()
-- 	TriggerServerEvent("FewZ-RadioList:SV:RemoveAllUI")
-- end





