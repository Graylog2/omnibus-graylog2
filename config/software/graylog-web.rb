name "graylog-web"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc' or version.include? 'SNAPSHOT'
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "47a4445586fef210699b7dbb9c8558c9"
else
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "95e6982b93c13c50f7bd681310d86102"
end

relative_path "graylog-web-interface-#{version}"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
