name "graylog-server"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc'
  source url: "http://packages.graylog2.org/releases/graylog2-server/graylog-#{version}.tgz",
         md5: "0cc65bbe42b95002f2c279b6c665e7ec"

  whitelist_file "/opt/graylog/server/lib/sigar/*"  
  relative_path "graylog-#{version}"
else
  source url: "http://packages.graylog2.org/releases/graylog-server/graylog-server-#{version}.tgz",
         md5: "777d53f5f4f12e9e6ce8374d99fe0176"

  relative_path "graylog-server-#{version}"
end


build do
  mkdir "#{install_dir}/server"
  mkdir "#{install_dir}/plugin"
  sync  "#{project_dir}/", "#{install_dir}/server"
end
