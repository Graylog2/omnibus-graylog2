name "graylog2-web"
default_version project.build_version

dependency "server-jre"
dependency "runit"

source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog2-web-interface-#{version}.tgz",
       md5: "371a170243a5cb2a1e18c6a192c18a73"

relative_path "graylog2-web-interface-#{version}"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
