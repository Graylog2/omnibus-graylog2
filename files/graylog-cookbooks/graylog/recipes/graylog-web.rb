web_log_dir  = node['graylog']['graylog-web']['log_directory']
web_user     = node['graylog']['user']['username']

directory web_log_dir do
  owner web_user
  mode "0700"
  recursive true
end

template "#{node['graylog']['install_directory']}/conf/graylog-web-interface.conf" do
  owner web_user
  group node['graylog']['user']['group']
  mode "0644"
  variables ( lazy {{
    :server_uri => $registry.get_gl_servers.map{|x| "http://#{x}:12900/"}.join(",")
  }})
  notifies :restart, 'service[graylog-web]'
end

template "#{node['graylog']['install_directory']}/conf/web-logger.xml" do
  owner web_user
  group node['graylog']['user']['group']
  mode "0644"
  notifies :restart, 'service[graylog-web]', :delayed
end

web_jar = "graylog-web-interface"
if File.exists? "#{node['graylog']['install_directory']}/web/bin/graylog-web-interface"
  web_jar = "graylog-web-interface"
end

runit_service "graylog-web" do
  restart_command "-w 45 restart"
  run_restart false
  options({
    :log_directory => web_log_dir,
    :install_directory => node['graylog']['install_directory'],
    :web_jar => web_jar
  }.merge(params))
  log_options node['graylog']['logging'].to_hash.merge(node['graylog']['graylog-web'].to_hash)
end

if node['graylog']['bootstrap']['enable']
  execute "/opt/graylog/embedded/bin/graylog-ctl start graylog-web" do
    retries 20
  end
end
