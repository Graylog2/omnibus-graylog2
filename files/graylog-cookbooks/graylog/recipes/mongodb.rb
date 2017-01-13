mongodb_log_dir  = node['graylog']['mongodb']['log_directory']
mongodb_data_dir = node['graylog']['mongodb']['data_directory']
mongodb_user     = node['graylog']['user']['username']
mongodb_listen   = Graylog['local_connect'] ? '127.0.0.1' : '0.0.0.0'
mongodb_login    = Graylog.get_mongodb_user

directory mongodb_log_dir do
  owner mongodb_user
  mode "0700"
  recursive true
end

directory mongodb_data_dir do
  owner mongodb_user
  group node['graylog']['user']['group']
  mode "0750"
  recursive true
end

runit_service "mongodb" do
  options({
    :log_directory => mongodb_log_dir,
    :install_directory => node['graylog']['install_directory'],
    :listen_address => mongodb_listen,
    :auth => mongodb_login.nil? ? false : true
  }.merge(params))
  log_options node['graylog']['logging'].to_hash.merge(node['graylog']['mongodb'].to_hash)
end

if node['graylog']['bootstrap']['enable']
  execute "/opt/graylog/embedded/bin/graylog-ctl start mongodb" do
    retries 20
  end
end
