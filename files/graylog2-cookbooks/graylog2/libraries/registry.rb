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
      @client.set('/nodes/master', value: node['ipaddress'])
    end
  end

  def get_servers
    @client.get('/nodes/master').value
  end

  private
  def get_connection
    Etcd.client(host: get_master, port: 4001)
  end

  def get_master
    if File.exists?("/etc/graylog2/graylog2-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog2/graylog2-settings.json"))
    end

    if not existing_settings['master_node'].nil? and existing_settings['master_node'] != @node['ipaddress']
      master = existing_settings['master_node']
      @is_master = false
    else
      master = 'localhost'
      @is_master = true
    end

    return master
  end
end
