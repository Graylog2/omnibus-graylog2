add_command 'list-servers', 'List all Graylog servers in your cluster', 2 do |cmd_name|
  require 'fileutils'
  require 'json'
  require 'socket'
  require 'timeout'

  existing_settings = Hash.new
  if File.exists?("/etc/graylog/graylog-settings.json")
    existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
  else
    exit 1;
  end

  master = existing_settings['master_node']

  begin
    Timeout::timeout(1) do
      begin
        socket = TCPSocket.new(master, 4001)
        socket.close
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        puts "Can not connect to etcd on given master node. Make sure master is set correctly."
        exit 1
      end
    end
  rescue Timeout::Error
    puts "Timeout to connect to given master server. Make sure master is reachable."
  end

  system "/opt/graylog/embedded/bin/etcdctl -C #{master}:4001 ls /servers"
end
