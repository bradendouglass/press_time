require "bundler/capistrano"

# Define your server here
server "192.168.0.37", :web, :app, :db, primary: true

# # Set application settings
set :application, "press_time"
set :user, "deployinator" # As defined on your server
set :group, "dev"
set :deploy_to, "/home/#{user}/apps/#{application}" # Directory in which the deployment will take place
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:bradendouglass/#{application}.git"
set :branch, "master"

# Correct location for rbenv use
set :default_environment, {
  "PATH" => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH"
}

default_run_options[:pty] = true # Set for the password prompt for git
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      sudo "chmod a+x /etc/init.d/unicorn_#{application}"
      run "/etc/init.d/unicorn_#{application} #{command}" # Using unicorn as the app server
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_ini.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
