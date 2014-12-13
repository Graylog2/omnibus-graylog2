graylog2_username = node['graylog2']['user']['username']
graylog2_group    = node['graylog2']['user']['group']
graylog2_home     = node['graylog2']['user']['home']

# Create the group for the Graylog2 user
group graylog2_group do
  gid node['graylog2']['user']['gid']
end

# Create the Graylog2 user
user graylog2_username do
  shell node['graylog2']['user']['shell']
  home graylog2_home
  uid node['graylog2']['user']['uid']
  gid graylog2_group
end

# create home directory
directory graylog2_home do
  owner graylog2_username
  group graylog2_group
end

# Configure Git settings for the Graylog2 user
template File.join(graylog2_home, ".gitconfig") do
  source "gitconfig.erb"
  owner graylog2_username
  group graylog2_group
  mode "0644"
  variables(node['graylog2']['user'].to_hash)
end

# create additional directories
directory "#{graylog2_home}/data" do
  owner graylog2_username
  group graylog2_group
end
