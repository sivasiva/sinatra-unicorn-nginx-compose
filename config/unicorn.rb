# Set the working application directory
working_directory "/app"

pid_file = "/tmp/unicorn.pid"
socket_file= "/tmp/unicorn.sock"
log_file = "/tmp/unicorn.log"
err_log = "/tmp/unicorn_error.log"
old_pid = pid_file + '.oldbin'


timeout 30
worker_processes 2
listen socket_file, :backlog => 1024

pid pid_file
stderr_path err_log
stdout_path log_file

before_fork do |server, worker|
  # zero downtime deploy magic:
  # if unicorn is already running, ask it to start a new process and quit.
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # already done
    end
  end
end

