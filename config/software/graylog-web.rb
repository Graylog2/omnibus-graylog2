name "graylog-web"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc' or version.include? 'SNAPSHOT'
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "47a4445586fef210699b7dbb9c8558c9"
else
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "bbfe7edb069582bf926d7cbc5abd42d9"
end

relative_path "graylog-web-interface-#{version}"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
