default['graylog']['bootstrap']['enable'] = true
default['graylog']['install_directory'] = "/opt/graylog"
default['graylog']['var_directory'] = "/var/opt/graylog"
default['graylog']['authorized_ports'] = [514]
default['graylog']['timezone'] = "Etc/UTC"
default['graylog']['smtp_server'] = false
default['graylog']['smtp_port'] = 587
default['graylog']['smtp_user'] = false
default['graylog']['smtp_password'] = false

default['graylog']['user']['username'] = "graylog"
default['graylog']['user']['group'] = "graylog"
default['graylog']['user']['uid'] = nil
default['graylog']['user']['gid'] = nil
default['graylog']['user']['shell'] = "/bin/sh"
default['graylog']['user']['home'] = "/var/opt/graylog"
default['graylog']['user']['git_user_name'] = "Graylog"
default['graylog']['user']['git_user_email'] = "graylog@#{node['fqdn']}"

default['graylog']['elasticsearch']['enable'] = true
default['graylog']['elasticsearch']['log_directory'] = "/var/log/graylog/elasticsearch"
default['graylog']['elasticsearch']['data_directory'] = "/var/opt/graylog/data/elasticsearch"

default['graylog']['mongodb']['enable'] = true
default['graylog']['mongodb']['log_directory'] = "/var/log/graylog/mongodb"
default['graylog']['mongodb']['data_directory'] = "/var/opt/graylog/data/mongodb"

default['graylog']['nginx']['enable'] = true
default['graylog']['nginx']['log_directory'] = "/var/log/graylog/nginx"

default['graylog']['etcd']['enable'] = true
default['graylog']['etcd']['log_directory'] = "/var/log/graylog/etcd"
default['graylog']['etcd']['data_directory'] = "/var/opt/graylog/data/etcd"

default['graylog']['graylog-server']['enable'] = true
default['graylog']['graylog-server']['log_directory'] = "/var/log/graylog/server"
default['graylog']['graylog-server']['journal_directory'] = "/var/opt/graylog/data/journal"
default['graylog']['graylog-server']['node_id'] = "/var/opt/graylog/graylog-server-node-id"
default['graylog']['graylog-server']['wrapper'] = "/opt/graylog/embedded/bin/authbind"

default['graylog']['graylog-web']['enable'] = true
default['graylog']['graylog-web']['log_directory'] = "/var/log/graylog/web"
default['graylog']['graylog-web']['port'] = 9000
default['graylog']['graylog-web']['bind'] = "0.0.0.0"

default['graylog']['logging']['svlogd_size'] = 200 * 1024 * 1024 # rotate after 200 MB of log data
default['graylog']['logging']['svlogd_num'] = 30 # keep 30 rotated log files
default['graylog']['logging']['svlogd_timeout'] = 24 * 60 * 60 # rotate after 24 hours
default['graylog']['logging']['svlogd_filter'] = "gzip" # compress logs with gzip
default['graylog']['logging']['svlogd_udp'] = nil # transmit log messages via UDP
default['graylog']['logging']['svlogd_prefix'] = nil # custom prefix for log messages
default['graylog']['logging']['udp_log_shipping_host'] = nil # remote host to ship log messages to via UDP
default['graylog']['logging']['udp_log_shipping_port'] = 514 # remote host to ship log messages to via UDP
