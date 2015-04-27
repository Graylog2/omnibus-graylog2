name "elasticsearch"
default_version "1.4.5"

dependency "server-jre"
dependency "runit"

source url: "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.5.tar.gz",
       md5: "01b6f3317c50a1b6964a56494363cc49"

relative_path "elasticsearch-1.4.4"

build do
  mkdir  "#{install_dir}/elasticsearch"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch"
end
