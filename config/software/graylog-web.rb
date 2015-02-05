name "graylog-web"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc'
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "6658cb3d5c0c47483c77af4162a3641b"
  relative_path "graylog-web-interface-#{version}"
else
  source url: "http://packages.graylog2.org/releases/graylog-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "811138fe8b7b2bd061e865a4775d9951"
relative_path "graylog-web-interface-#{version}"
end

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
