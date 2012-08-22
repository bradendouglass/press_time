#Environment is passed or defaults to development
env = ENV["RAILS_ENV"] || "development"

# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.
worker_processes 4

listen "/tmp/edmpress_time.socket", :backlog => 64

#Preloading makes joo fast
preload_app true

#Nuke lazy workers faster
timeout 30

pid "/tmp/unicorn.edmpress_time.pid"

if env == "production"
  #We use current dir because cap symlinks us one. Kinda handy
  working_directory = "/home/deployinator/apps/edmpress_time/current"

  user 'deployinator', 'staff'
  shared_path = "/home/deployinator/apps/edmpress_time/shared"

  stderr_path "#{shared_path}/log/unicorn.stderr.log"
  stdout_path "#{shared_path}/log/unicorn.stdout.log"
end

before_fork do |server,worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  #This is the magic of all that negative downtime. Kill master process
  #that belongs to oldbin PID
  old_pid = "/tmp/unicorn.edmpress_time.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server,worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
