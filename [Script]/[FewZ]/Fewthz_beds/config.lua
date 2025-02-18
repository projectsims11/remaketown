local sec                   = 1000
Config              		= {}
Config.SocietyAmbulance		= true		-- true เปิดระบบ Config.SocietyAccount / false ลบเงินในตัว เงินจะไม่เข้ากองกลาง คือ หายไปเลย
Config.SocietyAccount		= false		-- true เข้ากองกลางโดยตรง / false บิล
Config.Billname				= 'ค่ารักษานอนเตียง'
Config.Money				= 200		-- จำนวนเงิน
Config.Time_Heal		    = 1 * sec	-- เวลาในการเพิ่มเลือดแต่ละครั้ง
Config.Hp_Heal		    	= 2			-- เลือดขึ้นทีละเท่าไร
Config.Ambulance		    = 1			-- หมอต้องมีกี่คน ถึงจะเช็คนอนเตียงไม่ได้
Config.Text		    		= "หมอมีมากกว่า <span style='color:red'>".. Config.Ambulance .."</span> คนในเมือง "
Config.Text3D				= false		-- true เปิดใช้ Text 3D / false เปิดใช้ Fewthz_TextUI

Config.Main = {
	{ x = 355.33, y = -1416.26, z = 32.50,  Text = "Press ~g~[E] ~w~to Checkin" , TextUI = "Press ~INPUT_CONTEXT~ ~w~to Checkin" },
	{ x = 1836.22, y = 3681.82, z = 34.25,  Text = "Press ~g~[E] ~w~to Checkin" , TextUI = "Press ~INPUT_CONTEXT~ ~w~to Checkin" }
}

Config.NoallowJob = { --[หน่วยงานที่นอนแล้ว ไม่ให้เปลี่ยนชุด]
    'police',
    'ambulance',
}

Config.Marker = {
    Marker = {
        Id = 21,
        Size = {
            x = 0.5,
            y = 0.5,
            z = 0.5
        },
        DrawSize = 200,
        Color = {
            r = 0, g = 255, b = 0, a = 255
        }
    }
}

Config.Uniforms = {
	Player = {
		male = {
			tshirt_1=15, 	tshirt_2 = 0,
			torso_1=144, 	torso_2 = 0,
			arms=6, 
			pants_1 = 65, 	pants_2=0,
			shoes_1 = 34,	shoes_2 = 0,
		},
		female = {
			tshirt_1=15, 	tshirt_2 = 0,
			torso_1=142, 	torso_2 = 2,
			arms=1, 
			pants_1 = 67, 	pants_2=2,
			shoes_1 = 35,	shoes_2 = 0,
		}
	}
}

Config.BedList = {
	{
		name = 'v_med_bed1'
	},
	{
		name = 'v_med_bed2'
	},
	{
		name = 'v_med_emptybed'
	},

}