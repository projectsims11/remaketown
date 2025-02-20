shared_script "@bt_defender/module/shared53.lua"

fx_version("cerulean");
games({
	"gta5"
});
author("Donka");
version("1.0");
description("Normally Script");
shared_script("shared/*.lua");
client_scripts({
	"common/*.lua",
	"client/*.lua"
});
server_scripts({
	"@oxmysql/lib/MySQL.lua",
	"common/*.lua",
	"server/*.lua"
});
ui_page("html/ui.html");
files({
	"html/*",
	"html/**/*"
});
