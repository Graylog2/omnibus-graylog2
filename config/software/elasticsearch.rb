name "elasticsearch"
default_version "1.7.4"

dependency "server-jre"
dependency "runit"

source url: "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.4.tar.gz",
       md5: "e48000dc581af46a085193c73e00bc53"

relative_path "elasticsearch-1.7.4"

build do
  mkdir  "#{install_dir}/elasticsearch"
  mkdir  "#{install_dir}/elasticsearch/plugins"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch"
end
