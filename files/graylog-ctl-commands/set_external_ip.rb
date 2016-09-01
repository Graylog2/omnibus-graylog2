add_command 'set-external-ip', 'Configure IP under which the Graylog API is reachable from your browsers point of view', 2 do |cmd_name, address|
  require 'fileutils'
  require 'json'
  require 'uri'

  if address
    existing_settings = Hash.new
    if File.exists?("/etc/graylog/graylog-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
    end

    existing_settings['external_rest_uri'] = URI(address).to_s || false
    File.open("/etc/graylog/graylog-settings.json","w") do |settings|
      settings.write(JSON.pretty_generate(existing_settings))
    end
  else
    puts "Usage: #{cmd_name} http://<public address>:9000/api"
  end
end
