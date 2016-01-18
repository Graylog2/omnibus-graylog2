name "kopf"
default_version "2.0"

dependency "elasticsearch"

source url: "https://github.com/lmenezes/elasticsearch-kopf/archive/#{version}.zip",
       md5: "e1ead54ba635fc31c5475625a89df8ac"

relative_path "elasticsearch-kopf-#{version}"

build do
  mkdir  "#{install_dir}/elasticsearch/plugins/kopf"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch/plugins/kopf"
end
