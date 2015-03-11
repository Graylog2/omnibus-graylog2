add_command 'set-retention', 'Setup storage configuration', 2 do |cmd_name|
  require 'optparse'
  require 'fileutils'
  require 'json'

  options = {}
  ::OptionParser.new do |opts|
    opts.on("--size GBYTES", Integer, "Index size in Gb") do |value|
      options[:size] = value
    end
    opts.on("--time HOURS", String, "Index age in hours") do |value|
      options[:time] = value
    end
    opts.on("--indices NUMBER", String, "Maximum numbers of indices to keep") do |value|
      options[:indices] = value
    end
    opts.on("--journal GBYTES", String, "Journal size in Gb") do |value|
      options[:journal] = value
    end
  end.parse!

  begin
    raise OptionParser::MissingArgument if options[:indices].nil?
    raise OptionParser::MissingArgument if not options[:size].nil? and not options[:time].nil?

    existing_settings = Hash.new
    if File.exists?("/etc/graylog/graylog-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
    else
      FileUtils.mkdir_p("/etc/graylog")
    end

    existing_settings['rotation_size'] = options[:size] || 1
    existing_settings['rotation_size'] = existing_settings['rotation_size'] * 1073741824
    existing_settings['rotation_time'] = options[:time] || 0
    existing_settings['indices']       = options[:indices]
    existing_settings['journal_size']  = options[:journal] || 1
    File.open("/etc/graylog/graylog-settings.json","w") do |settings|
      settings.write(JSON.pretty_generate(existing_settings))
    end
  rescue
    puts "Usage: #{cmd_name} --size=<Gb> OR --time=<hours> --indices=<number> [--journal=<Gb>]"
  end
end
