name "graylog2-server"
default_version "0.92.0"

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-server/graylog2-server-0.92.0.tgz",
       md5: "fd6f8e6287c275460a3eb910e8f6ad18"

relative_path "graylog2-server-0.92.0"

build do
  mkdir "#{install_dir}/server"
  mkdir "#{install_dir}/plugin"
  sync  "#{project_dir}/", "#{install_dir}/server"
end
