name "post-install"

source :path => File.expand_path("files", RbConfig::CONFIG['project_root'])

build do
  mkdir "#{install_dir}/embedded/share/docker"
  copy "#{project_dir}/docker/docker_environment", "#{install_dir}/embedded/share/docker/"
  copy "#{project_dir}/docker/run_graylogctl", "#{install_dir}/embedded/share/docker/"
  copy "#{project_dir}/docker/my_init", "#{install_dir}/embedded/share/docker/"
  copy "#{project_dir}/data/contentpacks/content_pack_appliance.json", "#{install_dir}/contentpacks/"
end
