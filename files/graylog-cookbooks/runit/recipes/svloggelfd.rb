cookbook_file File.join(Chef::Config[:file_cache_path], "svloggelfd-#{node[:runit][:sv_loggelfd_version]}.tar.gz") {
  source "svloggelfd-#{node[:runit][:sv_loggelfd_version]}.tar.gz"
  action :create
}

execute 'extract svloggelfd' do
  command "tar xzvf #{File.join(Chef::Config[:file_cache_path], "svloggelfd-#{node[:runit][:sv_loggelfd_version]}.tar.gz")}"
  cwd "/opt/graylog/embedded/bin"
  not_if {File.exists?("/opt/graylog/embedded/bin/svloggelfd")}
end
