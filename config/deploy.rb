set :application, "Edm Press Time"
set :repository,  "git://github.com/bradendouglass/press_time.git"
set :branch, "origin/master"
set :migrate_target, :current
set :ssh_options, {:forward_agent => true}
set :rails_env, "production"
set :deploy_to, "/git/apps/edmpress_time"
set :normalize_asset_timestamps, false

set :user, "deployinator"
set :group, "dev"
set :use_sudo, false

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.0.37"                          # Your HTTP server, Apache/etc
role :app, "192.168.0.37"                          # This may be the same as your `Web` server
role :db,  "192.168.0.37", :primary => true # This is where Rails migrations will run

set(:latest_release) { fetch(:current_path) }
set(:release_path) { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision) { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_release) { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

default_environment["RAILS_ENV"] = 'production'

default_environment["PATH"] = "--"
default_environment["GEM_HOME"] = "--"
default_environment["GEM_PATH"] = "--"
default_environment["RUBY_VERSION"] = "ruby-1.9.3-p194"


namespace :deploy do
  desc "Deploy your App"
  task :default do
    update
    restart
  end

  desc "Setup your git-based deployment"
  task :setup, :except => {:no_release => true} do
    dirs = [deploy_to, shared_path]
    dirs += shared_children.map {|d| File.join(shared_path, d)}
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
    run "git clone #{repository} #{current_path}"
  end

  task :cold do
    update
    migrate
  end

  task :update do
    transaction do
      update_code
    end
  end

  desc "Update the deployed code"
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
    finalize_update
  end

  desc "Update the database (overwritten to avoid symlink)"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end

  task :finalize_update, except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    run <<-CMD
    rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids &&
    mkdir -p #{latest_release}/public &&
    mkdir -p #{latest_release}/tmp &&
    ln -s #{shared_path}/log #{latest_release}/log &&
    ln -s #{shared_path}/system #{latest_release}/public/system &&
    ln -s #{shared_path}/pids #{latest_release}/tmp/pids &&
    ln -sf #{shared_path}/database.yml #{latest_release}/config/database.yml
    CMD

    if fetch(:normalize_asset_timestamps, true)
      stamp = Time.now.utc.strftime("%Y%m%d%H%M.%S")
      asset_path = fetch(:public_children, %w(images stylesheets javascript)).map { |p| "#{latest_release}/public/#{p}" }.join(" ")
      run "find #{asset_path} -exec touch -t #{stamp} {} ';'; true", :env => {"TZ" => "UTC"}
    end
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 'cat /tmp/unicorn.my_site.pid'"
  end

  desc "Start the Unicorns"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop the Unicorns"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT 'cat /tmp/unicorn.edmpress_time.pid'"
  end

  namespace :rollback do
    desc "Moves the repo back to the previos version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next release"
    task :cleanup, :except => { :no_release => true } do
      run "cd #{current_path}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end

    desc "Rolls back to the previously deployed version"
    task :default do
      rollback.repo
      rollback.cleanup
    end
  end
end

def run_rake(cmd)
  run "cd #{current_path}; #{rake} #{cmd}"
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

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
