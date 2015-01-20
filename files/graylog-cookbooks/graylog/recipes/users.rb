graylog_username = node['graylog']['user']['username']
graylog_group    = node['graylog']['user']['group']
graylog_home     = node['graylog']['user']['home']

# Create the group for the Graylog user
group graylog_group do
  gid node['graylog']['user']['gid']
end

# Create the Graylog user
user graylog_username do
  shell node['graylog']['user']['shell']
  home graylog_home
  uid node['graylog']['user']['uid']
  gid graylog_group
end

# create home directory
directory graylog_home do
  owner graylog_username
  group graylog_group
end

# Configure Git settings for the Graylog user
template File.join(graylog_home, ".gitconfig") do
  source "gitconfig.erb"
  owner graylog_username
  group graylog_group
  mode "0644"
  variables(node['graylog']['user'].to_hash)
end

# create additional directories
directory "#{graylog_home}/data" do
  owner graylog_username
  group graylog_group
end
