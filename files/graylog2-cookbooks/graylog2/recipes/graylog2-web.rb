web_log_dir  = node['graylog2']['graylog2-web']['log_directory']
web_user     = node['graylog2']['user']['username']

directory web_log_dir do
  owner web_user
  mode "0700"
  recursive true
end

template "#{node['graylog2']['install_directory']}/conf/graylog2-web-interface.conf" do
  owner web_user
  group node['graylog2']['user']['group']
  mode "0644"
  variables ( lazy {{
    :server_uri => $registry.get_gl2_servers.map{|x| "http://#{x}:12900/"}.join(",")
  }})
end

runit_service "graylog2-web" do
  options({
    :log_directory => web_log_dir,
    :install_directory => node['graylog2']['install_directory']
  }.merge(params))
  log_options node['graylog2']['logging'].to_hash.merge(node['graylog2']['graylog2-web'].to_hash)
end

if node['graylog2']['bootstrap']['enable']
  execute "/opt/graylog2/embedded/bin/graylog2-ctl start graylog2-web" do
    retries 20
  end
end
