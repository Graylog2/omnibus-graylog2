name "graylog-server"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc' or version.include? 'SNAPSHOT'
  #source url: "http://packages.graylog2.org/releases/graylog2-server/graylog-#{version}.tgz",
  source url: "https://packages.graylog2.org/nightly-builds/graylog-#{version}.tar.gz",
         md5: "d41d8cd98f00b204e9800998ecf8427e"
else
  source url: "http://packages.graylog2.org/releases/graylog2-server/graylog-#{version}.tgz",
         md5: "cf5929269589cb1518d15b03b5b9ef2d"
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
  delete "#{project_dir}/lib/sigar/libsigar-*s390x*"
  delete "#{project_dir}/lib/sigar/libsigar-*ia64*"

  mkdir "#{install_dir}/server"
  mkdir "#{install_dir}/plugin"
  mkdir "#{install_dir}/contentpacks"
  sync  "#{project_dir}/", "#{install_dir}/server"
	sync  "#{project_dir}/plugin/", "#{install_dir}/plugin/"
	sync  "#{project_dir}/data/contentpacks/", "#{install_dir}/contentpacks/"
end
