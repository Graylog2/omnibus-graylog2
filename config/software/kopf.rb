name "kopf"
default_version "2.1.2"

dependency "elasticsearch"

source url: "https://github.com/lmenezes/elasticsearch-kopf/archive/v#{version}.zip",
       md5: "868457f3e88ecf6782fa87c9f92928ae"

relative_path "elasticsearch-kopf-#{version}"

build do
  mkdir  "#{install_dir}/elasticsearch/plugins/kopf"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch/plugins/kopf"
end
