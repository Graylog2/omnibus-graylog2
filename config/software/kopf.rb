name "kopf"
default_version "1.0"

dependency "elasticsearch"

source url: "https://github.com/lmenezes/elasticsearch-kopf/archive/1.0.zip",
       md5: "73210c723911eaf7e92726dd869b8152"

relative_path "elasticsearch-kopf-1.0"

build do
  mkdir  "#{install_dir}/elasticsearch/plugins/kopf"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch/plugins/kopf"
end
