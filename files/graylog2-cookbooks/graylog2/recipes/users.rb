#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# Copyright:: Copyright (c) 2014 GitLab.com
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

graylog2_username = node['graylog2']['user']['username']
graylog2_group    = node['graylog2']['user']['group']
graylog2_home     = node['graylog2']['user']['home']

directory graylog2_home do
  recursive true
end

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

# Configure Git settings for the Graylog2 user
template File.join(graylog2_home, ".gitconfig") do
  source "gitconfig.erb"
  owner graylog2_username
  group graylog2_group
  mode "0644"
  variables(node['graylog2']['user'].to_hash)
end
