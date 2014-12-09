template "#{node['graylog2']['install_directory']}/conf/nginx/nginx.conf" do
  owner node['graylog2']['user']['username']
  group node['graylog2']['user']['group']
  mode "0644"
  notifies :restart, 'service[nginx]'
end

nginx_log_dir  = node['graylog2']['nginx']['log_directory']
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
  log_options node['graylog2']['logging'].to_hash.merge(node['graylog2']['nginx'].to_hash)
end

if node['graylog2']['bootstrap']['enable']
  execute "/opt/graylog2/embedded/bin/graylog2-ctl start nginx" do
    retries 20
  end
end
