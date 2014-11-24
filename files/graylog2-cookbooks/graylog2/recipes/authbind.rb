if platform?("ubuntu", "debian")
  directory "/etc/authbind/byport" do
    action :create
    recursive true
  end

  if node['graylog2']['authorized_ports'].kind_of?(Array)
    node['graylog2']['authorized_ports'].each do |authorized_port|
      authorized_port = authorized_port.to_s.prepend "!" if authorized_port >= 512
      file "/etc/authbind/byport/#{authorized_port}" do
        owner node['graylog2']['user']['username']
        group node['graylog2']['user']['group']
        mode "0550"
        action :create
      end
    end
  end
else
  Chef::Log.error "Authbind is only available on Ubuntu/Debian systems."
  node.override['graylog2']['graylog2-server']['wrapper'] = nil
end
