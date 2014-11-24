require 'openssl'

ENV['PATH'] = "/opt/graylog2/bin:/opt/graylog2/embedded/bin:#{ENV['PATH']}"

directory "/etc/graylog2" do
  owner "root"
  group "root"
  mode "0775"
  action :nothing
end.run_action(:create)

Graylog2[:node] = node
node.consume_attributes(Graylog2.generate_config(node['fqdn']))

if File.exists?("/var/opt/graylog2/bootstrapped")
	node.set['graylog2']['bootstrap']['enable'] = false
end

include_recipe "graylog2::users"
include_recipe "graylog2::authbind"
include_recipe "runit"

directory "/var/opt/graylog2" do
  owner node['graylog2']['user']['username']
  group node['graylog2']['user']['group']
  mode "0755"
  recursive true
  action :create
end

# Configure Services
[
  "bootstrap",
  "elasticsearch",
  "graylog2-server",
  "graylog2-web",
  "mongodb",
].each do |service|
  if Graylog2.enabled?(service)
    include_recipe "graylog2::#{service}"
  else
    include_recipe "graylog2::#{service}_disable"
  end
end
