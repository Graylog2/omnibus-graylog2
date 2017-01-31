name "popt"
default_version "1.16"

source :url => "ftp://anduin.linuxfromscratch.org/BLFS/popt/popt-1.16.tar.gz",
       :md5 => "3743beefa3dd6247a73f8f7a32c14c33"

relative_path "popt-1.16"

env =
  case Ohai['platform']
  when "solaris2"
    {
      "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
    }
  else
    {
      "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
    }
  end

build do
  # --disable-nls => Disable localization support.
  command "./configure --prefix=#{install_dir}/embedded --disable-nls", :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make install"
end
