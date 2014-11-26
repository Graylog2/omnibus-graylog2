default['graylog2']['bootstrap']['enable'] = true
default['graylog2']['install_directory'] = "/opt/graylog2"
default['graylog2']['var_directory'] = "/var/opt/graylog2"
default['graylog2']['authorized_ports'] = [514]
default['graylog2']['timezone'] = "Etc/UTC"
default['graylog2']['smtp_server'] = false
default['graylog2']['smtp_port'] = 587
default['graylog2']['smtp_user'] = false
default['graylog2']['smtp_password'] = false

default['graylog2']['user']['username'] = "graylog2"
default['graylog2']['user']['group'] = "graylog2"
default['graylog2']['user']['uid'] = nil
default['graylog2']['user']['gid'] = nil
default['graylog2']['user']['shell'] = "/bin/sh"
default['graylog2']['user']['home'] = "/var/opt/graylog2"
default['graylog2']['user']['git_user_name'] = "Graylog2"
default['graylog2']['user']['git_user_email'] = "graylog2@#{node['fqdn']}"

default['graylog2']['elasticsearch']['enable'] = true
default['graylog2']['elasticsearch']['log_directory'] = "/var/log/graylog2/elasticsearch"
default['graylog2']['elasticsearch']['data_directory'] = "/var/opt/graylog2/data/elasticsearch"

default['graylog2']['mongodb']['enable'] = true
default['graylog2']['mongodb']['log_directory'] = "/var/log/graylog2/mongodb"
default['graylog2']['mongodb']['data_directory'] = "/var/opt/graylog2/data/mongodb"

default['graylog2']['nginx']['enable'] = true
default['graylog2']['nginx']['log_directory'] = "/var/log/graylog2/nginx"

default['graylog2']['etcd']['enable'] = true
default['graylog2']['etcd']['log_directory'] = "/var/log/graylog2/etcd"
default['graylog2']['etcd']['data_directory'] = "/var/opt/graylog2/data/etcd"

default['graylog2']['graylog2-server']['enable'] = true
default['graylog2']['graylog2-server']['log_directory'] = "/var/log/graylog2/server"
default['graylog2']['graylog2-server']['data_directory'] = "/var/opt/graylog2/data/spool"
default['graylog2']['graylog2-server']['node_id'] = "/var/opt/graylog2/graylog2-server-node-id"
default['graylog2']['graylog2-server']['wrapper'] = "/opt/graylog2/embedded/bin/authbind"

default['graylog2']['graylog2-web']['enable'] = true
default['graylog2']['graylog2-web']['log_directory'] = "/var/log/graylog2/web"
default['graylog2']['graylog2-web']['port'] = 9000
default['graylog2']['graylog2-web']['bind'] = "0.0.0.0"

default['graylog2']['logging']['svlogd_size'] = 200 * 1024 * 1024 # rotate after 200 MB of log data
default['graylog2']['logging']['svlogd_num'] = 30 # keep 30 rotated log files
default['graylog2']['logging']['svlogd_timeout'] = 24 * 60 * 60 # rotate after 24 hours
default['graylog2']['logging']['svlogd_filter'] = "gzip" # compress logs with gzip
default['graylog2']['logging']['svlogd_udp'] = nil # transmit log messages via UDP
default['graylog2']['logging']['svlogd_prefix'] = nil # custom prefix for log messages
default['graylog2']['logging']['udp_log_shipping_host'] = nil # remote host to ship log messages to via UDP
default['graylog2']['logging']['udp_log_shipping_port'] = 514 # remote host to ship log messages to via UDP
