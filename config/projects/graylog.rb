name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '2.4.1'
build_iteration  1

conflict 'graylog-server'

override :ruby,       version: "2.1.10",
                        source: { md5: "c212fdeed9534ec7cb9bf13c0bf4d1d5" }
override :'chef-gem', version: "12.6.0"
override :'openssl',  version: "1.0.2n",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.2n.tar.gz",
                        md5: "13bdc1b1d1ff39b6fd42a255e74676a4" }
override :'cacerts',  version: "2017-01-18",
                      source: {
                        url: "https://curl.haxx.se/ca/cacert-2018-01-17.pem",
                        md5: "df0df092f7590ce0cc636986f1ae084b" }

dependency "prepare"
dependency "chef-gem"
dependency "runit"
dependency "jdk"
dependency "elasticsearch"
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
