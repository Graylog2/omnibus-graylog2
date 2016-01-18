name "etcd"
default_version "v2.2.4"
gem_version = "0.3.0"

dependency "openssl"
dependency "ruby"
dependency "rubygems"

source :url => "https://github.com/coreos/etcd/releases/download/#{version}/etcd-#{version}-linux-amd64.tar.gz",
       :md5 => "a7fbff6e1f3a6380cbc0100af3b15c5b"

relative_path "etcd-#{version}-linux-amd64"

build do
  copy "#{project_dir}/etcdctl", "#{install_dir}/embedded/bin"
  copy "#{project_dir}/etcd", "#{install_dir}/embedded/sbin"

  gem "install etcd -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{gem_version}"
end
