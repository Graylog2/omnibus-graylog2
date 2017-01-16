name "zlib"
default_version "1.2.11"

version "1.2.11" do
  source md5: "1c9f62f0778697a09d36121ead88e08e"
end

source url: "http://zlib.net/zlib-#{version}.tar.gz"

relative_path "zlib-#{version}"

# we omit the omnibus path here because it breaks mac_os_x builds by picking up the embedded libtool
# instead of the system libtool which the zlib configure script cannot handle.
#env = with_embedded_path()
env = with_standard_compiler_flags()
# for some reason zlib needs this flag on solaris (cargocult warning?)
env['CFLAGS'] << " -DNO_VIZ" if Ohai['platform'] == 'solaris2'

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make -j #{max_build_jobs} install", :env => env
end
