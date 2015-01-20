template "#{node['graylog']['install_directory']}/conf/nginx/nginx.conf" do
  owner node['graylog']['user']['username']
  group node['graylog']['user']['group']
  mode "0644"
  notifies :restart, 'service[nginx]'
end

nginx_log_dir  = node['graylog']['nginx']['log_directory']
nginx_user     = 'root'

directory nginx_log_dir do
  owner nginx_user
  mode "0700"
  recursive true
end

runit_service "nginx" do
  options({
    :log_directory => nginx_log_dir,
  }.merge(params))
  log_options node['graylog']['logging'].to_hash.merge(node['graylog']['nginx'].to_hash)
end

if node['graylog']['bootstrap']['enable']
  execute "/opt/graylog/embedded/bin/graylog-ctl start nginx" do
    retries 20
  end
end
