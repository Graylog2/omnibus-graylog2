name "post-install"

always_build true

source :path => File.expand_path("files/docker", Config.project_root)

build do
  mkdir "#{install_dir}/embedded/share/docker"
  copy "#{project_dir}/docker_environment", "#{install_dir}/embedded/share/docker/"
  copy "#{project_dir}/run_graylogctl", "#{install_dir}/embedded/share/docker/"
  copy "#{project_dir}/my_init", "#{install_dir}/embedded/share/docker/"
end
