add_command 'set-cluster-master', 'Set IP address of your cluster master server', 2 do |cmd_name, master|
  require 'fileutils'
  require 'json'
  require 'socket'
  require 'timeout'

  if master
    existing_settings = Hash.new
    if File.exists?("/etc/graylog/graylog-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
    end

    begin
      Timeout::timeout(1) do
        begin
          socket = TCPSocket.new(master, 4001)
          socket.close
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          puts "Can not connect to etcd on given master node. Make sure you configure the master before"
          exit 1
        end
      end
    rescue Timeout::Error
      puts "Timeout to connect to given master server. Make sure both servers are in the same network"
    end

    existing_settings['master_node'] = master
    File.open("/etc/graylog/graylog-settings.json","w") do |settings|
      settings.write(JSON.pretty_generate(existing_settings))
    end
  else
    puts "Usage: #{cmd_name} <IP master server>"
  end
end
