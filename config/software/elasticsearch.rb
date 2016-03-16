name "elasticsearch"
default_version "1.7.5"

dependency "server-jre"
dependency "runit"

source url: "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz",
       md5: "61e89c56488109fdc7361b9d7f8618df"

relative_path "elasticsearch-1.7.5"

build do
  mkdir  "#{install_dir}/elasticsearch"
  mkdir  "#{install_dir}/elasticsearch/plugins"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch"
end
