fx_version 'cerulean'
game 'gta5'

author "Prime Scripts | SocialPeely#4095"
description 'Vangelico Heist for QBCore'
version '1.5.0'

lua54 'yes'

shared_scripts {
    -- If your not using the latest version of QBCore, make sure you comment these two lines out | '@qb-core/shared/locale.lua', | 'locales/en.lua',
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