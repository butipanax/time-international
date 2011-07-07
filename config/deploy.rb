set :application, "time-international"
set :repository,  "git@github.com:butipanax/time-international.git"
set :webserver, "railshosting.de"
set :scm, :git

set :deploy_to, "/var/www/htdocs/webXX/files/rails/#{application}"
set :symlink_path, "/var/www/htdocs/webXX/html/rails/#{application}"

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "web37"
ssh_options[:port] = 981
set :use_sudo, false
set :deploy_via, :remote_cache


role :web, webserver                        # Your HTTP server, Apache/etc
role :app, webserver                          # This may be the same as your `Web` server
role :db,  webserver, :primary => true # This is where Rails migrations will run


# copy shared files after update
task :update_config, :roles => :app do
  run "cp -Rf #{shared_path}/config/* #{release_path}/config/"
end

#   # create symlink after setup
task :symlink_config, :roles => :app do
  run "mkdir -p /var/www/htdocs/#{user}/html/rails"
  run "ln -nfs #{current_path}/public #{symlink_path}"
end

after "deploy:setup", :symlink_config
after "deploy:update_code", :update_config
#
#       # mod_rails (phusion_passenger) stuff
namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end 
                  
  [:start, :stop].each do |t|
    desc "start/stop is not necessary with mod_rails"
    task t, :roles => :app do 
    # nothing
    end 
  end
end


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
