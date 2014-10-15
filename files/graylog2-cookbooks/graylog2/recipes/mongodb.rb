mongodb_log_dir  = node['graylog2']['mongodb']['log_directory']
mongodb_data_dir = node['graylog2']['mongodb']['data_directory']
mongodb_user     = node['graylog2']['user']['username']

directory mongodb_log_dir do
  owner mongodb_user
  mode "0700"
  recursive true
end

directory mongodb_data_dir do
  owner mongodb_user
  group node['graylog2']['user']['group']
  mode "0750"
  recursive true
end

runit_service "mongodb" do
  options({
    :log_directory => mongodb_log_dir,
    :install_directory => node['graylog2']['install_directory']
  }.merge(params))
  log_options node['graylog2']['logging'].to_hash.merge(node['graylog2']['mongodb'].to_hash)
end

if node['graylog2']['bootstrap']['enable']
  execute "/opt/graylog2/embedded/bin/graylog2-ctl start mongodb" do
    retries 20
  end
end
