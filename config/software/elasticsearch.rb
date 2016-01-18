name "elasticsearch"
default_version "2.1.1"

dependency "jdk"
dependency "runit"

source url: "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-#{version}.tar.gz",
       md5: "922e8bc6f140ce44270b8096f5f6f920"

relative_path "elasticsearch-#{version}"

build do
  mkdir  "#{install_dir}/elasticsearch"
  mkdir  "#{install_dir}/elasticsearch/plugins"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch"
end
