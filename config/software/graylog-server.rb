name "graylog-server"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc'
  source url: "http://packages.graylog2.org/releases/graylog2-server/graylog-#{version}.tgz",
         md5: "eb8a857932ac468f14e6471346e8c9a7"
else
  source url: "http://packages.graylog2.org/releases/graylog2-server/graylog-#{version}.tgz",
         md5: "fe23c4b598c72a557dd5f6d8e6ed8bb2"
end

whitelist_file "/opt/graylog/server/lib/sigar/*"
relative_path "graylog-#{version}"


build do
  mkdir "#{install_dir}/server"
  mkdir "#{install_dir}/plugin"
  sync  "#{project_dir}/", "#{install_dir}/server"
end
