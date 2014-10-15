name "graylog2-cookbooks"

dependency "rsync"

always_build true

source :path => File.expand_path("files/graylog2-cookbooks", Config.project_root)

build do
  mkdir "#{install_dir}/embedded/cookbooks"
  sync  "#{project_dir}/", "#{install_dir}/embedded/cookbooks"
end
