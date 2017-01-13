add_command 'set-mongodb-password', 'Set and activate MongoDB password', 2 do |cmd_name|
  require 'optparse'
  require 'mongo'
  require 'fileutils'
  require 'json'

  options = OpenStruct.new
  options.admin = false
  options.graylog = false
  cmd = ::OptionParser.new do |opts|
    opts.banner = "Usage: #{cmd_name} --username=<username> --password=<password>"

    opts.on("-u", "--username USERNAME", String, "MongoDB username") { |username| options.username = username }
    opts.on("-p", "--password PASSWORD", String, "MongoDB password") { |password| options.password = password }
    opts.on("-a", "--admin", "User is the DB admin") { |admin| options.admin = admin }
    opts.on("-g", "--graylog", "User should be used for Graylog server") { |gl| options.graylog = gl }

    opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit
    end
  end
  cmd.parse!
  if !options.username || !options.password
    puts cmd.help
    exit
  end

  existing_secrets ||= Hash.new
  if File.exists?("/etc/graylog/graylog-secrets.json")
    existing_secrets = JSON.parse(File.read("/etc/graylog/graylog-secrets.json"))
  else
    FileUtils.mkdir_p("/etc/graylog")
  end

  mongodb_secrets = existing_secrets['mongodb_server'] ||= Hash.new
  create_or_update_user(options.username, options.password, options.admin, mongodb_secrets)

  mongodb_secrets[options.username] = { :password => options.password, :is_admin_user => options.admin, :is_graylog_user => options.graylog }
  existing_secrets['mongodb_server'] = mongodb_secrets
  File.open("/etc/graylog/graylog-secrets.json","w") do |secrets|
    secrets.write(JSON.pretty_generate(existing_secrets))
  end
end

def create_or_update_user(name, password, admin, secrets)
  auth_user     = find_admin_user(secrets)
  auth_password = secrets[auth_user]['password'] if auth_user
  database      = admin == true ? "admin" : "graylog"
  roles = admin == true ? [ Mongo::Auth::Roles::ROOT, Mongo::Auth::Roles::DATABASE_ADMIN_ANY_DATABASE ] :
                          [ Mongo::Auth::Roles::DATABASE_ADMIN, Mongo::Auth::Roles::READ_WRITE ]

  if !auth_user && !admin
    puts "No admin user found, create one before setting up unprivileged users!"
  end

  if auth_user && name != auth_user && admin
    puts "There is already an admin user. Create an unprivileged user for Graylog server"
    exit
  end

  existing_graylog_user = find_graylog_user(secrets)
  if !admin && !existing_graylog_user.nil? && name != existing_graylog_user
    puts "There is already a service user for Graylog. Remove it from /etc/graylog/graylog-secrets.json before setting up a new one"
    exit
  end
  if secrets.length == 0
    puts "Seems like this is your first MongoDB user. Run 'sudo graylog-ctl reconfigure' to activate database authentication"
  end

  client = Mongo::Client.new([ '127.0.0.1:27017' ], :auth_source => 'admin', :user => auth_user, :password => auth_password, :database => database)
  db = client.database

  if db.users.info(name).empty?
    puts "Creating MongoDB user " + name
    db.users.create(name, :password => password, :roles => roles)
  else
    puts "Updating MongoDB user " + name
    db.users.update(name, :password => password, :roles => roles)
  end
end

def find_admin_user(secrets)
  secrets.each_key do |user|
    if secrets[user]['is_admin_user']
      return user
    end
  end
  return nil
end

def find_graylog_user(secrets)
  secrets.each_key do |user|
    if secrets[user]['is_graylog_user']
      return user
    end
  end
  return nil
end
