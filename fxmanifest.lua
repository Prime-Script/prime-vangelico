fx_version 'cerulean'
game 'gta5'

author "NOCITY SCRIPTS | SocialPeely#4095"
description 'Jewellery Robberry for QBCore'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change Depending On The Language
    'config.lua'
}

client_scripts {
	'client/main.lua',
}

server_scripts {
    'server/main.lua',
}