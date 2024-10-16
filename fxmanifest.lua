fx_version("cerulean")
game("gta5")
version("V1")
author("BMW Development")
description("Autoscooter Mr. BMW")
lua54("yes")
shared_script("@ox_lib/init.lua")
client_scripts({
    "config.lua",
    "locales/locales.lua",
    "client.lua",
})

server_scripts({
    "config.lua",
    "locales/locales.lua",
    "server.lua"
})
