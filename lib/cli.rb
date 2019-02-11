require 'commander/import'

program :name, 'gsc-cli'
program :version, '0.0.1'
program :description, 'A cli to manage gsc servers'

command :deploy do |c|
  c.syntax = 'gsc-cli deploy [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # TODO: Replace hardcoded stuff with params from cli
    tmp_dir = '/tmp/gsd'
    clone_repo(tmp_dir)
    token_replace_daemon(tmp_dir)
    token_replace_run_script(tmp_dir)
    # TODO: Move unit file to /etc/systemd/system (root required😬😬)
  end
end

def clone_repo(tmp_dir)
  # TODO: Add logic around existing folder discovery
  `rm -rf /tmp/gsd`
  `git clone https://github.com/Egeeio/gsd.git #{tmp_dir}`
end

def token_replace_run_script(tmp_dir)
  # TODO: Consildate to a single token replace method
  run_script = "#{tmp_dir}/7days/run.sh"
  text = File.read(run_script)
  new_contents = text.gsub(/_POSTBUILDIR_/, "#{tmp_dir}/7days/post_build")
  really_new_contents = new_contents.gsub(/_WORKDIR_/, tmp_dir)
  File.open(run_script, 'w') { |file| file.puts really_new_contents }
end

def token_replace_daemon(tmp_dir)
  unit_file = "#{tmp_dir}/7days/sevendays.service"
  text = File.read(unit_file)
  new_contents = text.gsub(/_USER_/, 'egee')
  really_new_contents = new_contents.gsub(/_EXECSTART_/, "#{tmp_dir}/7days/run.sh")
  File.open(unit_file, 'w') { |file| file.puts really_new_contents }
end
