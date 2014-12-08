name "graylog2-web"
default_version "0.92.0"

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog2-web-interface-0.92.0.tgz",
       md5: "1c81ae87353a4c5eb14666ef2b486fbf"

relative_path "graylog2-web-interface-0.92.0"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
