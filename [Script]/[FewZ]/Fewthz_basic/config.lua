Config	= {}

Config["Fewthz-Router"] = {
	["client_shared_obj"] = "esx:getSharedObject",
	["server_shared_obj"] = "esx:getSharedObject",
	["client_player_load"] = "esx:playerLoaded",
	["client_player_setjob"] = "esx:setJob",
	["client_player_getskin"] = "skinchanger:getSkin",
	["client_player_loadclothes"] = "skinchanger:loadClothes",
	["client_closehud"] = "fewthz-inventory:closeHud"
}

Config["Ammo_Count"] = 10 -- จำนวนกระสุนต่อ 1 แม็กกาซีน

Config["Item"] = {
	["Ammo"] = "clip", -- ชื่อไอเท็ม แม็กกระสุน
	["Nightvision"] = "nightvision", -- ชื่อไอเท็ม กล้องอินฟาเรด
	["Thermalvision"] = "thermalvision" -- ชื่อไอเท็ม กล้องจับความร้อน
}

Config["Text_Alert"] = {
	["AddAmmo"] = "<strong class='blue-text'>ช่วยเหลือ</strong> คุณได้เพิ่มจำนวนกระสุน จำนวน <strong class='yellow-text'>"..Config["Ammo_Count"].."</strong> นัด",
	["Not_Weapon"] = "<strong class='red-text'>ล้มเหลว</strong> คุณไม่มีอาวุธอยู่ในมือ",
	["Not_Work"] = "<strong class='red-text'>ล้มเหลว</strong> กระสุนไม่เหมาะกับอาวุธนี้"
}

Config["CameraClothes"] = {
    male = {
        ['mask_1'] = 132,  ['mask_2'] = 0
    },
    female = {
        ['mask_1'] = 132,  ['mask_2'] = 0
    }
}