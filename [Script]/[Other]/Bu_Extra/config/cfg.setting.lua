cfg = {}

cfg.FrameWork = { -- รายละเอียด FrameWork
    Main = "esx:getSharedObject",
    Dropped = "esx:playerDropped",
    Death = "esx:onPlayerDeath",
    Spawned = "playerSpawned",
    Inventory = {
        Add = "esx:addInventoryItem",
        Remove = "esx:removeInventoryItem",
        ItemImages = "Fewthz_inventory/html/img/items",
    },
    VehicleImages = "Fewthz_inventory/DESIGN/IMAGE",
}

cfg.Vehicles = { -- แสดงยานพาหนะในเมนูสร้างโค้ด และเช็คข้อมูลของสิ่งของหมดอายุ
    { Model = "bmx", Type = "car" },
    { Model = "guardian", Type = "car" },
    { Model = "t20", Type = "car" }
}