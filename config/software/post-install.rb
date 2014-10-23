name "post-install"

always_build true

source :path => File.expand_path("files/docker", Config.project_root)

build do
 copy "#{project_dir}/runsvdir-docker", "#{install_dir}/embedded/bin"
end
