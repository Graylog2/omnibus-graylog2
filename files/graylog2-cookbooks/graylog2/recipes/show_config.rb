Graylog2[:node] = node
config = Graylog2.generate_config(node['fqdn'])

puts Chef::JSONCompat.to_json_pretty(config)
return
