name "mongodb"
default_version "3.4.1"
gem_version = "2.4.1"

dependency "runit"
dependency "ruby"
dependency "rubygems"

source url: "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-#{version}.tgz",
       md5: "8f5ce8185e14ff54bde0984305e1833c"

relative_path "mongodb-linux-x86_64-#{version}"

build do
  mkdir "#{install_dir}/mongodb"
  sync  "#{project_dir}/", "#{install_dir}/mongodb"

  gem "install mongo -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{gem_version}"
end
