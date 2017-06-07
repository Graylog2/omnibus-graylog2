server_log_dir     = node['graylog']['graylog-server']['log_directory']
server_journal_dir = node['graylog']['graylog-server']['journal_directory']
server_user        = node['graylog']['user']['username']
mongo_login        = Graylog.get_mongodb_user

directory server_log_dir do
  owner server_user
  mode "0700"
  recursive true
end

directory server_journal_dir do
  owner server_user
  group node['graylog']['user']['group']
  mode "0750"
  recursive true
end

file node['graylog']['graylog-server']['node_id'] do
  content Graylog['node_id'] if Graylog['node_id']
  owner server_user
  notifies :restart, 'service[graylog-server]', :delayed
end

if not Graylog['smtp_server'].empty?
  email_enabled = true
else
  email_enabled = false
end

if not Graylog['smtp_user'].empty? and not Graylog['smtp_password'].empty?
  email_auth = true
else
  email_auth = false
end

template "#{node['graylog']['install_directory']}/conf/graylog.conf" do
  owner server_user
  group node['graylog']['user']['group']
  mode "0644"
  variables(
    :is_master     => $registry.is_master.to_s,
    :email_enabled => email_enabled,
    :email_auth    => email_auth,
    :es_nodes      => $registry.get_es_nodes.map{|x| "#{node['graylog']['graylog-server']['elasticsearch_protocol']}://#{x}:9200"}.join(","),
    :mongo_server  => Graylog['master_node'],
    :mongo_login   => mongo_login,
    :web_listen_uri => Graylog['web_listen_uri'] || node['graylog']['graylog-server']['web_listen_uri'],
    :rest_listen_uri => Graylog['rest_listen_uri'] || node['graylog']['graylog-server']['rest_listen_uri']
  )
  notifies :restart, 'service[graylog-server]', :delayed
end

template "#{node['graylog']['install_directory']}/conf/log4j2.xml" do
  owner server_user
  group node['graylog']['user']['group']
  mode "0644"
end

server_jar = "graylog-server.jar"
if File.exists? "#{node['graylog']['install_directory']}/server/graylog.jar"
  server_jar = "graylog.jar server"
end

runit_service "graylog-server" do
  restart_command "-w 20 force-restart"
  run_restart false
  options({
    :log_directory => server_log_dir,
    :install_directory => node['graylog']['install_directory'],
    :server_jar => server_jar,
    :max_memory => node['graylog']['graylog-server']['memory']
  }.merge(params))
  log_options node['graylog']['logging'].to_hash.merge(node['graylog']['graylog-server'].to_hash)
  ignore_failure true
end

if node['graylog']['bootstrap']['enable']
  execute "/opt/graylog/embedded/bin/graylog-ctl start graylog-server" do
    retries 20
  end
end

ruby_block "add node to server list" do
  block do
    $registry.set_master
    $registry.add_gl_server(node['ipaddress'])
    $registry.add_es_node(node['ipaddress'])
  end
  retries 15
end
