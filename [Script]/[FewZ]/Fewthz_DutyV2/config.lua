-------------------------------
---FEWTHZ SHOP---
-------------------------------
--ห้ามแจก หรือจำหน่าย หากนำไปจำหน่าย หรือแจก จะหยุด ซัพพอททันที

Config = {}

Config.DrawDistance = 10.0
Config.DistanceMethod = 'LuaMethod' -- Vdist / LuaMethod
Config.Locale = 'en'

--ระบบแจ้ง เตือนดิสคอด รวมเวลาว่าผู้เล่นเข้าเวรไปแล้วกี่นาที
Config.botname = "ระบบเข้า-ออกเวร"
Config.image = 'https://cdn.discordapp.com/attachments/1001578245935874210/1004066646396248134/logo3.png'
Config.webhook_police = '#'
Config.webhook_ems = '#'
Config.webhook_mc = '#'

Config.JustCanSeeOne = true 

Config.HelpText = 'Floating' 

--เมื่อผู้เล่นเข้าเวรแล้วออกเข้าใหม่จะ จะออกเวรให้เองอัตโนมัติ
Config.PlayerJoinOffDuty = false
--จุดเข้าเวร-ออกเวร ของแต่ละหน่วยงาน
Config.Zones = {
    police = {
        job = 'police',
        offjob = 'offpolice',
        Pos = { x = 447.239990234375, y = -976.8300170898438, z = 30.69000053405761 },
        Size = {x = 1.5, y = 1.5, z = 1.5}
    },


    ambulance = {
        job = 'ambulance',
        offjob = 'offambulance',
        Pos = { x = 358.2099914550781, y = -1417.219970703125, z = 32.5099983215332 },
        Size = {x = 1.5, y = 1.5, z = 1.5}
    },

    mechanic = {
        job = 'mechanic',
        offjob = 'offmechanic',
        Pos = { x = -726.219970703125, y = -1461.9300537109375, z = 5.05999994277954},
        Size = {x = 1.5, y = 1.5, z = 1.5}
    },

    council = {
      job = 'council',
      offjob = 'offcouncil',
      Pos = { x = 432.510009765625, y = 9.22999954223632, z = 91.94000244140624},
      Size = {x = 1.5, y = 1.5, z = 1.5}
  },

}
--กำหนดเสื้อผ้าของผู้เล่นที่เข้าเวรแล้ว ในแต่ละ job และ แต่ละ grade
Config.Uniforms_ambulance = { ---------- Ambulance
    Grade0 = {
      male = {
          ['tshirt_1'] = 9, ['tshirt_2'] = 1,
          --['ears_1'] = -1, ['ears_2'] = 0,
          ['torso_1'] = 7, ['torso_2'] = 0,
          --['decals_1'] = 0,  ['decals_2']= 0,
          ['mask_1'] = 0, ['mask_2'] = 0,
          ['arms'] = 88,
          ['pants_1'] = 7, ['pants_2'] = 0,
          --['shoes_1'] = 51, ['shoes_2'] = 1,
          --['helmet_1'] = -1, ['helmet_2'] = 0,
          --['bags_1'] = -1, ['bags_2'] = 0,
          --['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 126, ['chain_2'] = 0,
          --['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 5, ['tshirt_2'] = 1,
        --['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 7, ['torso_2'] = 0,
        --['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 101,
        ['pants_1'] = 7, ['pants_2'] = 0,
        --['shoes_1'] = 51, ['shoes_2'] = 1,
        --['helmet_1'] = -1, ['helmet_2'] = 0,
        --['bags_1'] = -1, ['bags_2'] = 0,
        --['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 96, ['chain_2'] = 0,
        --['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
    Grade1 = {
      male = {
        ['tshirt_1'] = 9, ['tshirt_2'] = 1,
        --['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 7, ['torso_2'] = 0,
        --['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 88,
        ['pants_1'] = 7, ['pants_2'] = 0,
        --['shoes_1'] = 51, ['shoes_2'] = 1,
        --['helmet_1'] = -1, ['helmet_2'] = 0,
        --['bags_1'] = -1, ['bags_2'] = 0,
        --['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 126, ['chain_2'] = 0,
        --['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 5, ['tshirt_2'] = 1,
        --['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 7, ['torso_2'] = 0,
        --['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 101,
        ['pants_1'] = 7, ['pants_2'] = 0,
        --['shoes_1'] = 51, ['shoes_2'] = 1,
        --['helmet_1'] = -1, ['helmet_2'] = 0,
        --['bags_1'] = -1, ['bags_2'] = 0,
        --['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 96, ['chain_2'] = 0,
        --['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
    Grade2 = {
      male = {
        ['tshirt_1'] = 9, ['tshirt_2'] = 1,
          --['ears_1'] = -1, ['ears_2'] = 0,
          ['torso_1'] = 7, ['torso_2'] = 0,
          --['decals_1'] = 0,  ['decals_2']= 0,
          ['mask_1'] = 0, ['mask_2'] = 0,
          ['arms'] = 88,
          ['pants_1'] = 7, ['pants_2'] = 0,
          --['shoes_1'] = 51, ['shoes_2'] = 1,
          --['helmet_1'] = -1, ['helmet_2'] = 0,
          --['bags_1'] = -1, ['bags_2'] = 0,
          --['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 126, ['chain_2'] = 0,
          --['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 5, ['tshirt_2'] = 1,
        --['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 7, ['torso_2'] = 0,
        --['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 101,
        ['pants_1'] = 7, ['pants_2'] = 0,
        --['shoes_1'] = 51, ['shoes_2'] = 1,
        --['helmet_1'] = -1, ['helmet_2'] = 0,
        --['bags_1'] = -1, ['bags_2'] = 0,
        --['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 96, ['chain_2'] = 0,
        --['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
    Grade3 = {
      male = {
        ['tshirt_1'] = 9, ['tshirt_2'] = 1,
          --['ears_1'] = -1, ['ears_2'] = 0,
          ['torso_1'] = 7, ['torso_2'] = 0,
          --['decals_1'] = 0,  ['decals_2']= 0,
          ['mask_1'] = 0, ['mask_2'] = 0,
          ['arms'] = 88,
          ['pants_1'] = 7, ['pants_2'] = 0,
          --['shoes_1'] = 51, ['shoes_2'] = 1,
          --['helmet_1'] = -1, ['helmet_2'] = 0,
          --['bags_1'] = -1, ['bags_2'] = 0,
          --['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 126, ['chain_2'] = 0,
          --['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 5, ['tshirt_2'] = 1,
        --['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 7, ['torso_2'] = 0,
        --['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 101,
        ['pants_1'] = 7, ['pants_2'] = 0,
        --['shoes_1'] = 51, ['shoes_2'] = 1,
        --['helmet_1'] = -1, ['helmet_2'] = 0,
        --['bags_1'] = -1, ['bags_2'] = 0,
        --['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 96, ['chain_2'] = 0,
        --['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
    Grade4 = {
      male = {
        ['tshirt_1'] = 9, ['tshirt_2'] = 1,
          --['ears_1'] = -1, ['ears_2'] = 0,
          ['torso_1'] = 7, ['torso_2'] = 0,
          --['decals_1'] = 0,  ['decals_2']= 0,
          ['mask_1'] = 0, ['mask_2'] = 0,
          ['arms'] = 88,
          ['pants_1'] = 7, ['pants_2'] = 0,
          --['shoes_1'] = 51, ['shoes_2'] = 1,
          --['helmet_1'] = -1, ['helmet_2'] = 0,
          --['bags_1'] = -1, ['bags_2'] = 0,
          --['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 126, ['chain_2'] = 0,
          --['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 5, ['tshirt_2'] = 1,
        --['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 7, ['torso_2'] = 0,
        --['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 101,
        ['pants_1'] = 7, ['pants_2'] = 0,
        --['shoes_1'] = 51, ['shoes_2'] = 1,
        --['helmet_1'] = -1, ['helmet_2'] = 0,
        --['bags_1'] = -1, ['bags_2'] = 0,
        --['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 96, ['chain_2'] = 0,
        --['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
	Grade5 = {
      male = {
        ['tshirt_1'] = 9, ['tshirt_2'] = 1,
          --['ears_1'] = -1, ['ears_2'] = 0,
          ['torso_1'] = 7, ['torso_2'] = 0,
          --['decals_1'] = 0,  ['decals_2']= 0,
          ['mask_1'] = 0, ['mask_2'] = 0,
          ['arms'] = 88,
          ['pants_1'] = 7, ['pants_2'] = 0,
          --['shoes_1'] = 51, ['shoes_2'] = 1,
          --['helmet_1'] = -1, ['helmet_2'] = 0,
          --['bags_1'] = -1, ['bags_2'] = 0,
          --['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 126, ['chain_2'] = 0,
          --['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 5, ['tshirt_2'] = 1,
        --['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 7, ['torso_2'] = 0,
        --['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 101,
        ['pants_1'] = 7, ['pants_2'] = 0,
        --['shoes_1'] = 51, ['shoes_2'] = 1,
        --['helmet_1'] = -1, ['helmet_2'] = 0,
        --['bags_1'] = -1, ['bags_2'] = 0,
        --['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 96, ['chain_2'] = 0,
        --['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
	Grade6 = {
      male = {
        ['tshirt_1'] = 9, ['tshirt_2'] = 1,
          --['ears_1'] = -1, ['ears_2'] = 0,
          ['torso_1'] = 7, ['torso_2'] = 0,
          --['decals_1'] = 0,  ['decals_2']= 0,
          ['mask_1'] = 0, ['mask_2'] = 0,
          ['arms'] = 88,
          ['pants_1'] = 7, ['pants_2'] = 0,
          --['shoes_1'] = 51, ['shoes_2'] = 1,
          --['helmet_1'] = -1, ['helmet_2'] = 0,
          --['bags_1'] = -1, ['bags_2'] = 0,
          --['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 126, ['chain_2'] = 0,
          --['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 5, ['tshirt_2'] = 1,
        --['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 7, ['torso_2'] = 0,
        --['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 101,
        ['pants_1'] = 7, ['pants_2'] = 0,
        --['shoes_1'] = 51, ['shoes_2'] = 1,
        --['helmet_1'] = -1, ['helmet_2'] = 0,
        --['bags_1'] = -1, ['bags_2'] = 0,
        --['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 96, ['chain_2'] = 0,
        --['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
	Grade7 = {
      male = {
          ['tshirt_1'] = 10, ['tshirt_2'] = 0,
          ['ears_1'] = -1, ['ears_2'] = 0,
          ['torso_1'] = 179, ['torso_2'] = 2,
          ['decals_1'] = 0,  ['decals_2']= 0,
          ['mask_1'] = 0, ['mask_2'] = 0,
          ['arms'] = 90,
          ['pants_1'] = 60, ['pants_2'] = 4,
          ['shoes_1'] = 51, ['shoes_2'] = 1,
          ['helmet_1'] = -1, ['helmet_2'] = 0,
          ['bags_1'] = -1, ['bags_2'] = 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 0, ['chain_2'] = 0,
          ['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
          ['tshirt_1'] = 42, ['tshirt_2'] = 0,
          ['ears_1'] = -1, ['ears_2'] = 0,
          ['torso_1'] = 190, ['torso_2'] 	= 2,
          ['decals_1'] = 0,  ['decals_2'] = 0,
          ['mask_1'] = 0, ['mask_2'] 	= 0,
          ['arms'] = 112, 
          ['pants_1'] = 114, ['pants_2'] 	= 0,
          ['shoes_1'] = 17, ['shoes_2'] 	= 2,
          ['helmet_1']= -1, ['helmet_2'] = 0,
          ['bags_1'] = -1, ['bags_2']	= 0,
          ['glasses_1'] = -1, ['glasses_2'] = 0,
          ['chain_1'] = 97, ['chain_2'] = 0,
          ['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    }
  }
  ----------------------------------------------------------------------------Police = ตำรวจ-------------------------------------------------------------------------------
  Config.Uniforms_police = {
    Grade0 = { -- currently the same as chef_wear
    male = {
      ['tshirt_1'] = 9, ['tshirt_2'] = 0,
     -- ['ears_1'] = -1, ['ears_2'] = 0,
      ['torso_1'] = 7, ['torso_2'] = 1,
      ['decals_1'] = 0,  ['decals_2']= 0,
      ['mask_1'] = 0, ['mask_2'] = 0,
      ['arms'] = 1,
      ['pants_1'] = 7, ['pants_2'] = 1,
      ['shoes_1'] = 36, ['shoes_2'] = 3,
     -- ['helmet_1'] = -1, ['helmet_2'] = 0,
     -- ['bags_1'] = -1, ['bags_2'] = 0,
     -- ['glasses_1'] = -1, ['glasses_2'] = 0,
     -- ['chain_1'] = 127, ['chain_2'] = 0,
     -- ['bproof_1'] = 0,  ['bproof_2'] = 0
  },
		female = {
			['tshirt_1'] = 5,  ['tshirt_2'] = 0,
			['torso_1'] = 7,   ['torso_2'] = 1,
			--['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 7,   ['pants_2'] = 1,
			--['shoes_1'] = 44,   ['shoes_2'] = 0,
			--['helmet_1'] = 50,  ['helmet_2'] = 0,
			--['chain_1'] = -1,    ['chain_2'] = 0,
			--['ears_1'] = -1,     ['ears_2'] = 0,
			--['bproof_1'] = 20,  ['bproof_2'] = 1
		}
	},
	Grade1 = {
    male = {
      ['tshirt_1'] = 9, ['tshirt_2'] = 0,
     -- ['ears_1'] = -1, ['ears_2'] = 0,
      ['torso_1'] = 7, ['torso_2'] = 1,
      ['decals_1'] = 0,  ['decals_2']= 0,
      ['mask_1'] = 0, ['mask_2'] = 0,
      ['arms'] = 1,
      ['pants_1'] = 7, ['pants_2'] = 1,
      ['shoes_1'] = 36, ['shoes_2'] = 3,
     -- ['helmet_1'] = -1, ['helmet_2'] = 0,
     -- ['bags_1'] = -1, ['bags_2'] = 0,
     -- ['glasses_1'] = -1, ['glasses_2'] = 0,
     -- ['chain_1'] = 127, ['chain_2'] = 0,
     -- ['bproof_1'] = 0,  ['bproof_2'] = 0
  },
		female = {
			['tshirt_1'] = 5,  ['tshirt_2'] = 0,
			['torso_1'] = 7,   ['torso_2'] = 1,
			--['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 7,   ['pants_2'] = 1,
			--['shoes_1'] = 44,   ['shoes_2'] = 0,
			--['helmet_1'] = 50,  ['helmet_2'] = 0,
			--['chain_1'] = -1,    ['chain_2'] = 0,
			--['ears_1'] = -1,     ['ears_2'] = 0,
			--['bproof_1'] = 20,  ['bproof_2'] = 1
		}
	},
	Grade2 = {
    male = {
      ['tshirt_1'] = 9, ['tshirt_2'] = 0,
     -- ['ears_1'] = -1, ['ears_2'] = 0,
      ['torso_1'] = 7, ['torso_2'] = 1,
      ['decals_1'] = 0,  ['decals_2']= 0,
      ['mask_1'] = 0, ['mask_2'] = 0,
      ['arms'] = 1,
      ['pants_1'] = 7, ['pants_2'] = 1,
      ['shoes_1'] = 36, ['shoes_2'] = 3,
     -- ['helmet_1'] = -1, ['helmet_2'] = 0,
     -- ['bags_1'] = -1, ['bags_2'] = 0,
     -- ['glasses_1'] = -1, ['glasses_2'] = 0,
     -- ['chain_1'] = 127, ['chain_2'] = 0,
     -- ['bproof_1'] = 0,  ['bproof_2'] = 0
  },
		female = {
			['tshirt_1'] = 5,  ['tshirt_2'] = 0,
			['torso_1'] = 7,   ['torso_2'] = 1,
			--['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 7,   ['pants_2'] = 1,
			--['shoes_1'] = 44,   ['shoes_2'] = 0,
			--['helmet_1'] = 50,  ['helmet_2'] = 0,
			--['chain_1'] = -1,    ['chain_2'] = 0,
			--['ears_1'] = -1,     ['ears_2'] = 0,
			--['bproof_1'] = 20,  ['bproof_2'] = 1
		}
	},
	Grade3 = {
    male = {
      ['tshirt_1'] = 9, ['tshirt_2'] = 0,
     -- ['ears_1'] = -1, ['ears_2'] = 0,
      ['torso_1'] = 7, ['torso_2'] = 1,
      ['decals_1'] = 0,  ['decals_2']= 0,
      ['mask_1'] = 0, ['mask_2'] = 0,
      ['arms'] = 1,
      ['pants_1'] = 7, ['pants_2'] = 1,
      ['shoes_1'] = 36, ['shoes_2'] = 3,
     -- ['helmet_1'] = -1, ['helmet_2'] = 0,
     -- ['bags_1'] = -1, ['bags_2'] = 0,
     -- ['glasses_1'] = -1, ['glasses_2'] = 0,
     -- ['chain_1'] = 127, ['chain_2'] = 0,
     -- ['bproof_1'] = 0,  ['bproof_2'] = 0
  },
		female = {
			['tshirt_1'] = 5,  ['tshirt_2'] = 0,
			['torso_1'] = 7,   ['torso_2'] = 1,
			--['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 7,   ['pants_2'] = 1,
			--['shoes_1'] = 44,   ['shoes_2'] = 0,
			--['helmet_1'] = 50,  ['helmet_2'] = 0,
			--['chain_1'] = -1,    ['chain_2'] = 0,
			--['ears_1'] = -1,     ['ears_2'] = 0,
			--['bproof_1'] = 20,  ['bproof_2'] = 1
		}
	},
	Grade4 = {
    male = {
      ['tshirt_1'] = 9, ['tshirt_2'] = 0,
     -- ['ears_1'] = -1, ['ears_2'] = 0,
      ['torso_1'] = 7, ['torso_2'] = 1,
      ['decals_1'] = 0,  ['decals_2']= 0,
      ['mask_1'] = 0, ['mask_2'] = 0,
      ['arms'] = 1,
      ['pants_1'] = 7, ['pants_2'] = 1,
      ['shoes_1'] = 36, ['shoes_2'] = 3,
     -- ['helmet_1'] = -1, ['helmet_2'] = 0,
     -- ['bags_1'] = -1, ['bags_2'] = 0,
     -- ['glasses_1'] = -1, ['glasses_2'] = 0,
     -- ['chain_1'] = 127, ['chain_2'] = 0,
     -- ['bproof_1'] = 0,  ['bproof_2'] = 0
  },
		female = {
			['tshirt_1'] = 5,  ['tshirt_2'] = 0,
			['torso_1'] = 7,   ['torso_2'] = 1,
			--['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 7,   ['pants_2'] = 1,
			--['shoes_1'] = 44,   ['shoes_2'] = 0,
			--['helmet_1'] = 50,  ['helmet_2'] = 0,
			--['chain_1'] = -1,    ['chain_2'] = 0,
			--['ears_1'] = -1,     ['ears_2'] = 0,
			--['bproof_1'] = 20,  ['bproof_2'] = 1
		}
	},
	
	Grade5 = {
    male = {
      ['tshirt_1'] = 9, ['tshirt_2'] = 0,
     -- ['ears_1'] = -1, ['ears_2'] = 0,
      ['torso_1'] = 7, ['torso_2'] = 1,
      ['decals_1'] = 0,  ['decals_2']= 0,
      ['mask_1'] = 0, ['mask_2'] = 0,
      ['arms'] = 1,
      ['pants_1'] = 7, ['pants_2'] = 1,
      ['shoes_1'] = 36, ['shoes_2'] = 3,
     -- ['helmet_1'] = -1, ['helmet_2'] = 0,
     -- ['bags_1'] = -1, ['bags_2'] = 0,
     -- ['glasses_1'] = -1, ['glasses_2'] = 0,
     -- ['chain_1'] = 127, ['chain_2'] = 0,
     -- ['bproof_1'] = 0,  ['bproof_2'] = 0
  },
		female = {
			['tshirt_1'] = 5,  ['tshirt_2'] = 0,
			['torso_1'] = 7,   ['torso_2'] = 1,
			--['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 7,   ['pants_2'] = 1,
			--['shoes_1'] = 44,   ['shoes_2'] = 0,
			--['helmet_1'] = 0,  ['helmet_2'] = 0,
			--['chain_1'] = -1,    ['chain_2'] = 0,
			--['ears_1'] = -1,     ['ears_2'] = 0,
			--['bproof_1'] = 20,  ['bproof_2'] = 1
		}
	},
	
	Grade6 = {
    male = {
      ['tshirt_1'] = 9, ['tshirt_2'] = 0,
     -- ['ears_1'] = -1, ['ears_2'] = 0,
      ['torso_1'] = 7, ['torso_2'] = 1,
      ['decals_1'] = 0,  ['decals_2']= 0,
      ['mask_1'] = 0, ['mask_2'] = 0,
      ['arms'] = 1,
      ['pants_1'] = 7, ['pants_2'] = 1,
      ['shoes_1'] = 36, ['shoes_2'] = 3,
     -- ['helmet_1'] = -1, ['helmet_2'] = 0,
     -- ['bags_1'] = -1, ['bags_2'] = 0,
     -- ['glasses_1'] = -1, ['glasses_2'] = 0,
     -- ['chain_1'] = 127, ['chain_2'] = 0,
     -- ['bproof_1'] = 0,  ['bproof_2'] = 0
  },
		female = {
			['tshirt_1'] = 5,  ['tshirt_2'] = 0,
			['torso_1'] = 7,   ['torso_2'] = 1,
			--['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 7,   ['pants_2'] = 1,
			--['shoes_1'] = 44,   ['shoes_2'] = 0,
			--['helmet_1'] = 0,  ['helmet_2'] = 0,
			--['chain_1'] = -1,    ['chain_2'] = 0,
			--['ears_1'] = -1,     ['ears_2'] = 0,
			--['bproof_1'] = 20,  ['bproof_2'] = 1
		}
	},
	
	Grade7 = {
    male = {
      ['tshirt_1'] = 9, ['tshirt_2'] = 0,
     -- ['ears_1'] = -1, ['ears_2'] = 0,
      ['torso_1'] = 7, ['torso_2'] = 1,
      ['decals_1'] = 0,  ['decals_2']= 0,
      ['mask_1'] = 0, ['mask_2'] = 0,
      ['arms'] = 1,
      ['pants_1'] = 7, ['pants_2'] = 1,
      ['shoes_1'] = 36, ['shoes_2'] = 3,
     -- ['helmet_1'] = -1, ['helmet_2'] = 0,
     -- ['bags_1'] = -1, ['bags_2'] = 0,
     -- ['glasses_1'] = -1, ['glasses_2'] = 0,
     -- ['chain_1'] = 127, ['chain_2'] = 0,
     -- ['bproof_1'] = 0,  ['bproof_2'] = 0
  },
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 207,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade8 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 60,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 9,
			['helmet_1'] = 49,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 208,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade9 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 60,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 9,
			['helmet_1'] = 49,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 208,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade10 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 60,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 9,
			['helmet_1'] = 49,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 208,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade11 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 60,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 9,
			['helmet_1'] = 49,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 144,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade12 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 60,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 9,
			['helmet_1'] = 49,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 144,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade13 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 60,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 9,
			['helmet_1'] = 49,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 144,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade14 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 60,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 9,
			['helmet_1'] = 49,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 144,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade15 = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 60,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 9,
			['helmet_1'] = 49,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 144,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade16 = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 60,   ['pants_2'] = 1,
			['shoes_1'] = 55,   ['shoes_2'] = 9,
			['helmet_1'] = 49,  ['helmet_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 144,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade17 = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 53,   ['pants_2'] = 1,
			['shoes_1'] = 50,   ['shoes_2'] = 9,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = -1,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 144,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
	Grade18 = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 145,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 53,   ['pants_2'] = 1,
			['shoes_1'] = 50,   ['shoes_2'] = 9,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bproof_1'] = -1,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 155,  ['tshirt_2'] = 0,
			['torso_1'] = 144,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 44,   ['shoes_2'] = 0,
			['helmet_1'] = 50,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},
}
  ------------------------------------------------------Mechanic = ช่าง --------------------------------------
  Config.Uniforms_mechanic = {
    Grade0 = {
      male = {
        ['tshirt_1'] = 145, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 49, ['torso_2'] = 0,
        ['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 29,
        ['pants_1'] = 16, ['pants_2'] = 5,
        ['shoes_1'] = 51, ['shoes_2'] = 1,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2'] = 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 187, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 62, ['torso_2'] 	= 0,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 0, ['mask_2'] 	= 0,
        ['arms'] = 3, 
        ['pants_1'] = 14, ['pants_2'] 	= 8,
        ['shoes_1'] = 33, ['shoes_2'] 	= 0,
        ['helmet_1']= -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2']	= 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
    Grade1 = {
      male = {
        ['tshirt_1'] = 145, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 49, ['torso_2'] = 0,
        ['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 29,
        ['pants_1'] = 16, ['pants_2'] = 5,
        ['shoes_1'] = 51, ['shoes_2'] = 1,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2'] = 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 187, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 62, ['torso_2'] 	= 0,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 0, ['mask_2'] 	= 0,
        ['arms'] = 3, 
        ['pants_1'] = 14, ['pants_2'] 	= 8,
        ['shoes_1'] = 33, ['shoes_2'] 	= 0,
        ['helmet_1']= -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2']	= 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
    Grade2 = {
      male = {
        ['tshirt_1'] = 145, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 49, ['torso_2'] = 0,
        ['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 29,
        ['pants_1'] = 16, ['pants_2'] = 5,
        ['shoes_1'] = 51, ['shoes_2'] = 1,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2'] = 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 187, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 62, ['torso_2'] 	= 0,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 0, ['mask_2'] 	= 0,
        ['arms'] = 3, 
        ['pants_1'] = 14, ['pants_2'] 	= 8,
        ['shoes_1'] = 33, ['shoes_2'] 	= 0,
        ['helmet_1']= -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2']	= 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
    Grade3 = {
      male = {
        ['tshirt_1'] = 145, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 49, ['torso_2'] = 0,
        ['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 29,
        ['pants_1'] = 16, ['pants_2'] = 5,
        ['shoes_1'] = 51, ['shoes_2'] = 1,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2'] = 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 187, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 62, ['torso_2'] 	= 0,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 0, ['mask_2'] 	= 0,
        ['arms'] = 3, 
        ['pants_1'] = 14, ['pants_2'] 	= 8,
        ['shoes_1'] = 33, ['shoes_2'] 	= 0,
        ['helmet_1']= -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2']	= 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
    Grade4 = {
      male = {
        ['tshirt_1'] = 145, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 49, ['torso_2'] = 0,
        ['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 29,
        ['pants_1'] = 16, ['pants_2'] = 5,
        ['shoes_1'] = 51, ['shoes_2'] = 1,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2'] = 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 187, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 62, ['torso_2'] 	= 0,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 0, ['mask_2'] 	= 0,
        ['arms'] = 3, 
        ['pants_1'] = 14, ['pants_2'] 	= 8,
        ['shoes_1'] = 33, ['shoes_2'] 	= 0,
        ['helmet_1']= -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2']	= 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
	 Grade5 = {
      male = {
        ['tshirt_1'] = 145, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 49, ['torso_2'] = 0,
        ['decals_1'] = 0,  ['decals_2']= 0,
        ['mask_1'] = 0, ['mask_2'] = 0,
        ['arms'] = 29,
        ['pants_1'] = 16, ['pants_2'] = 5,
        ['shoes_1'] = 51, ['shoes_2'] = 1,
        ['helmet_1'] = -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2'] = 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      },
      female = {
        ['tshirt_1'] = 187, ['tshirt_2'] = 0,
        ['ears_1'] = -1, ['ears_2'] = 0,
        ['torso_1'] = 62, ['torso_2'] 	= 0,
        ['decals_1'] = 0,  ['decals_2'] = 0,
        ['mask_1'] = 0, ['mask_2'] 	= 0,
        ['arms'] = 3, 
        ['pants_1'] = 14, ['pants_2'] 	= 8,
        ['shoes_1'] = 33, ['shoes_2'] 	= 0,
        ['helmet_1']= -1, ['helmet_2'] = 0,
        ['bags_1'] = -1, ['bags_2']	= 0,
        ['glasses_1'] = -1, ['glasses_2'] = 0,
        ['chain_1'] = 0, ['chain_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
      }
    },
  }
  ---------------------------------------------Taxi = แท็กซี่--------------------------
  Config.Uniforms_taxi = {
    
  }
