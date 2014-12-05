add_command 'set-admin-username', 'Set username for administrator', 2 do |cmd_name, username|
  require 'fileutils'
  require 'json'

  if username
    existing_secrets ||= Hash.new
    if File.exists?("/etc/graylog2/graylog2-secrets.json")
      existing_secrets = JSON.parse(File.read("/etc/graylog2/graylog2-secrets.json"))
    else
      FileUtils.mkdir_p("/etc/graylog2")
      existing_secrets['graylog2_server'] = Hash.new
    end

    existing_secrets['graylog2_server']['admin_username'] = username
    File.open("/etc/graylog2/graylog2-secrets.json","w") do |secrets|
      secrets.write(JSON.pretty_generate(existing_secrets))
    end
  else
    puts "Usage: #{cmd_name} <username>"
  end
end
