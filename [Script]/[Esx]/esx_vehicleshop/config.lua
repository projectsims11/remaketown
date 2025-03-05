Config = {}

Config.TrunkCapacity = 18;

Config.TrunkVanCapacity = 50;

Config.Vehicles = {}
Config.Boat = {}

Config.PlatePrice = 15000

Config.PlatePayItem = false

Config.KeySystemByItem = true

Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true
Config.PlayerCount	= 10

Config.Vehicles["offroad150Kg"] = {
{ label = "Blazer2", name = "Blazer2", price = 1000000 },
-- { label = "Sandking2", name = "sandking2", price = 60000 },
} 

  
Config.Vehicles["sports"] = {
  { label = "Tenf", name = "Tenf", price = 500000 },
  { label = "Sultan", name = "Sultan", price = 500000 },
  { label = "Reaper", name = "Reaper", price = 500000 },
 
}

Config.Vehicles["Cycles"] = {
  { label = "bmx", name = "bmx", price = 5000 },
  { label = "cruiser", name = "cruiser", price = 5000 },
  { label = "fixter", name = "fixter", price = 5000 },
  { label = "scorcher", name = "scorcher", price = 5000 },
  { label = "tribike", name = "tribike", price = 5000 },
  { label = "tribike2", name = "tribike2", price = 5000 },
  { label = "tribike3", name = "tribike3", price = 5000 },
}
-- Config.Boat["Main"] = {
--   { label = "tug", name = "tug", price = 1000 },
-- } 
 
 


 

Config.Shops = {
  { 
    name = "<font face='font4thai'>ร้านขายรถ</font>", 
    Vehicles = Config.Vehicles,
    type = "car", -- car  --- boat -- helicopter
    job = false,
    MoneyIsItem = false,  -- if u change false using 
    blackMoney = false, 
    testDrive = true,
    showroom = false, 
    editPlate = false,
    coord = vector3(-33.9900016784668, -1101.93994140625, 26.019999313354495),
    camCoord = vector3(403.01068115234, -962.32613525391, -97.504096984863),
    camRot = vector3(215.5, 180.00, 12.00),
    dist = 2.0,
    carSpawnCoord = vector4(404.90100097656, -966.78149414063, -99.004096984863, 43.07537841797),
    deliveryCoord = vector4(-48.906772613525, -1077.6535644531, 26.81402015686, 66.28524017334),
  },

  -- {  -- 1262.903, y=-3344.805,z = 5.908319
  --   name = "Galery", 
  --   Vehicles = Config.Boat, 
	--   type = "boat", -- car  --- boat -- helicopter
  --   job = false,
	--   MoneyIsItem = false,  -- if u change false using 
  --   blackMoney = false, 
	--   testDrive = false,
  --   showroom = false, 
	--   editPlate = false,
  --   coord = vector3(-3427.19, 967.16, 8.34), -- 1236.513, -3355.634, 3.029732, 175.81
  --   camCoord = vector3(-3398.76, 1059.14, 15.45), -- มุมกล้อง
  --   camRot = vector3(215.5, 180.00, 1.00),
  --   dist = 2.0,
  --   carSpawnCoord = vector4(-3396.87, 1038.69, 0.59 , 267.50),
  --   deliveryCoord = vector4(-3441.7, 977.05, 3.06, 79.9),
  -- },
 
}


Config.TestDrive = {
	seconds = 15,
	coords  = vector3(-966.5, -3355.7, 13.9),
	range   = 400,
}

 