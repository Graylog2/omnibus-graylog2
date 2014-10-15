name "mongodb"
default_version "2.6.4"

dependency "runit"

source url: "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.6.4.tgz",
       md5: "484f07082803e21691ece39fa9e1292b"

relative_path "mongodb-linux-x86_64-2.6.4"

build do
  mkdir "#{install_dir}/mongodb"
  sync  "#{project_dir}/", "#{install_dir}/mongodb"
end
