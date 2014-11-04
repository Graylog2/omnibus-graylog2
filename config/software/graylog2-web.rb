name "graylog2-web"
default_version "0.91.3"

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog2-web-interface-0.91.3.tgz",
       md5: "206403d8c7e1f11f8b33650921552c89"

relative_path "graylog2-web-interface-0.91.3"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
