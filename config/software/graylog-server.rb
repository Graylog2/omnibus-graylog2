name "graylog-server"
default_version project.build_version

dependency "jdk"
dependency "runit"

if version.include? '-alpha' or version.include? '-beta' or version.include? '-rc' or version.include? 'SNAPSHOT'
  source url: "http://packages.graylog2.org/releases/graylog/graylog-#{version}.tgz",
         md5: "6b0c157b8fcef8751923de4eb4002c96"
else
  source url: "http://packages.graylog2.org/releases/graylog/graylog-#{version}.tgz",
         md5: "11780da48ac37f43b619558dab87fb1d"
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
