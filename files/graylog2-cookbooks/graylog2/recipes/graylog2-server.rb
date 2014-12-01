server_log_dir  = node['graylog2']['graylog2-server']['log_directory']
server_data_dir = node['graylog2']['graylog2-server']['data_directory']
server_user     = node['graylog2']['user']['username']

directory server_log_dir do
  owner server_user
  mode "0700"
  recursive true
end

directory server_data_dir do
  owner server_user
  group node['graylog2']['user']['group']
  mode "0750"
  recursive true
end

file node['graylog2']['graylog2-server']['node_id'] do
  owner server_user
end

if not Graylog2['smtp_server'].empty?
  email_enabled = true
else
  email_enabled = false
end

if not Graylog2['smtp_user'].empty? and not Graylog2['smtp_password'].empty?
  email_auth = true
else
  email_auth = false
end

template "#{node['graylog2']['install_directory']}/conf/graylog2.conf" do
  owner server_user
  group node['graylog2']['user']['group']
  mode "0644"
  variables(
    :email_enabled => email_enabled,
    :email_auth    => email_auth
  )
end

runit_service "graylog2-server" do
  options({
    :log_directory => server_log_dir,
    :install_directory => node['graylog2']['install_directory']
  }.merge(params))
  log_options node['graylog2']['logging'].to_hash.merge(node['graylog2']['graylog2-server'].to_hash)
end

if node['graylog2']['bootstrap']['enable']
  execute "/opt/graylog2/embedded/bin/graylog2-ctl start graylog2-server" do
    retries 20
  end
end

ruby_block "add node to server list" do
  block do
    $registry.set_master
  end
end
