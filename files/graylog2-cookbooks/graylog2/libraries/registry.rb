require 'etcd'

class Graylog2Registry
  attr_reader :node
  attr_reader :client
  attr_reader :is_master

  def initialize(node)
    @node   = node
    @client = get_connection
  end

  def set_master    
    if @is_master
      @client.set('/master', value: node['ipaddress'])
    end
  end

  def get_master
    begin
      return @client.get('/master').value
    rescue Exception => e
      Chef::Log.debug("Can not fetch server list from etcd #{e.message}")
      return '127.0.0.1'
    end
  end

  def add_gl2_server(ip)
    add_node(ip, 'servers')
  end
  
  def get_gl2_servers
    servers = get_node_list('servers')
    if servers.empty?
      return [@node['ipaddress']]
    else
      return servers
    end
  end

  def add_es_node(ip)
    add_node(ip, 'elasticsearch')
  end
  
  def get_es_nodes
    es_nodes = get_node_list('elasticsearch')
    if es_nodes.empty?
      return [@node['ipaddress']]
    else
      return es_nodes
    end
  end

  private
  def get_connection
    master = get_master
    Etcd.client(host: master, port: 4001)
  end

  def get_master
    if File.exists?("/etc/graylog2/graylog2-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog2/graylog2-settings.json"))
    end

    if existing_settings['master_node'].nil? or
        existing_settings['master_node'] == @node['ipaddress'] or
        existing_settings['master_node'] == "127.0.0.1"
      master = '127.0.0.1'
      @is_master = true
    else
      master = existing_settings['master_node']
      @is_master = false
    end

    return master
  end
  
  def add_node(ip, context)
    begin
      @client.set("/#{context}/#{ip}", value: "{\"ip\":\"#{ip}\"}")
    rescue Exception => e
      Chef::Log.debug("Can not add node #{name} to directory #{context}")
    end
  end
  
  def get_node_list(context)
    begin
      nodes = []
      @client.get("/#{context}").children.each do |child|
        nodes << JSON.parse(child.value)['ip']
      end
      return nodes
    rescue Exception => e
      Chef::Log.debug("Can not fetch node list from etcd #{e.message}")
    end
    return []
  end
end
