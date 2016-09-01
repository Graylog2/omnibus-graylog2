add_command 'set-listen-address', 'Set the IP address on which Graylog\'s API/UI is listening on', 2 do |cmd_name|
  require 'optparse'
  require 'fileutils'
  require 'json'
  require 'socket'
  require 'uri'

  options = {}
  ::OptionParser.new do |opts|
    opts.on("--service NAME", String, "Service to set web|rest|transport|endpoint") do |value|
      options[:service] = value
    end
    opts.on("--address ADDRESS", String, "Listen URI, like http://127.0.0.1:9000/api") do |value|
      options[:address] = value
    end

    opts.banner = "Usage: graylog-ctl set-listen-address [options]"
    opts.on("-h", "--help", "Displays help") do
      puts opts
      exit
    end
  end.parse!

  if options[:service] && options[:address]
    existing_settings = Hash.new
    if File.exists?("/etc/graylog/graylog-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
    end

    case options[:service]
    when "web"
      existing_settings['web_listen_uri'] = URI(options[:address]).to_s || false
    when "endpoint"
      existing_settings['web_endpoint_uri'] = URI(options[:address]).to_s || false
    when "rest"
      existing_settings['rest_listen_uri'] = URI(options[:address]).to_s || false
    when "transport"
      existing_settings['rest_transport_uri'] = URI(options[:address]).to_s || false
    end

    File.open("/etc/graylog/graylog-settings.json","w") do |settings|
      settings.write(JSON.pretty_generate(existing_settings))
    end
  else
    puts "Usage: #{cmd_name} --service <web|rest|transport|endpoint> --address <http://someaddress:port>"
    exit
  end
  log("Setting the #{options[:service]} listen address to #{options[:address]}")
end
