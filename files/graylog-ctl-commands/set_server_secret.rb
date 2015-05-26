add_command 'set-server-secret', 'Override server secret token', 2 do |cmd_name, token|
  require 'fileutils'
  require 'json'

  if token
    existing_secrets ||= Hash.new
    if File.exists?("/etc/graylog/graylog-secrets.json")
      existing_secrets = JSON.parse(File.read("/etc/graylog/graylog-secrets.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
      existing_secrets['graylog_server'] = Hash.new
    end

    existing_secrets['graylog_server']['secret_token'] = token
    File.open("/etc/graylog/graylog-secrets.json","w") do |secrets|
      secrets.write(JSON.pretty_generate(existing_secrets))
    end
  else
    puts "Usage: #{cmd_name} <token>"
  end
end
