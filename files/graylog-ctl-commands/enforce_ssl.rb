add_command 'enforce-ssl', 'Limit web interface to SSL access', 2 do |cmd_name|
  require 'fileutils'
  require 'json'

  existing_settings = Hash.new
  if File.exists?("/etc/graylog/graylog-settings.json")
    existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
  else
    FileUtils.mkdir_p("/etc/graylog")
  end

  existing_settings['enforce_ssl'] = true
  File.open("/etc/graylog/graylog-settings.json","w") do |settings|
    settings.write(JSON.pretty_generate(existing_settings))
  end
end
