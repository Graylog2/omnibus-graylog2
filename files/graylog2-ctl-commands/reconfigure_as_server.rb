add_command 'reconfigure-as-server', 'Run Graylog2 server on this node only', 1 do |cmd_name|
  require 'fileutils'
  require 'json'

  if true
    existing_services ||= Hash.new
    if File.exists?("/etc/graylog2/graylog2-services.json")
      existing_services = JSON.parse(File.read("/etc/graylog2/graylog2-services.json"))
    else
      FileUtils.mkdir("/etc/graylog2")
      existing_services['mongodb']         = Hash.new
      existing_services['elasticsearch']   = Hash.new
      existing_services['graylog2_server'] = Hash.new
      existing_services['graylog2_web']    = Hash.new
    end

    existing_services['mongodb']['enabled']         = false
    existing_services['elasticsearch']['enabled']   = false
    existing_services['graylog2_server']['enabled'] = true
    existing_services['graylog2_web']['enabled']    = false

    File.open("/etc/graylog2/graylog2-services.json","w") do |services|
      services.write(JSON.pretty_generate(existing_services))
    end

    reconfigure
  else
    puts "Usage: #{cmd_name}"
  end
end
