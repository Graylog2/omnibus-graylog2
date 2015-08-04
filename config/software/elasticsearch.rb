name "elasticsearch"
default_version "1.7.1"

dependency "server-jre"
dependency "runit"

source url: "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz",
       md5: "e086488d92a1d16a2a39236c72cf08fb"

relative_path "elasticsearch-1.7.1"

build do
  mkdir  "#{install_dir}/elasticsearch"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch"
end
