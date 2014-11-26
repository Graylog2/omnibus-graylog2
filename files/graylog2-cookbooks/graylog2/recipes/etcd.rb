etcd_log_dir  = node['graylog2']['etcd']['log_directory']
etcd_data_dir = node['graylog2']['etcd']['data_directory']
etcd_user     = node['graylog2']['user']['username']

directory etcd_log_dir do
  owner etcd_user
  mode "0700"
  recursive true
end

directory etcd_data_dir do
  owner etcd_user
  group node['graylog2']['user']['group']
  mode "0750"
  recursive true
end

runit_service "etcd" do
  options({
    :log_directory  => etcd_log_dir,
    :data_directory => etcd_data_dir,
    :install_directory => node['graylog2']['install_directory']
  }.merge(params))
  log_options node['graylog2']['logging'].to_hash.merge(node['graylog2']['etcd'].to_hash)
end

if node['graylog2']['bootstrap']['enable']
  execute "/opt/graylog2/embedded/bin/graylog2-ctl start etcd" do
    retries 20
  end
end
