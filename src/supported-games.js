const SupportedGames = [
  {
    name: 'scp',
    installer: 'steamcmd',
    backend: 'scp',
    appId: 996560,
    launchParams: 'mono ./MultiAdmin.exe'
  },
  {
    name: 'tf2',
    installer: 'steamcmd',
    backend: 'srcds',
    appId: 232250,
    launchParams: './srcds_run -console -game tf +map ctf_turbine +maxplayers 24 +sv_pure 1 -condebug &'
  },
  {
    name: 'gmod',
    installer: 'steamcmd',
    backend: 'srcds',
    appId: 4020,
    launchParams: './srcds_run -console -game garrysmod +map gm_construct +maxplayers 16 -condebug &'
  },
  {
    name: 'rust',
    installer: 'steamcmd',
    backend: 'unity',
    appId: 258550,
    launchParams: './RustDedicated +server.ip 0.0.0.0 +server.port 28015 +server.identity rust +rcon.web 1 +rcon.ip 0.0.0.0 +rcon.port 28016 +rcon.password _'
  },
  {
    name: 'sdtd',
    installer: 'steamcmd',
    backend: 'unity',
    appId: 294420,
    launchParams: './7DaysToDieServer.x86_64 -quit -batchmode -nographics -dedicated \\'
  },
  {
    name: 'minecraft',
    installer: 'minecraft',
    version: '1.15.2',
    launchParams: 'java -Xms1G -Xmx2G -server \\'
  },
  {
    name: 'terraria',
    installer: 'tshock',
    version: '4.3.26',
    launchParams: 'mono ./TerrariaServer.exe -config launch.cfg'
  }
]

module.exports = SupportedGames
