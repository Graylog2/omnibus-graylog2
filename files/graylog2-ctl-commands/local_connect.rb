add_command 'local-connect', 'Connect services through localhost', 2 do |cmd_name|
  require 'fileutils'
  require 'json'

  existing_settings = Hash.new
  if File.exists?("/etc/graylog2/graylog2-settings.json")
    existing_settings = JSON.parse(File.read("/etc/graylog2/graylog2-settings.json"))
  else
    FileUtils.mkdir_p("/etc/graylog2")
  end

  existing_settings['local_connect'] = true
  File.open("/etc/graylog2/graylog2-settings.json","w") do |settings|
    settings.write(JSON.pretty_generate(existing_settings))
  end
end
