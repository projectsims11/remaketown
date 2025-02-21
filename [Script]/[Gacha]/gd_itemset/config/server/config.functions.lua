function generatePlateNumber()
     local plateNumber = ""
     for i = 1, Config.PlateLetters do
          local randomChar = string.char(math.random(65, 90))
          plateNumber = plateNumber .. randomChar
     end
     if Config.PlateUseSpace then
          plateNumber = plateNumber .. " "
     end
     for i = 1, Config.PlateNumbers do
          local randomDigit = math.random(0, 9)
          plateNumber = plateNumber .. randomDigit
     end
     return plateNumber
end

Config.ServerGeneratePlate = function()
     -- ใช้ฟังชั่นสำหรับสร้างป้ายทะเบียนรถ
     local plate = generatePlateNumber()
     return plate
end
