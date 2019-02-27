require './lib/servers/TeamFortress2.rb'
require './lib/daemonize'

# Just a class that deploys stuff
class Deploy
  def initialize(game,
                 user = 'ubuntu',
                 desc = 'Description')
    @game = game
    @user = user
    @desc = desc
  end

  def team_fortress_2
    tf2 = TeamFortress2.new
    daemonize = Daemonize.new(@desc,
                              @game,
                              @user,
                              tf2.exec_start)
    daemonize.it
  end

  def it
    tf2 = TeamFortress2.new()
    Daemonize.new()
    
  #   clone_repo
  #   read_files
  #   replace_tokens(game, user)
  #   write_files
  #   system("sudo -p 'sudo password: ' cp -f #{@work_dir}/gsd.service /etc/systemd/system/#{game}.service")
  end

  def clone_repo
    # TODO: Add logic around existing folder discovery
    `rm -rf /tmp/gsd`
    `git clone https://github.com/Egeeio/gsd.git #{@work_dir}`
  end

  def read_files
    @files.each do |key, value|
      @contents[key] = File.read(value)
    end
  end

  def replace_tokens(game, user)
    @contents[:unit_file] = @contents[:unit_file].gsub(/_USER_/, user)
                                                 .gsub(/_DESC_/, 'Just a thing')
                                                 .gsub(/_EXECSTART_/, "#{@work_dir}/#{game}/run.sh")

    @contents[:run_script] = @contents[:run_script].gsub(/_WORKDIR_/, @work_dir)
                                                   .gsub(/_POSTBUILDIR_/, "#{@work_dir}/#{game}/post_build")

    @contents[:update_script] = @contents[:update_script].gsub(/_WORKDIR_/, @work_dir)
  end

  def write_files
    @contents.each do |key, value|
      File.open(@files[key], 'w') { |file| file.puts value }
    end
  end
end
