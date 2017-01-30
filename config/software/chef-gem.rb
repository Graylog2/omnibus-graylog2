name "chef-gem"
default_version "12.6.0"

dependency "ruby"
dependency "rubygems"
dependency "libffi"
dependency "ohai"

build do
  gem "install net-ssh -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v 2.9.4"
  gem "install net-ssh-gateway -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v 1.2.0"
  gem "install net-ssh-multi -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v 1.2.1"
  gem "install rack -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v 1.6.4"
  gem "install chef-config -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{version}"
  gem "install chef -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{version}"
end
