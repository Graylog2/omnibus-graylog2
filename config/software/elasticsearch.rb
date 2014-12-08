name "elasticsearch"
default_version "1.4.1"

dependency "server-jre"
dependency "runit"

source url: "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.1.tar.gz",
       md5: "e0fdc0b7c64f56b353df32a96325ece8"

relative_path "elasticsearch-1.4.1"

build do
  mkdir  "#{install_dir}/elasticsearch"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch"
end
