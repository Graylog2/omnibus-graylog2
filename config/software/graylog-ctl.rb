name "graylog-ctl"

dependency "rsync"
dependency "omnibus-ctl"

source :path => File.expand_path("files/graylog-ctl-commands", RbConfig::CONFIG['project_root'])

build do
  block do
    open("#{install_dir}/embedded/bin/graylog-ctl", "w") do |file|
      file.print <<-EOH
#!/bin/bash

# Ruby environment if graylog-ctl is called from a Ruby script.
for ruby_env_var in RUBYOPT \\
                    BUNDLE_BIN_PATH \\
                    BUNDLE_GEMFILE \\
                    GEM_PATH \\
                    GEM_HOME
do
  unset $ruby_env_var
done

#{install_dir}/embedded/bin/omnibus-ctl graylog #{install_dir}/embedded/service/omnibus-ctl $@
       EOH
    end
  end

  command "chmod 755 #{install_dir}/embedded/bin/graylog-ctl"

  # additional omnibus-ctl commands
  sync "#{project_dir}/", "#{install_dir}/embedded/service/omnibus-ctl/"
end
