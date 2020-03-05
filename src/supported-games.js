const SupportedGames = [
  {
    name: 'scp',
    type: 'steamcmd',
    appId: 996560,
    launchParams: 'mono ./MultiAdmin.exe'
  },
  {
    name: 'tf2',
    type: 'steamcmd',
    appId: 232250,
    launchParams: './srcds_run -console -game tf +map ctf_turbine +maxplayers 24 +sv_pure 1 -condebug'
  },
  {
    name: 'gmod',
    type: 'steamcmd',
    appId: 4020,
    launchParams: './srcds_run -console -game garrysmod +map gm_construct +maxplayers 16 -condebug'
  },
  {
    name: 'rust',
    type: 'steamcmd',
    appId: 258550,
    launchParams: './RustDedicated +server.ip 0.0.0.0 +server.port 28015 +server.identity rust +rcon.web 1 +rcon.ip 0.0.0.0 +rcon.port 28016 +rcon.password _'
  },
  {
    name: 'sdtd',
    type: 'steamcmd',
    appId: 294420,
    launchParams: './7DaysToDieServer.x86_64 -quit -batchmode -nographics -dedicated'
  }
]

module.exports = SupportedGames
