es_log_dir  = node['graylog']['elasticsearch']['log_directory']
es_data_dir = node['graylog']['elasticsearch']['data_directory']
es_user     = node['graylog']['user']['username']

directory es_log_dir do
  owner es_user
  mode "0700"
  recursive true
end

directory es_data_dir do
  owner es_user
  group node['graylog']['user']['group']
  mode "0750"
  recursive true
end

template "#{node['graylog']['install_directory']}/conf/elasticsearch.yml" do
  owner es_user
  group node['graylog']['user']['group']
  mode "0644"
  variables(
    :es_host  => $registry.get_es_host,
    :es_nodes => $registry.get_es_nodes.map{|x| "#{x}:9300"}.to_s
  )
  notifies :restart, 'service[elasticsearch]'
end

runit_service "elasticsearch" do
  restart_command "-w 45 restart"
  run_restart false
  options({
    :log_directory => es_log_dir,
    :install_directory => node['graylog']['install_directory'],
    :max_memory => "#{(node.memory.total.to_i * 0.7 ).floor / 1024}m"
  }.merge(params))
  log_options node['graylog']['logging'].to_hash.merge(node['graylog']['elasticsearch'].to_hash)
end

if node['graylog']['bootstrap']['enable']
  execute "/opt/graylog/embedded/bin/graylog-ctl start elasticsearch" do
    retries 20
  end
end

ruby_block "add node to cluster list" do
  block do
    $registry.add_es_node(node['ipaddress'])
  end
end
