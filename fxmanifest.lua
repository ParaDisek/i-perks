
fx_version 'cerulean'
game 'gta5'

client_scripts {
    'config.lua',
    'client/cl.lua',

}

server_scripts {
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/sv.lua',
}