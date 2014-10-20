name "graylog2-web"
default_version "0.91.1"

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog2-web-interface-0.91.1.tgz",
       md5: "a7d1387fd34ae2f031448f469147bd31"

relative_path "graylog2-web-interface-0.91.1"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
