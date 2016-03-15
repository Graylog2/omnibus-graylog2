add_command 'set-email-config', 'Setup email configuration', 2 do |cmd_name, server|
  require 'optparse'
  require 'fileutils'
  require 'json'
  require 'socket'
  require 'uri'

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
    opts.on("--from-email ADDRESS", String, "Email sender address") do |value|
      options[:from] = value
    end
    opts.on("--web-url URL", String, "Web interface URL, used for backlinks") do |value|
      options[:web_url] = value
    end
    opts.on("--no-tls", "Disable TLS") do |value|
      options[:tls] = (not value)
    end
    opts.on("--no-ssl", "Disable SSL") do |value|
      options[:ssl] = (not value)
    end
  end.parse!

  if server
    if server.start_with?('-')
      puts "Please provide a SMTP server before any options!"
      exit 1
    end

    existing_settings = Hash.new
    if File.exists?("/etc/graylog/graylog-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
    end

    existing_settings['smtp_server']     = server
    existing_settings['smtp_port']       = options[:port] || 587
    existing_settings['smtp_user']       = options[:user] || ""
    existing_settings['smtp_password']   = options[:password] || ""
    existing_settings['smtp_no_tls']     = options[:tls] || false
    existing_settings['smtp_no_ssl']     = options[:ssl] || false
    existing_settings['smtp_from_email'] = options[:from] || "graylog@#{Socket.gethostname}"
    existing_settings['smtp_web_url']    = (URI(options[:web_url] || URI::HTTP.build(:host => Socket.gethostname))).to_s
    File.open("/etc/graylog/graylog-settings.json","w") do |settings|
      settings.write(JSON.pretty_generate(existing_settings))
    end
  else
    puts "Usage: #{cmd_name} <smtp server> [--port=<smtp port> --user=<username> --password=<password> --from-email=<sender address> --web-url=<web interface url> --no-tls --no-ssl]"
  end
end
