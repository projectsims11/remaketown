fx_version 'adamant'

game 'gta5'

description 'UI - Item Notifications By. Azael Dev'

version '1.1.3'

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/js/app.js',
    'html/js/noty.js',
    'html/css/noty.css',
    'html/css/style.css',

    -- No Image
    'html/no-image.png',

    -- Weapon
    'html/images/WEAPON_ADVANCEDRIFLE.png',
    'html/images/WEAPON_APPISTOL.png',
    'html/images/WEAPON_ASSAULTRIFLE.png',
    'html/images/WEAPON_ASSAULTRIFLE_MK2.png',
    'html/images/WEAPON_ASSAULTSHOTGUN.png',
    'html/images/WEAPON_ASSAULTSMG.png',
    'html/images/WEAPON_BALL.png',
    'html/images/WEAPON_BAT.png',
    'html/images/WEAPON_BOTTLE.png',
    'html/images/WEAPON_BULLPUPRIFLE.png',
    'html/images/WEAPON_BULLPUPRIFLE_MK2.png',
    'html/images/WEAPON_BULLPUPSHOTGUN.png',
    'html/images/WEAPON_BZGAS.png',
    'html/images/WEAPON_CARBINERIFLE.png',
    'html/images/WEAPON_COMBATMG.png',
    'html/images/WEAPON_COMBATMG_MK2.png',
    'html/images/WEAPON_COMBATPDW.png',
    'html/images/WEAPON_COMBATPISTOL.png',
    'html/images/WEAPON_COMPACTLAUNCHER.png',
    'html/images/WEAPON_COMPACTRIFLE.png',
    'html/images/WEAPON_CROWBAR.png',
    'html/images/WEAPON_DAGGER.png',
    'html/images/WEAPON_DBSHOTGUN.png',
    'html/images/WEAPON_DOUBLEACTION.png',
    'html/images/WEAPON_FIREEXTINGUISHER.png',
    'html/images/WEAPON_FIREWORK.png',
    'html/images/WEAPON_FLARE.png',
    'html/images/WEAPON_FLAREGUN.png',
    'html/images/WEAPON_FLASHLIGHT.png',
    'html/images/WEAPON_GOLFCLUB.png',
    'html/images/WEAPON_GRENADE.png',
    'html/images/WEAPON_GRENADELAUNCHER.png',
    'html/images/WEAPON_GRENADELAUNCHER_SMOKE.png',
    'html/images/WEAPON_GUSENBERG.png',
    'html/images/WEAPON_HAMMER.png',
    'html/images/WEAPON_HATCHET.png',
    'html/images/WEAPON_HEAVYPISTOL.png',
    'html/images/WEAPON_HEAVYSHOTGUN.png',
    'html/images/WEAPON_HEAVYSNIPER.png',
    'html/images/WEAPON_HEAVYSNIPER_MK2.png',
    'html/images/WEAPON_HOMINGLAUNCHER.png',
    'html/images/WEAPON_KNIFE.png',
    'html/images/WEAPON_KNUCKLE.png',
    'html/images/WEAPON_MACHETE.png',
    'html/images/WEAPON_MACHINEPISTOL.png',
    'html/images/WEAPON_MARKSMANPISTOL.png',
    'html/images/WEAPON_MARKSMANRIFLE.png',
    'html/images/WEAPON_MARKSMANRIFLE_MK2.png',
    'html/images/WEAPON_MG.png',
    'html/images/WEAPON_MICROSMG.png',
    'html/images/WEAPON_MINIGUN.png',
    'html/images/WEAPON_MINISMG.png',
    'html/images/WEAPON_MOLOTOV.png',
    'html/images/WEAPON_MUSKET.png',
    'html/images/WEAPON_NIGHTSTICK.png',
    'html/images/WEAPON_PETROLCAN.png',
    'html/images/WEAPON_PIPEWRENCH.png',
    'html/images/WEAPON_PISTOL.png',
    'html/images/WEAPON_PISTOL_MK2.png',
    'html/images/WEAPON_PISTOL50.png',
    'html/images/WEAPON_POOLCUE.png',
    'html/images/WEAPON_PROXMINE.png',
    'html/images/WEAPON_PUMPSHOTGUN.png',
    'html/images/WEAPON_PUMPSHOTGUN_MK2.png',
    'html/images/WEAPON_RAILGUN.png',
    'html/images/WEAPON_REVOLVER.png',
    'html/images/WEAPON_REVOLVER_MK2.png',
    'html/images/WEAPON_RPG.png',
    'html/images/WEAPON_SAWNOFFSHOTGUN.png',
    'html/images/WEAPON_SMG.png',
    'html/images/WEAPON_SMG_MK2.png',
    'html/images/WEAPON_SMOKEGRENADE.png',
    'html/images/WEAPON_SNIPERRIFLE.png',
    'html/images/WEAPON_SNOWBALL.png',
    'html/images/WEAPON_SNSPISTOL.png',
    'html/images/WEAPON_SNSPISTOL_MK2.png',
    'html/images/WEAPON_SPECIALCARBINE.png',
    'html/images/WEAPON_SPECIALCARBINE_MK2.png',
    'html/images/WEAPON_STICKYBOMB.png',
    'html/images/WEAPON_STUNGUN.png',
    'html/images/WEAPON_SWEEPERSHOTGUN.png',
    'html/images/WEAPON_SWITCHBLADE.png',
    'html/images/WEAPON_VINTAGEPISTOL.png',
    'html/images/GADGET_PARACHUTE.png',
    'html/images/gun_barrel.png',
    'html/images/ammo_pistol.png',
    'html/images/ammo_pistol50.png',
    'html/images/broken_gun.png',
    'html/images/armor.png',
    'html/images/clip.png',

    -- Items
    'html/images/bread.png',
    'html/images/water.png',
    'html/images/cash.png', -- Old es_extended
    'html/images/money.png', -- New es_extended
    'html/images/bank.png',
    'html/images/black_money.png',
    'html/images/oxygen_mask.png',
    'html/images/bandage.png',
    'html/images/medikit.png',
    'html/images/blowpipe.png',
    'html/images/carokit.png', -- No image
    'html/images/fixkit.png',
    'html/images/fixtool.png', -- No image
    'html/images/gazbottle.png', -- No image
    'html/images/gazbottle.png'
}

server_script {
	'config.lua',
    'server/main.lua'
}

client_script {
    'config.lua',
    'client/main.lua'
}

dependencies {
    'es_extended'
}
