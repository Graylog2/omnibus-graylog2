name "graylog2-server"
default_version "0.91.1"

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-server/graylog2-server-0.91.1.tgz",
       md5: "78b27ed1442270549dcb89ab603bb047"

relative_path "graylog2-server-0.91.1"

build do
  mkdir "#{install_dir}/server"
  mkdir "#{install_dir}/plugin"
  sync  "#{project_dir}/", "#{install_dir}/server"
end
