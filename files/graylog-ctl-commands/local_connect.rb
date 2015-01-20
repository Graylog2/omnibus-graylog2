add_command 'local-connect', 'Connect services through localhost', 2 do |cmd_name|
  require 'fileutils'
  require 'json'

  existing_settings = Hash.new
  if File.exists?("/etc/graylog/graylog-settings.json")
    existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
  else
    FileUtils.mkdir_p("/etc/graylog")
  end

  existing_settings['local_connect'] = true
  File.open("/etc/graylog/graylog-settings.json","w") do |settings|
    settings.write(JSON.pretty_generate(existing_settings))
  end
end
