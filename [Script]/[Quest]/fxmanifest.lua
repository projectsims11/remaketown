fx_version 'cerulean'
game 'gta5'
description 'Quest'
version '1.0.0'
client_script {'core/cl_quest.lua', 'core/func_function.lua', 'core/func_thread.lua'}
server_script {'core/sv_quest.lua'}
shared_script {'config.lua', 'core/func_quest.lua'}
ui_page {'html/index.html'}
files {
    'html/*',
    'html/js/*.js',
    'html/css/*.css',
}
dependency 'oxmysql'