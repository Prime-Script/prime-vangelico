fx_version 'cerulean'
game 'gta5'

author "Prime Scripts | SocialPeely#4095"
description 'Vangelico Heist for QBCore'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change to the available languages | en.lua | fr.lua | tr.lua
    'config.lua'
}

client_scripts {
	'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

escrow_ignore {
    'config.lua',
    'locales/*.lua'
}