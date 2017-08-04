name "elasticsearch-migration"
default_version "2.0.4"

dependency "elasticsearch"

source url: "https://github.com/elastic/elasticsearch-migration/archive/v#{version}.zip",
       md5: "6158bb5053c374fb551423ebf7ba11ee"

relative_path "elasticsearch-migration-#{version}"

build do
  mkdir  "#{install_dir}/elasticsearch/plugins/migration"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch/plugins/migration"
end
