name "graylog-web"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc' or version.include? 'SNAPSHOT'
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "8aa434e4cf52e45931ad2160a8dc6b94"
else
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "ffde989ec88cf41097a7083454d2d894"
end

relative_path "graylog-web-interface-#{version}"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
