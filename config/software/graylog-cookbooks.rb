name "graylog-cookbooks"

dependency "rsync"

source :path => File.expand_path("files/graylog-cookbooks", RbConfig::CONFIG['project_root'])

build do
  mkdir "#{install_dir}/embedded/cookbooks"
  sync  "#{project_dir}/", "#{install_dir}/embedded/cookbooks"
end
