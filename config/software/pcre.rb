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
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--enable-pcretest-libedit"].join(" "), :env => configure_env
  command("make -j #{max_build_jobs}",
          :env => {
            "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
          })
  command "make install"
end

