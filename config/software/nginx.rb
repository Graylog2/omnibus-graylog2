name "nginx"
default_version "1.9.10"

dependency "pcre"
dependency "openssl"

source :url => "http://nginx.org/download/nginx-#{version}.tar.gz",
       :md5 => "64cc970988356a5e0fc4fcd1ab84fe57"

relative_path "nginx-#{version}"

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--conf-path=#{install_dir}/conf/nginx/nginx.conf",
           "--http-log-path=/var/log/graylog/nginx/access.log",
           "--error-log-path=/var/log/graylog/nginx/error.log",
           "--with-http_ssl_module",
           "--with-http_stub_status_module",
           "--with-ipv6",
           "--with-debug",
           "--with-ld-opt=-L#{install_dir}/embedded/lib",
           "--with-cc-opt=\"-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include\""].join(" ")
  command "make -j #{workers}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "make install"

  command "mkdir -p /var/log/graylog/nginx"
end
