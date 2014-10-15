name "graylog2-server"
default_version "0.90.0"

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-server/graylog2-server-0.90.0.tgz",
       md5: "e48696814aaf0ad01921633de32dfa9b"

relative_path "graylog2-server-0.90.0"

build do
  mkdir "#{install_dir}/server"
  mkdir "#{install_dir}/plugin"
  sync  "#{project_dir}/", "#{install_dir}/server"
end
