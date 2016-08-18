name "graylog-server"
default_version project.build_version

dependency "jdk"
dependency "runit"

if version.include? '-alpha' or version.include? '-beta' or version.include? '-rc' or version.include? 'SNAPSHOT'
  source url: "http://packages.graylog2.org/releases/graylog/graylog-#{version}.tgz",
         md5: "82d7607ad24c0b446b3af6f885f39633"
else
  source url: "http://packages.graylog2.org/releases/graylog/graylog-#{version}.tgz",
         md5: "8a5a834aecf73ed4aba92c18ee9eebf1"
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

  delete "#{install_dir}/server/plugin"
  delete "#{install_dir}/server/data/contentpacks"
end
