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

  def get_gl2_server_list
    begin
      return @client.get('/nodes/master').value
    rescue Exception => e
      Chef::Log.debug("Can not fetch server list from etcd #{e.message}")
      return '127.0.0.1'
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
end
