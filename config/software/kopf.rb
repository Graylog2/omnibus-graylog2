name "kopf"
default_version "1.6.2"

dependency "elasticsearch"

source url: "https://github.com/lmenezes/elasticsearch-kopf/archive/v#{version}.zip",
       md5: "2d912373f350f980893e42266daed53f"

relative_path "elasticsearch-kopf-#{version}"

build do
  mkdir  "#{install_dir}/elasticsearch/plugins/kopf"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch/plugins/kopf"
end
