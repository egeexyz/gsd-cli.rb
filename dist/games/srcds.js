// Generated by CoffeeScript 2.4.1
(function() {
  var GenericServer, SrcdsServer, execSync;

  GenericServer = require("./generic");

  ({execSync} = require("child_process"));

  SrcdsServer = class SrcdsServer extends GenericServer {
    static install(flags) {
      var install_cmd, steamLogin;
      super.install(flags);
      steamLogin = `+login ${flags.config.steamUserName} ${flags.config.steamPassword}`;
      install_cmd = `steamcmd ${steamLogin} +force_install_dir ${flags.path} +app_update ${flags.config.appId} validate +quit`;
      if (flags.dryrun !== true) {
        execSync(install_cmd);
      }
      this.createUnitFile(flags);
      this.createLaunchScript(flags);
      return this.createLogFile(flags);
    }

    static createUnitFile(flags) {
      return super.createUnitFile(flags);
    }

    static createLaunchScript(flags) {
      var launchFileContents;
      launchFileContents = `./srcds_run -console -game ${flags.config.meta.game} +map ${flags.config.defaultMap} +maxplayers ${flags.config.players} ${flags.config.srcdsParams} -condebug & /usr/bin/tail -f ${flags.path}/${flags.config.meta.game}/console.log`;
      return super.createLaunchScript(flags, launchFileContents);
    }

    static createLogFile(flags) {
      execSync(`mkdir -p ${flags.path}/${flags.config.meta.game}`);
      return execSync(`touch ${flags.path}/${flags.config.meta.game}/console.log`);
    }

    static backupFile(file) {
      execSync(`touch ${file}`);
      execSync(`rm -f ${file}.backup`);
      return execSync(`mv ${file} ${file}.backup`);
    }

  };

  module.exports = SrcdsServer;

}).call(this);

//# sourceMappingURL=srcds.js.map
