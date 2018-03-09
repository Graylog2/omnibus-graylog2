name "ohai"
default_version "8.10.0"

dependency "ruby"
dependency "rubygems"
dependency "libffi"

build do
  gem "install ffi-yajl -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v 2.3.0"
  gem "install mixlib-shellout -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v 2.2.7"
  gem "install mixlib-config -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v 2.2.4"
  gem "install ohai -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{version}"
end
