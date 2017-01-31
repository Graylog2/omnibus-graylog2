name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '2.2.0-beta.6'
build_iteration  1

override :ruby,       version: "2.3.3",
                        source: { md5: "e485f3a55649eb24a1e2e1a40bc120df" }
override :'chef-gem', version: "12.6.0"
override :'openssl',  version: "1.0.2k",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.2k.tar.gz",
                        md5: "f965fc0bf01bf882b31314b61391ae65" }
override :'cacerts',  version: "2016-09-14",
                      source: {
                        url: "https://curl.haxx.se/ca/cacert-2017-01-18.pem",
                        md5: "38cd779c9429ab6e2e5ae3437b763238" }

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
