name "graylog2-web"
default_version "0.90.0"

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog2-web-interface-0.90.0.tgz",
       md5: "2ec07487ce6a98d7ec63c52888bb1ab4"

relative_path "graylog2-web-interface-0.90.0"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
