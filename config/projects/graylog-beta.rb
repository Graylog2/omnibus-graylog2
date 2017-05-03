name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '2.3.0-alpha.1'
build_iteration  1

conflict 'graylog-server'

override :ruby,       version: "2.1.10",
                        source: { md5: "c212fdeed9534ec7cb9bf13c0bf4d1d5" }
override :'chef-gem', version: "12.6.0"
override :'openssl',  version: "1.0.2k",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.2k.tar.gz",
                        md5: "f965fc0bf01bf882b31314b61391ae65" }
override :'cacerts',  version: "2017-01-18",
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
