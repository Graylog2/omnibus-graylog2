name "graylog-server"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc'
  source url: "http://packages.graylog2.org/releases/graylog2-server/graylog-#{version}.tgz",
         md5: "0055bd443c822d6e4901b14e0cd2ac13"
else
  source url: "http://packages.graylog2.org/releases/graylog2-server/graylog-#{version}.tgz",
         md5: "845669cfedb67f3d4dc6259cda6cf1f2"
end

whitelist_file "/opt/graylog/server/lib/sigar/*"
relative_path "graylog-#{version}"


build do
  delete "#{project_dir}/lib/sigar/sigar-*winnt*"
  delete "#{project_dir}/lib/sigar/libsigar-*freebsd*"
  delete "#{project_dir}/lib/sigar/libsigar-*solaris*"
  delete "#{project_dir}/lib/sigar/libsigar-*hpux*"
  delete "#{project_dir}/lib/sigar/libsigar-*ppc*"
  delete "#{project_dir}/lib/sigar/libsigar-*macosx*"

  mkdir "#{install_dir}/server"
  mkdir "#{install_dir}/plugin"
  sync  "#{project_dir}/", "#{install_dir}/server"
	sync  "#{project_dir}/plugin/", "#{install_dir}/plugin/"
end
