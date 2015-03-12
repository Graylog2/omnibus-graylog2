name "post-install"

always_build true

source :path => File.expand_path("files/docker", Config.project_root)

build do
  mkdir "#{install_dir}/embedded/share/docker"
  copy "#{project_dir}/docker-environment", "#{install_dir}/embedded/share/docker/"
  copy "#{project_dir}/01_run_graylogctl.sh", "#{install_dir}/embedded/share/docker/"
  copy "#{project_dir}/my_init", "#{install_dir}/embedded/share/docker/"
end
