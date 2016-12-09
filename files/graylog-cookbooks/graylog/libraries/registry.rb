require 'etcd'
require 'socket'
require 'timeout'

class GraylogRegistry
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

  def add_gl_server(ip)
    add_node(ip, 'servers')
  end
  
  def get_gl_servers
    servers = get_node_list('servers')
    if Graylog['local_connect']
      return ['127.0.0.1']
    elsif servers.empty?
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
    if Graylog['local_connect']
      return ['127.0.0.1']
    elsif es_nodes.empty?
      return [@node['ipaddress']]
    else
      return es_nodes
    end
  end

  def get_es_host
    if Graylog['local_connect']
      return '127.0.0.1'
    else
      return @node['ipaddress']
    end
  end

  private
  def get_connection
    master = get_master
    Etcd.client(host: master, port: 4001)
  end

  def get_master
    if File.exists?("/etc/graylog/graylog-settings.json")
      existing_settings = JSON.parse(File.read("/etc/graylog/graylog-settings.json"))
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
      check_connection
      @client.set("/#{context}/#{ip}", value: "{\"ip\":\"#{ip}\"}")
    rescue Exception => e
      Chef::Log.debug("Can not add node #{ip} to directory #{context}")
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

  def check_connection
    if not is_port_open?(get_master, 4001)
      Chef::Application.fatal!("Can not reach etcd, please check that service is running!")
    end
  end

  def is_port_open?(ip, port)
    begin
      Timeout::timeout(30) do
        loop {
          begin
            s = TCPSocket.new(ip, port)
            s.close
            return true
          rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          end
          Chef::Log.info("Etcd is not running, reconnecting...")
          sleep 1
        }
      end
    rescue Timeout::Error
    end

    return false
  end
end
