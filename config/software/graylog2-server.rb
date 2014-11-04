name "graylog2-server"
default_version "0.91.3"

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-server/graylog2-server-0.91.3.tgz",
       md5: "0456ea149ea69a3c2b455889cced8400"

relative_path "graylog2-server-0.91.3"

build do
  mkdir "#{install_dir}/server"
  mkdir "#{install_dir}/plugin"
  sync  "#{project_dir}/", "#{install_dir}/server"
end
