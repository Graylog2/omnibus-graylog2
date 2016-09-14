name "cacerts"

default_version "2016-04-20"

source url: "https://curl.haxx.se/ca/cacert-#{version}.pem"

version "2016-04-20" do
  source md5: "782dcde8f5d53b1b9e888fdf113c42b9"
end

version "2016.01.20" do
  source md5: "06629db7f712ff3a75630eccaecc1fe4"
  source url: "https://curl.haxx.se/ca/cacert-2016-01-20.pem"
end

relative_path "cacerts-#{version}"

build do
  mkdir "#{install_dir}/embedded/ssl/certs"

  copy "#{project_dir}/cacert*.pem", "#{install_dir}/embedded/ssl/certs/cacert.pem"

  # Windows does not support symlinks
  unless windows?
    link "#{install_dir}/embedded/ssl/certs/cacert.pem", "#{install_dir}/embedded/ssl/cert.pem"

    block { File.chmod(0644, "#{install_dir}/embedded/ssl/certs/cacert.pem") }
  end
end
