fx_version 'bodacious'
game 'gta5'

author 'Alzar'
description "Simple Notification Script using https://notifyjs.com/"

ui_page "html/index.html"

client_script "cl_notify.lua"

files {
    "html/index.html",
    "html/pNotify.js",
    "html/noty.js",
    "html/noty.css",
    "html/themes.css",
    "html/thx.wav",
	"html/wel.wav",
    "html/notif.wav"
}

export "SetQueueMax"
export "SendNotification"
