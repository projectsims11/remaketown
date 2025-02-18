
--[[
	Author: CanonX2
	Special: Fivem Server
    Discord : https://discord.gg/Ns9jcjvuxc
--]]

Config = {}

Config["Keys"] = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

--[[
	[+]Blip_sprite สามารถดูได้ที่นี้ https://docs.fivem.net/docs/game-references/blips/ 
	[+]Marker สามารถดูได้ที่นี้ https://docs.fivem.net/docs/game-references/markers/
	[+]Model สามารถดูได้ที่นี้ https://mwojtasik.dev/tools/gtav/objects
	[+]Position คือตำแหน่งของพื่นที่วางตำแหน่งโต๊ะคราฟ
--]]

Config["Font"] = "sarabun"	-- รูปแบบตัวอักษร
Config["Image_Source"] = "nui://Fewthz_inventory/html/img/items/" -- ตำแหน่งรูปภาพ
Config["Animation"] = {"anim@amb@business@coc@coc_unpack_cut_left@","cut_cough_coccutter"}
Config["Craft_Table"] = {
	{
		Position = {x = 1728.0699462890625, y = 3321.840087890625, z = 41.22000122070312, h = 15.00},
		Table_Name = "โต๊ะคราฟไอเทม",
		Max_Distance = 2.2,
		Disable_Model = false, -- ปิดโมเดล
		Model = GetHashKey("gr_prop_gr_bench_03b"),
		Name = "~y~โต๊ะคราฟ",
		Desc = "โต๊ะคราฟใหม่ที่นี่",
		Map_blip = true,
 		Blip_name = '<font face="sarabun">เรเบล</font>',
		Blip_sprite = 255, -- สำหรับเปลี่ยน รูปแบบ ของ blip
		Blip_scale = 0.8,
		Blip_color = 1,
		Category = { 2 , 3 , 4 , 5 , 6 }, -- โต๊ะตัวนี้จะมีหมวดอะไร อิงจาก Config[category]
	},

	{
		Position = {x = 1723.1800537109375, y = 3306.330078125, z = 41.22000122070312, h = 15.00},
		Table_Name = "โต๊ะคราฟยา",
		Max_Distance = 2.2,
		Disable_Model = false, -- ปิดโมเดล
		Model = GetHashKey("bkr_prop_meth_chiller_01a"),
		Name = "~y~โต๊ะคราฟยา",
		Desc = "โต๊ะคราฟยาที่นี่",
		Map_blip = false,
 		Blip_name = '<font face="sarabun">เรเบล</font>',
		Blip_sprite = 255, -- สำหรับเปลี่ยน รูปแบบ ของ blip
		Blip_scale = 0.8,
		Blip_color = 1,
		Category = { 10 }, -- โต๊ะตัวนี้จะมีหมวดอะไร อิงจาก Config[category]
	},
	
	

	--{
	--	Position = {x = -172.305, y = 294.0081, z = 93.762, h = 327.51},
	--	Table_Name = "โต๊ะคราฟอาหาร",
	--	Max_Distance = 2.3,
	--	Disable_Model = true, -- ปิดโมเดล
--
	--	Marker = true, -- เปิด marker
	--	Marker_Scale = {3.5,3.5,0.01}, -- ขนาดของ marker กว้าง ยาว สูง
	--	Marker_Color = {0,0,0}, -- สีของ marker แบบ rgb			
--
	--	Map_blip = true,
 	--	Blip_name = "Food CraftingTable",
	--	Blip_sprite = 12, -- สำหรับเปลี่ยน รูปแบบ ของ blip
	--	Blip_scale = 1.2,
	--	Blip_color = 47,
--
	--	Category = { 4 }, -- โต๊ะตัวนี้จะมีหมวดอะไร อิงจาก Config[category]
	--},

	{
		Position = {x = 389.6099853515625, y = -355.8999938964844, z = 48.02000045776367, h = 100.00},
		Table_Name = "เตาทำอาหาร",
		Max_Distance = 2.3,
		Disable_Model = false, -- ปิดโมเดล	-

		Model = GetHashKey("prop_cooker_03"),
		Name = "~y~เตาทำอาหาร",
		Desc = "ปรุงอาหารสดใหม่ที่นี่",

		Map_blip = true,
 		Blip_name = '<font face="sarabun">เตาทำอาหาร</font>',
		Blip_sprite = 266, -- สำหรับเปลี่ยน รูปแบบ ของ blip
		Blip_scale = 0.8,
		Blip_color = 47,

		Category = { 8 }, -- โต๊ะตัวนี้จะมีหมวดอะไร อิงจาก Config[category]
		--job = {"police","medic"},
	},
}


