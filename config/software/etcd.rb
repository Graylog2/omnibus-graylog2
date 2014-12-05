name "etcd"
default_version "v0.5.0-alpha.4"
gem_version = "0.2.4"

dependency "openssl"
dependency "ruby"
dependency "rubygems"

source :url => "https://github.com/coreos/etcd/releases/download/#{version}/etcd-#{version}-linux-amd64.tar.gz",
       :md5 => "16993f1016daf55ed802b92f7daedbaa"

relative_path "etcd-#{version}-linux-amd64"

build do
  copy "#{project_dir}/etcdctl", "#{install_dir}/embedded/bin"
  copy "#{project_dir}/etcd", "#{install_dir}/embedded/sbin"

  gem "install etcd -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{gem_version}"
end
