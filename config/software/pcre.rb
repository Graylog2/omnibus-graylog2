name "pcre"
default_version "8.41"

dependency "libedit"
dependency "ncurses"

source :url => "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.41.tar.gz",
       :md5 => "2e7896647ee25799cb454fe287ffcd08"

relative_path "pcre-8.41"

configure_env = {
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include"
}

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --disable-cpp" \
          " --enable-utf" \
          " --enable-unicode-properties" \
          " --enable-pcretest-libedit", env: env

  make "-j #{workers}", env: env
  make "install", env: env
end

