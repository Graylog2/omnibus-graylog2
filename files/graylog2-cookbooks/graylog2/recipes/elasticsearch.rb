es_log_dir  = node['graylog2']['elasticsearch']['log_directory']
es_data_dir = node['graylog2']['elasticsearch']['data_directory']
es_user     = node['graylog2']['user']['username']

directory es_log_dir do
  owner es_user
  mode "0700"
  recursive true
end

directory es_data_dir do
  owner es_user
  group node['graylog2']['user']['group']
  mode "0750"
  recursive true
end

template "#{node['graylog2']['install_directory']}/conf/elasticsearch.yml" do
  owner es_user
  group node['graylog2']['user']['group']
  mode "0644"
  variables(
    :es_nodes => $registry.get_es_nodes.map{|x| "#{x}:9300"}.to_s
  )
  notifies :restart, 'service[elasticsearch]'
end

runit_service "elasticsearch" do
  restart_command "-w 30 force-restart"
  options({
    :log_directory => es_log_dir,
    :install_directory => node['graylog2']['install_directory'],
    :max_memory => "#{(node.memory.total.to_i * 0.5 ).floor / 1024}m"
  }.merge(params))
  log_options node['graylog2']['logging'].to_hash.merge(node['graylog2']['elasticsearch'].to_hash)
end

if node['graylog2']['bootstrap']['enable']
  execute "/opt/graylog2/embedded/bin/graylog2-ctl start elasticsearch" do
    retries 20
  end
end

ruby_block "add node to cluster list" do
  block do
    $registry.add_es_node(node['ipaddress'])
  end
end
