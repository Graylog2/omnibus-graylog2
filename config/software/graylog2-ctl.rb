name "graylog2-ctl"

dependency "rsync"
dependency "omnibus-ctl"

source :path => File.expand_path("files/graylog2-ctl-commands", Config.project_root)

build do
  block do
    open("#{install_dir}/embedded/bin/graylog2-ctl", "w") do |file|
      file.print <<-EOH
#!/bin/bash

# Ruby environment if graylog2-ctl is called from a Ruby script.
for ruby_env_var in RUBYOPT \\
                    BUNDLE_BIN_PATH \\
                    BUNDLE_GEMFILE \\
                    GEM_PATH \\
                    GEM_HOME
do
  unset $ruby_env_var
done

#{install_dir}/embedded/bin/omnibus-ctl graylog2 #{install_dir}/embedded/service/omnibus-ctl $@
       EOH
    end
  end

  command "chmod 755 #{install_dir}/embedded/bin/graylog2-ctl"

  # additional omnibus-ctl commands
  sync "#{project_dir}/", "#{install_dir}/embedded/service/omnibus-ctl/"
end
