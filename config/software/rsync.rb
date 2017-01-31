name "rsync"
default_version "3.1.2"

dependency "popt"

version "3.1.2" do
  source md5: "0f758d7e000c0f7f7d3792610fad70cb"
end

source url: "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"

relative_path "rsync-#{version}"
env = with_standard_compiler_flags()

build do
  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --disable-iconv", :env => env

  command "make -j #{workers} ", :env => env
  command "make install", :env => env
end
