name "graylog-web"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc'
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "3be9e1a6bd6b5ea46cbcadf7c74e32af"
else
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "0f9efc572cd79079f909abccf397e345"
end

relative_path "graylog-web-interface-#{version}"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
