-- NC PROTECT+
server_scripts { '@nc_PROTECT+/exports/sv.lua' }
client_scripts { '@nc_PROTECT+/exports/cl.lua' }

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page "html/ui.html"

client_scripts {
	"client/client.lua",
	"config/config.lua"
}

server_scripts {
	"config/config.lua",
	"server/server.lua",
}

files {
	-- "html/ui.html",
	-- "html/style.css",
	-- "html/toastr.js", 
	-- "html/script.js",
	-- "html/no-image.png"
	"html/*.html",
	"html/*.css",
	"html/*.js",
	"html/*.png"
}