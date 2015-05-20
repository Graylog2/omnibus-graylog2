name "elasticsearch"
default_version "1.5.2"

dependency "server-jre"
dependency "runit"

source url: "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.5.2.tar.gz",
       md5: "b5cecb01d455f516d6c3aaff3af4149f"

relative_path "elasticsearch-1.5.2"

build do
  mkdir  "#{install_dir}/elasticsearch"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch"
end
