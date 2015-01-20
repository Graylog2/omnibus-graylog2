add_command 'set-admin-password', 'Override admin password', 2 do |cmd_name, pwd|
  require 'fileutils'
  require 'json'
  require 'digest/sha2'

  if pwd
    existing_secrets ||= Hash.new
    if File.exists?("/etc/graylog/graylog-secrets.json")
      existing_secrets = JSON.parse(File.read("/etc/graylog/graylog-secrets.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
      existing_secrets['graylog_server'] = Hash.new
    end

    existing_secrets['graylog_server']['admin_password'] = Digest::SHA2.new << pwd
    File.open("/etc/graylog/graylog-secrets.json","w") do |secrets|
      secrets.write(JSON.pretty_generate(existing_secrets))
    end
  else
    puts "Usage: #{cmd_name} <password>"
  end
end
