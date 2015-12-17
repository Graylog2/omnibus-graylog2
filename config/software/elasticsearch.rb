name "elasticsearch"
default_version "1.7.3"

dependency "server-jre"
dependency "runit"

source url: "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.3.tar.gz",
       md5: "2027ed1968a944618417e693f51cfe0c"

relative_path "elasticsearch-1.7.3"

build do
  mkdir  "#{install_dir}/elasticsearch"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch"
end
