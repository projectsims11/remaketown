@echo off
mkdir JINGJOKxFIVEM
cd JINGJOKxFIVEM
mkdir code
cd code
echo. > client.lua
echo. > server.lua
cd ..

echo fx_version 'cerulean' > fxmanifest.lua
echo game 'gta5' >> fxmanifest.lua
echo. >> fxmanifest.lua
echo author 'JINGJOK' >> fxmanifest.lua
echo description '_______' >> fxmanifest.lua
echo version '1.0' >> fxmanifest.lua
echo. >> fxmanifest.lua
echo shared_script "config.lua" >> fxmanifest.lua
echo. >> fxmanifest.lua
echo client_scripts { >> fxmanifest.lua
echo     "code/client.lua" >> fxmanifest.lua
echo } >> fxmanifest.lua
echo. >> fxmanifest.lua
echo server_scripts { >> fxmanifest.lua
echo     "code/server.lua" >> fxmanifest.lua
echo } >> fxmanifest.lua
echo. > config.lua

echo.
echo ok..ok...ok...ok
pause
