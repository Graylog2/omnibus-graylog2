nginx_user     = node['graylog']['nginx']['user']
nginx_log_dir  = node['graylog']['nginx']['log_directory']
nginx_ca_dir   = File.join(node['graylog']['install_directory'], "conf", "nginx", "ca")

ssl_keyfile      = File.join(nginx_ca_dir, "graylog.key")
ssl_crtfile      = File.join(nginx_ca_dir, "graylog.crt")
ssl_signing_conf = File.join(nginx_ca_dir, "graylog-ssl.conf")

directory  nginx_ca_dir do
  owner nginx_user
  mode '0700'
  recursive true
end

directory nginx_log_dir do
  owner nginx_user
  mode "0700"
  recursive true
end

unless File.exists?(ssl_keyfile) && File.exists?(ssl_crtfile) && File.exists?(ssl_signing_conf)
  file ssl_keyfile do
    owner "root"
    group "root"
    mode "0644"
    content `/opt/graylog/embedded/bin/openssl genrsa 2048`
    not_if { File.exists?(ssl_keyfile) }
  end

  file ssl_signing_conf do
    owner "root"
    group "root"
    mode "0644"
    not_if { File.exists?(ssl_signing_conf) }
    content <<-EOH
  [ req ]
  distinguished_name = req_distinguished_name
  prompt = no

  [ req_distinguished_name ]
  C                      = #{node['graylog']['nginx']['ssl_country_name']}
  ST                     = #{node['graylog']['nginx']['ssl_state_name']}
  L                      = #{node['graylog']['nginx']['ssl_locality_name']}
  O                      = #{node['graylog']['nginx']['ssl_company_name']}
  OU                     = #{node['graylog']['nginx']['ssl_organizational_unit_name']}
  CN                     = #{node['graylog']['nginx']['server_name']}
  emailAddress           = #{node['graylog']['nginx']['ssl_email_address']}
  EOH
  end

  ruby_block "create crtfile" do
    block do
      r = Chef::Resource::File.new(ssl_crtfile, run_context)
      r.owner "root"
      r.group "root"
      r.mode "0644"
      r.content `/opt/graylog/embedded/bin/openssl req -config '#{ssl_signing_conf}' -new -x509 -nodes -sha1 -days 3650 -key #{ssl_keyfile}`
      r.not_if { File.exists?(ssl_crtfile) }
      r.run_action(:create)
    end
  end
end

node.default['graylog']['nginx']['ssl_certificate'] = ssl_crtfile
node.default['graylog']['nginx']['ssl_certificate_key'] = ssl_keyfile

template "#{node['graylog']['install_directory']}/conf/nginx/nginx.conf" do
  owner node['graylog']['user']['username']
  group node['graylog']['user']['group']
  mode "0644"
  notifies :restart, 'service[nginx]'
end

template "#{node['graylog']['install_directory']}/embedded/html/502.html" do
  owner node['graylog']['user']['username']
  group node['graylog']['user']['group']
  mode "0644"
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
