name "mongodb"
default_version "3.2.1"

dependency "runit"

source url: "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-#{version}.tgz",
       md5: "299bb9c72be5d856baee2c36dd9c776e"

relative_path "mongodb-linux-x86_64-#{version}"

build do
  mkdir "#{install_dir}/mongodb"
  sync  "#{project_dir}/", "#{install_dir}/mongodb"
end
