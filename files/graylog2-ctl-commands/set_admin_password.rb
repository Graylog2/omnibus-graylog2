add_command 'set-admin-password', 'Override admin password', 2 do |cmd_name, pwd|
  require 'fileutils'
  require 'json'
  require 'digest/sha2'

  if pwd
    existing_secrets ||= Hash.new
    if File.exists?("/etc/graylog2/graylog2-secrets.json")
      existing_secrets = JSON.parse(File.read("/etc/graylog2/graylog2-secrets.json"))
    else
      FileUtils.mkdir("/etc/graylog2")
      existing_secrets['graylog2_server'] = Hash.new
    end

    existing_secrets['graylog2_server']['admin_password'] = Digest::SHA2.new << pwd
    File.open("/etc/graylog2/graylog2-secrets.json","w") do |secrets|
      secrets.write(JSON.pretty_generate(existing_secrets))
    end
  else
    puts "Usage: #{cmd_name} <password>"
  end
end
