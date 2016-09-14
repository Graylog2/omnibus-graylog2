name "pcre"
default_version "8.39"

dependency "libedit"
dependency "ncurses"

source :url => "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.39.tar.gz",
       :md5 => "26a76d97e04c89fe9ce22ecc1cd0b315"

relative_path "pcre-8.39"

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

