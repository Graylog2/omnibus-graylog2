require 'mixlib/shellout'

class OmnibusHelper

  def self.should_notify?(service_name)
    File.symlink?("/opt/graylog/service/#{service_name}") && service_up?(service_name)
  end

  def self.not_listening?(service_name)
    File.exists?("/opt/graylog/service/#{service_name}/down") && service_down?(service_name)
  end

  def self.service_up?(service_name)
    o = Mixlib::ShellOut.new("/opt/graylog/embedded/bin/graylog-ctl status #{service_name}")
    o.run_command
    o.exitstatus == 0
  end

  def self.service_down?(service_name)
    o = Mixlib::ShellOut.new("/opt/graylog/embedded/bin/graylog-ctl status #{service_name}")
    o.run_command
    o.exitstatus == 3
  end

end

module SingleQuoteHelper

  def single_quote(string)
   "'#{string}'" unless string.nil?
  end

end
