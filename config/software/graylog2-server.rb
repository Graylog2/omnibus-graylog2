name "graylog2-server"
default_version project.build_version

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-server/graylog2-server-#{version}.tgz",
       md5: "3041aa6a8dff54cc08db5f7da2d01e52"

relative_path "graylog2-server-#{version}"

build do
  mkdir "#{install_dir}/server"
  mkdir "#{install_dir}/plugin"
  sync  "#{project_dir}/", "#{install_dir}/server"
end
