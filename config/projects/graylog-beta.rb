name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '2.1.0-rc.1'
build_iteration  1

override :ruby,       version: "2.1.8",
                        source: { md5: "091b62f0a9796a3c55de2a228a0e6ef3" }
override :'chef-gem', version: "12.6.0"
override :'openssl',  version: "1.0.1t",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.1t.tar.gz",
                        md5: "9837746fcf8a6727d46d22ca35953da1" }
override :'cacerts',  version: "2016-04-20",
                      source: {
                        url: "https://curl.haxx.se/ca/cacert-2016-04-20.pem",
                        md5: "782dcde8f5d53b1b9e888fdf113c42b9" }

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
