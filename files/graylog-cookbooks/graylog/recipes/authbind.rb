if platform?("ubuntu", "debian")
  directory "/etc/authbind/byport" do
    action :create
    recursive true
  end

  if node['graylog']['authorized_ports'].kind_of?(Array)
    node['graylog']['authorized_ports'].each do |authorized_port|
      authorized_port = authorized_port.to_s.prepend "!" if authorized_port >= 512
      file "/etc/authbind/byport/#{authorized_port}" do
        owner node['graylog']['user']['username']
        group node['graylog']['user']['group']
        mode "0550"
        action :create
      end
    end
  end
else
  Chef::Log.error "Authbind is only available on Ubuntu/Debian systems."
  node.override['graylog']['graylog-server']['wrapper'] = nil
end
