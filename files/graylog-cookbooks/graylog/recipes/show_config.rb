Graylog[:node] = node
config = Graylog.generate_config(node['fqdn'])

puts Chef::JSONCompat.to_json_pretty(config)
return
