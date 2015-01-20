add_command 'set-email-config', 'Setup email configuration', 2 do |cmd_name, server|
  require 'optparse'
  require 'fileutils'
  require 'json'

  options = {}
  ::OptionParser.new do |opts|
    opts.on("--port PORT", Integer, "SMTP server port") do |value|
      options[:port] = value
    end
    opts.on("--user USER", String, "SMTP user name") do |value|
      options[:user] = value
    end
    opts.on("--password PASSWORD", String, "SMTP password") do |value|
      options[:password] = value
    end
  end.parse!

  if server
    existing_settings = Hash.new
    if File.exists?("/etc/graylog/graylog-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
    end

    existing_settings['smtp_server']   = server
    existing_settings['smtp_port']     = options[:port] || 587
    existing_settings['smtp_user']     = options[:user] || ""
    existing_settings['smtp_password'] = options[:password] || ""
    File.open("/etc/graylog/graylog-settings.json","w") do |settings|
      settings.write(JSON.pretty_generate(existing_settings))
    end
  else
    puts "Usage: #{cmd_name} <smtp server> [--port=<smtp port> --user=<username> --password=<password>]"
  end
end
