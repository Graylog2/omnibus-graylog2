add_command 'set-timezone', 'Set timezone your server is in', 2 do |cmd_name, timezone|
  require 'fileutils'
  require 'json'

  if timezone
    existing_settings = Hash.new
    if File.exists?("/etc/graylog/graylog-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
    end

    existing_settings['timezone'] = timezone
    File.open("/etc/graylog/graylog-settings.json","w") do |settings|
      settings.write(JSON.pretty_generate(existing_settings))
    end
  else
    puts "Usage: #{cmd_name} <timezone>"
  end
end
