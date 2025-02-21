fx_version 'bodacious' 
game 'gta5' 

description "jomjam.Allserver"

client_scripts { 
	"client/*.lua",
} 
 
server_scripts { 
	'@mysql-async/lib/MySQL.lua',
	"server/*.lua",
}

