fx_version "adamant"
lua54 'yes'
game "gta5"
description 'Optimized And Simple Car Lock Script'
author 'Mental Illness#0515'



client_script {
	'client/client.lua'
}   

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua'
}

shared_scripts {
	'@es_extended/imports.lua',
}