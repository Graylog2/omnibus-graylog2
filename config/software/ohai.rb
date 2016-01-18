name "ohai"
default_version "8.8.1"

dependency "ruby"
dependency "rubygems"
dependency "libffi"

build do
  gem "install ohai -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{version}"
end
