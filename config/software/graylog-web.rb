name "graylog-web"
default_version project.build_version

dependency "server-jre"
dependency "runit"

if version.include? '-beta' or version.include? '-rc' or version.include? 'SNAPSHOT'
  #source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
  source url: "https://packages.graylog2.org/nightly-builds/graylog-web-interface-1.3.0-SNAPSHOT-20151123175017.tgz",
         md5: "c9dd49a792a36c1ec3f1b182e05c9b93"
else
  source url: "http://packages.graylog2.org/releases/graylog2-web-interface/graylog-web-interface-#{version}.tgz",
         md5: "ffde989ec88cf41097a7083454d2d894"
end

#relative_path "graylog-web-interface-#{version}"
relative_path "graylog-web-interface-1.3.0-SNAPSHOT-20151123175017"

build do
  mkdir "#{install_dir}/web"
  sync  "#{project_dir}/", "#{install_dir}/web"
end
