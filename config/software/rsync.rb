name "rsync"
default_version "3.1.2"

dependency "popt"

license_file "COPYING"
skip_transitive_dependency_licensing true

version "3.1.2" do
  source md5: "0f758d7e000c0f7f7d3792610fad70cb"
  license "GPL-3.0"
  license_file "COPYING"
end

source url: "https://rsync.samba.org/ftp/rsync/src/rsync-#{version}.tar.gz"

relative_path "rsync-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --disable-iconv", env: env

  make "-j #{workers}", env: env
  make "install", env: env
end
