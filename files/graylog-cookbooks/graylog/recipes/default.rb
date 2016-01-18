require 'openssl'

ENV['PATH'] = "/opt/graylog/bin:/opt/graylog/embedded/bin:#{ENV['PATH']}"

directory "/etc/graylog" do
  owner "root"
  group "root"
  mode "0775"
  action :nothing
end.run_action(:create)

Graylog[:node] = node
node.consume_attributes(Graylog.generate_config(node['fqdn']))
$registry = GraylogRegistry.new(node)
Chef::Mixin::DeepMerge.deep_merge!(Graylog[:custom_attributes], node.override[:graylog]) unless Graylog[:custom_attributes].nil?

if File.exists?("/var/opt/graylog/bootstrapped")
	node.set['graylog']['bootstrap']['enable'] = false
end

include_recipe "graylog::users"
include_recipe "graylog::authbind"
include_recipe "runit"
include_recipe "runit::svloggelfd"
include_recipe "timezone-ii"

# Configure Services
[
  "bootstrap",
  "etcd",
  "elasticsearch",
  "mongodb",
  "graylog-server",
  "nginx",
].each do |service|
  if Graylog.enabled?(service)
    include_recipe "graylog::#{service}"
  else
    include_recipe "graylog::#{service}_disable"
  end
end
