require 'commander/import'

def deploy(game)
  work_dir = '/tmp/gsd'
  clone_repo(work_dir)
  token_replace_daemon(work_dir, game)
  token_replace_script(work_dir, game, 'run')
  token_replace_script(work_dir, game, 'update')
  system("sudo -p 'sudo password: ' cp -f #{work_dir}/gsd.service /etc/systemd/system/#{game}.service")
end

def clone_repo(work_dir)
  # TODO: Add logic around existing folder discovery
  `rm -rf /tmp/gsd`
  `git clone https://github.com/Egeeio/gsd.git #{work_dir}`
end

def token_replace_daemon(work_dir, game)
  unit_file = "#{work_dir}/gsd.service"
  text = File.read(unit_file)
  new_contents = text.gsub(/_USER_/, 'egee')
                     .gsub(/_EXECSTART_/, "#{work_dir}/#{game}/run.sh")
  File.open(unit_file, 'w') { |file| file.puts new_contents }
end

def token_replace_script(work_dir, game, script)
  script = "#{work_dir}/#{game}/#{script}.sh"
  contents = File.read(script)
  new_contents = contents.gsub(/_WORKDIR_/, work_dir)
  newer_contents = new_contents.gsub(/_POSTBUILDIR_/, "#{work_dir}/post_build")
  File.open(script, 'w') { |file| file.puts newer_contents }
end

program :name, 'gsc-cli'
program :version, '0.0.1'
program :description, 'A cli to manage gsc servers'

command :deploy do |c|
  c.syntax = 'gsc-cli deploy [options]'
  c.summary = 'Deploy a game server as a systemd unit'
  c.description = 'Deploy Description'
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    deploy(args.first)
  end
end
