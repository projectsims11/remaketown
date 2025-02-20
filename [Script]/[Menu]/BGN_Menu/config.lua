Config = {}

Config.OpenKey = 'F5' -- ===> ปุ่มกดเปิดเมนู
Config.Command = 'Menu' -- ===> คำสั่งเปิดเมนู

Config.Menu = { -- ===> คั้งค่า และ เพิ่มเมนู
    [1] = { -- ===> ใส่เลขไล่ลงไปให้ถูกต้องตามจำนวน
        emoji = 'airdrop', -- ===> สัญลักษณ์ เลือกเอาจากในเว็บ https://fontawesome.com/search
        topic = 'Airdrop', -- ===> หัวข้อภาษาอังกฤษ
        detail = 'แอร์ดอร์ป', -- ===> หัวข้อภาษาไทย
        event = '', -- ===> สำหรับการใช้ TriggerEvent นั้นๆที่จะให้มันทำ
        command = 'airdrop' -- ===> สำหรับคำสั่ง Command นั้นๆที่จะให้มันทำ <i class="fa-solid fa-puzzle-piece"></i>
    },
    [2] = {
        emoji = 'fps',
        topic = 'Fps Menu',
        detail = 'เมนู Fps',
        event = '',
        command = 'menufps'
    },
    [3] = {
        emoji = 'eco', --<<i class="fa-solid fa-flag"></i>
        topic = 'เช็คราคา',
        detail = 'Economy',
        event = '',
        command = 'OpenCheckEco'
        --command = 'F10'
    },
    [4] = {
        emoji = 'name',
        topic = 'แจ้งปัญหา',
        detail = 'REPORT',
        event = '',
        command = 'report'
    },
    [5] = {
        emoji = 'prop',
        topic = 'delprop',
        detail = 'ลบพร๊อพบนตัว',
        event = '',
        command = 'clearprop'
    },
}
