etcd_log_dir  = node['graylog']['etcd']['log_directory']
etcd_data_dir = node['graylog']['etcd']['data_directory']
etcd_user     = node['graylog']['user']['username']

directory etcd_log_dir do
  owner etcd_user
  mode "0700"
  recursive true
end

directory etcd_data_dir do
  owner etcd_user
  group node['graylog']['user']['group']
  mode "0750"
  recursive true
end

runit_service "etcd" do
  options({
    :log_directory  => etcd_log_dir,
    :data_directory => etcd_data_dir,
    :install_directory => node['graylog']['install_directory']
  }.merge(params))
  log_options node['graylog']['logging'].to_hash.merge(node['graylog']['etcd'].to_hash)
end

execute "remove unneeded snapshot files" do
  command "rm #{File.join(etcd_data_dir, 'member', 'snap', '*')}"
  only_if { !Dir.glob(File.join(etcd_data_dir, 'member', 'snap', '*.snap')).empty? }
end

if node['graylog']['bootstrap']['enable']
  execute "/opt/graylog/embedded/bin/graylog-ctl start etcd" do
    retries 20
  end
end
