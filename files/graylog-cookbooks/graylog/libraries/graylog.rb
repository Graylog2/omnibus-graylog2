require 'mixlib/config'
require 'chef/mash'
require 'chef/json_compat'
require 'chef/mixin/deep_merge'
require 'securerandom'
require 'uri'
require 'digest/sha2'
require 'etcd'

module Graylog
  extend(Mixlib::Config)

  bootstrap Mash.new
  user Mash.new
  elasticsearch Mash.new
  mongodb Mash.new
  nginx Mash.new
  graylog_server Mash.new
  timezone String.new
  smtp_server String.new
  smtp_port nil
  smtp_user String.new
  smtp_password String.new
  rotation_size nil
  rotation_time nil
  indices nil
  journal_size nil
  etcd Mash.new
  node nil
  custom_attributes Mash.new

  class << self

    # guards against creating secrets on non-bootstrap node
    def generate_hex(chars)
      SecureRandom.hex(chars)
    end

    def generate_secrets(node_name)
      existing_secrets ||= Hash.new
      if File.exists?("/etc/graylog/graylog-secrets.json")
        existing_secrets = Chef::JSONCompat.from_json(File.read("/etc/graylog/graylog-secrets.json"))
      end
      existing_secrets.each do |k, v|
        v.each do |pk, p|
          Graylog[k][pk] = p
        end
      end

      Graylog['graylog_server']['secret_token']   ||= generate_hex(64)
      Graylog['graylog_server']['admin_password'] ||= Digest::SHA2.new << "admin"
      Graylog['graylog_server']['admin_username'] ||= "admin"

      if File.directory?("/etc/graylog")
        File.open("/etc/graylog/graylog-secrets.json", "w") do |f|
          f.puts(
            Chef::JSONCompat.to_json_pretty({
              'graylog_server' => {
                'secret_token' => Graylog['graylog_server']['secret_token'],
                'admin_password' => Graylog['graylog_server']['admin_password'],
                'admin_username' => Graylog['graylog_server']['admin_username'],
              }
            })
          )
          system("chmod 0600 /etc/graylog/graylog-secrets.json")
        end
      end
    end

    def generate_bootstrap
      if File.exists?("/var/opt/graylog/bootstrapped")
        Graylog['bootstrap']['bootstrapped'] = true
      else
        Graylog['bootstrap']['bootstrapped'] = false
      end
    end

    def generate_services
      existing_services ||= Hash.new
      if File.exists?("/etc/graylog/graylog-services.json")
        existing_services = Chef::JSONCompat.from_json(File.read("/etc/graylog/graylog-services.json"))
      end
      existing_services.each do |k, v|
        v.each do |pk, p|
          Graylog[k][pk] = p
        end
      end

      Graylog['etcd']['enabled']            = Graylog[:node]['graylog']['etcd']['enable'] if Graylog['etcd']['enabled'].nil?
      Graylog['nginx']['enabled']           = Graylog[:node]['graylog']['nginx']['enable'] if Graylog['nginx']['enabled'].nil?
      Graylog['mongodb']['enabled']         = Graylog[:node]['graylog']['mongodb']['enable'] if Graylog['mongodb']['enabled'].nil?
      Graylog['elasticsearch']['enabled']   = Graylog[:node]['graylog']['elasticsearch']['enable'] if Graylog['elasticsearch']['enabled'].nil?
      Graylog['graylog_server']['enabled']  = Graylog[:node]['graylog']['graylog-server']['enable'] if Graylog['graylog_server']['enabled'].nil?

      if File.directory?("/etc/graylog")
        File.open("/etc/graylog/graylog-services.json", "w") do |f|
          f.puts(
            Chef::JSONCompat.to_json_pretty({
              'etcd' => {
                'enabled' => Graylog['etcd']['enabled'],
              },
              'nginx' => {
                'enabled' => Graylog['nginx']['enabled'],
              },
              'mongodb' => {
                'enabled' => Graylog['mongodb']['enabled'],
              },
              'elasticsearch' => {
                'enabled' => Graylog['elasticsearch']['enabled'],
              },
              'graylog_server' => {
                'enabled' => Graylog['graylog_server']['enabled'],
              },
            })
          )
          system("chmod 0644 /etc/graylog/graylog-services.json")
        end
      end
    end

    def enabled?(service)
      Graylog[service.gsub('-', '_')]['enabled']
    end

    def generate_settings
      existing_settings ||= Hash.new
      if File.exists?("/etc/graylog/graylog-settings.json")
        existing_settings = Chef::JSONCompat.from_json(File.read("/etc/graylog/graylog-settings.json"))
      end
      existing_settings.each do |k, v|
        Graylog[k] = v
      end

      Graylog['timezone']         = Graylog[:node]['graylog']['timezone'] if Graylog['timezone'].empty?
      Graylog['smtp_server']      = Graylog[:node]['graylog']['smtp_server'] if Graylog['smtp_server'].nil?
      Graylog['smtp_port']        = Graylog[:node]['graylog']['smtp_port'] if Graylog['smtp_port'].nil?
      Graylog['smtp_user']        = Graylog[:node]['graylog']['smtp_user'] if Graylog['smtp_user'].nil?
      Graylog['smtp_password']    = Graylog[:node]['graylog']['smtp_password'] if Graylog['smtp_password'].nil?
      Graylog['smtp_from_email']  = Graylog[:node]['graylog']['smtp_from_email'] if Graylog['smtp_from_email'].nil?
      Graylog['smtp_web_url']     = Graylog[:node]['graylog']['smtp_web_url'] if Graylog['smtp_web_url'].nil?
      Graylog['smtp_no_tls']      ||= false
      Graylog['smtp_no_ssl']      ||= false
      Graylog['master_node']      ||= '127.0.0.1'
      Graylog['local_connect']    = false if Graylog['local_connect'].nil?
      Graylog['current_address']  = Graylog[:node][:ipaddress]
      Graylog['last_address']     ||= Graylog['current_address']
      Graylog['enforce_ssl']      ||= false
      Graylog['rotation_size']    = Graylog[:node]['graylog']['rotation_size'] if Graylog['rotation_size'].nil?
      Graylog['rotation_time']    = Graylog[:node]['graylog']['rotation_time'] if Graylog['rotation_time'].nil?
      Graylog['indices']          = Graylog[:node]['graylog']['indices'] if Graylog['indices'].nil?
      Graylog['journal_size']     = Graylog[:node]['graylog']['journal_size'] if Graylog['journal_size'].nil?
      Graylog['node_id']          ||= false
      Graylog['internal_logging'] ||= true if Graylog['internal_logging'].nil?

      if Graylog['current_address'] == '127.0.0.1'
        Chef::Application.fatal!("eth0 is down! Can not reconfigure Graylog.")
      end

      if Graylog['current_address'] != Graylog['last_address']
        Chef::Log.warn("IP change detected!")
        begin
          client = Etcd.client(host: Graylog['master_node'], port: 4001)
          client.delete("/servers/#{Graylog['last_address']}") if client.exists?("/servers/#{Graylog['last_address']}")
          client.delete("/elasticsearch/#{Graylog['last_address']}") if client.exists?("/elasticsearch/#{Graylog['last_address']}")
        rescue Exception => e
	        Chef::Application.fatal!("Can not reach master server, make sure #{Graylog['master_node']} is reachable and 'etcd' service is running properly.")
	      end
        Graylog['last_address'] = Graylog['current_address']
      end

      if File.directory?("/etc/graylog")
        File.open("/etc/graylog/graylog-settings.json", "w") do |f|
          f.puts(
            Chef::JSONCompat.to_json_pretty({
              'timezone' => Graylog['timezone'],
              'smtp_server' => Graylog['smtp_server'],
              'smtp_port' => Graylog['smtp_port'],
              'smtp_user' => Graylog['smtp_user'],
              'smtp_password' => Graylog['smtp_password'],
              'smtp_from_email' => Graylog['smtp_from_email'],
              'smtp_web_url' => Graylog['smtp_web_url'],
              'smtp_no_tls' => Graylog['smtp_no_tls'],
              'smtp_no_ssl' => Graylog['smtp_no_ssl'],
              'master_node' => Graylog['master_node'],
              'local_connect' => Graylog['local_connect'],
              'current_address' => Graylog['current_address'],
              'last_address' => Graylog['last_address'],
              'enforce_ssl' => Graylog['enforce_ssl'],
              'rotation_size' => Graylog['rotation_size'],
              'rotation_time' => Graylog['rotation_time'],
              'indices' => Graylog['indices'],
              'journal_size' => Graylog['journal_size'],
              'node_id' => Graylog['node_id'],
              'internal_logging' => Graylog['internal_logging'],
              'custom_attributes' => Graylog['custom_attributes']
            })
          )
          system("chmod 0644 /etc/graylog/graylog-settings.json")
        end
      end
    end

    def generate_hash
      results = { "graylog" => {} }
      [
        "bootstrap",
        "etcd",
        "nginx",
        "mongodb",
        "elasticsearch",
        "graylog-server",
      ].each do |key|
        rkey = key.gsub('_', '-')
        results['graylog'][rkey] = Graylog[key]
      end

      results
    end

    def generate_config(node_name)
      generate_secrets(node_name)
      generate_bootstrap
      generate_services
      generate_settings
      generate_hash
    end
  end
end
