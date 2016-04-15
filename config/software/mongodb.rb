name "mongodb"
default_version "3.2.5"

dependency "runit"

source url: "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-#{version}.tgz",
       md5: "aecc4de30d37903776ba192f4359c717"

relative_path "mongodb-linux-x86_64-#{version}"

build do
  mkdir "#{install_dir}/mongodb"
  sync  "#{project_dir}/", "#{install_dir}/mongodb"
end
