const SupportedGames = [
  {
    name: 'scp',
    type: 'steamcmd',
    appId: 996560
  },
  {
    name: 'tf2',
    type: 'steamcmd',
    appId: 232250,
    launchParams: './srcds_run -console -game tf +map ctf_turbine +maxplayers 24 +sv_pure 1 -condebug'
  }
]

module.exports = SupportedGames
