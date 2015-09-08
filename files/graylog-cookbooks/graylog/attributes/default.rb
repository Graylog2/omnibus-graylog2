default['graylog']['bootstrap']['enable'] = true
default['graylog']['install_directory'] = "/opt/graylog"
default['graylog']['var_directory'] = "/var/opt/graylog"
default['graylog']['authorized_ports'] = [514]
default['graylog']['timezone'] = "Etc/UTC"
default['graylog']['smtp_server'] = false
default['graylog']['smtp_port'] = 587
default['graylog']['smtp_user'] = false
default['graylog']['smtp_password'] = false
default['graylog']['rotation_size'] = 1073741824
default['graylog']['rotation_time'] = 0
default['graylog']['indices'] = 10
default['graylog']['journal_size'] = 1

default['graylog']['user']['username'] = "graylog"
default['graylog']['user']['group'] = "graylog"
default['graylog']['user']['uid'] = nil
default['graylog']['user']['gid'] = nil
default['graylog']['user']['shell'] = "/bin/sh"
default['graylog']['user']['home'] = "/var/opt/graylog"
default['graylog']['user']['git_user_name'] = "Graylog"
default['graylog']['user']['git_user_email'] = "graylog@#{node['fqdn']}"

default['graylog']['elasticsearch']['enable'] = true
default['graylog']['elasticsearch']['memory'] = nil # defaults to 60% of VM memory
default['graylog']['elasticsearch']['log_directory'] = "/var/log/graylog/elasticsearch"
default['graylog']['elasticsearch']['data_directory'] = "/var/opt/graylog/data/elasticsearch"

default['graylog']['mongodb']['enable'] = true
default['graylog']['mongodb']['log_directory'] = "/var/log/graylog/mongodb"
default['graylog']['mongodb']['data_directory'] = "/var/opt/graylog/data/mongodb"

default['graylog']['nginx']['enable'] = true
default['graylog']['nginx']['user'] = "root"
default['graylog']['nginx']['log_directory'] = "/var/log/graylog/nginx"
default['graylog']['nginx']['ssl_country_name'] = "DE"
default['graylog']['nginx']['ssl_state_name'] = "Hamburg"
default['graylog']['nginx']['ssl_locality_name'] = "Hamburg"
default['graylog']['nginx']['ssl_company_name'] = "Graylog"
default['graylog']['nginx']['ssl_organizational_unit_name'] = "Operations"
default['graylog']['nginx']['server_name'] = node['fqdn']
default['graylog']['nginx']['ssl_email_address'] = "graylog@#{node['fqdn']}"
default['graylog']['nginx']['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"
default['graylog']['nginx']['ssl_ciphers'] = "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA"

default['graylog']['etcd']['enable'] = true
default['graylog']['etcd']['log_directory'] = "/var/log/graylog/etcd"
default['graylog']['etcd']['data_directory'] = "/var/opt/graylog/data/etcd"

default['graylog']['graylog-server']['enable'] = true
default['graylog']['graylog-server']['memory'] = '1500m'
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

default['graylog']['nginx']['svlogd_size'] = 100 * 1024 * 1024 # rotate after 100 MB of log data
default['graylog']['nginx']['svlogd_num'] = 5 # reduced backlog for nginx
