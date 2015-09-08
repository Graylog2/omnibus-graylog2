name "chef-gem"
default_version "11.12.2"

dependency "ruby"
dependency "rubygems"
dependency "libffi"
dependency "ohai"

build do
  gem "install chef-config -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{version}"
  gem "install chef -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{version}"
end
