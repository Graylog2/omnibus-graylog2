name "ohai"
default_version "8.10.0"

dependency "ruby"
dependency "rubygems"
dependency "libffi"

build do
  gem "install ohai -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{version}"
end
