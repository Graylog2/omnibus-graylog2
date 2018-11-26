name "elasticsearch"
default_version "6.5.1"

dependency "jdk"
dependency "runit"

source url: "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-#{version}.tar.gz",
       md5: "3c899de4c6e79a8d3de77e683ae8d43f"

relative_path "elasticsearch-#{version}"

build do
  mkdir  "#{install_dir}/elasticsearch"
  mkdir  "#{install_dir}/elasticsearch/plugins"
  delete "#{project_dir}/lib/sigar/*solaris*"
  delete "#{project_dir}/lib/sigar/*sparc*"
  delete "#{project_dir}/lib/sigar/*freebsd*"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch"
end
