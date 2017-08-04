name "elasticsearch-migration"
default_version "2.0.4"

dependency "elasticsearch"

source url: "https://github.com/elastic/elasticsearch-migration/releases/download/v#{version}/elasticsearch-migration-#{version}.zip"
       md5: "907c3b39b6511692c3e4c9a9f2c79507"

build do
  mkdir  "#{install_dir}/elasticsearch/plugins/migration"
  sync   "#{project_dir}/", "#{install_dir}/elasticsearch/plugins/migration"
end
