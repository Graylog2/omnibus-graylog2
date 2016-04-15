name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '2.0.0'
build_iteration  1

override :ruby,       version: "2.1.8",
                        source: { md5: "091b62f0a9796a3c55de2a228a0e6ef3" }
override :'chef-gem', version: "12.6.0"
override :'openssl',  version: "1.0.1s",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.1s.tar.gz",
                        md5: "562986f6937aabc7c11a6d376d8a0d26" }
override :'cacerts',  version: "2016.01.20",
                      source: {
                        url: "https://curl.haxx.se/ca/cacert.pem",
                        md5: "06629db7f712ff3a75630eccaecc1fe4" }

dependency "prepare"
dependency "chef-gem"
dependency "runit"
dependency "jdk"
dependency "elasticsearch"
dependency "kopf"
dependency "mongodb"
dependency "nginx"
dependency "etcd"
dependency "graylog-server"
dependency "graylog-ctl"
dependency "graylog-cookbooks"
dependency "post-install"
if linux?
  dependency "authbind"
end

exclude '\.git*'
exclude 'bundler\/git'

package_user 'root'
package_group 'root'
