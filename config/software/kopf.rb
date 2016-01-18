name "kopf"
default_version "2.1.1"

dependency "elasticsearch"

source url: "https://github.com/lmenezes/elasticsearch-kopf/archive/v#{version}.zip",
       md5: "c7a3e1ebdd6c3ceb3ed7d1d1c014ecf7"

relative_path "elasticsearch-kopf-#{version}"

build do
  mkdir  "#{install_dir}/elasticsearch/plugins/kopf"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch/plugins/kopf"
end
