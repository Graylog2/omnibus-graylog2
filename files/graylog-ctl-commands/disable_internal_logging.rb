add_command 'disable-internal-logging', 'Disable sending logs to Graylog', 2 do |cmd_name|
  require 'fileutils'
  require 'json'

  existing_settings = Hash.new
  if File.exists?("/etc/graylog/graylog-settings.json")
    existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
  else
    FileUtils.mkdir_p("/etc/graylog")
  end

  existing_settings['internal_logging'] = false
  File.open("/etc/graylog/graylog-settings.json","w") do |settings|
    settings.write(JSON.pretty_generate(existing_settings))
  end
  puts "This needs a full restart of the appliance to activate!"
end
