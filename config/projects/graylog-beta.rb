name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '2.4.0-beta.1'
build_iteration  2

conflict 'graylog-server'

override :ruby,       version: "2.1.10",
                        source: { md5: "c212fdeed9534ec7cb9bf13c0bf4d1d5" }
override :'chef-gem', version: "12.6.0"
override :'openssl',  version: "1.0.2l",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.2l.tar.gz",
                        md5: "f85123cd390e864dfbe517e7616e6566" }
override :'cacerts',  version: "2017-09-20",
                      source: {
                        url: "https://curl.haxx.se/ca/cacert-2017-09-20.pem",
                        md5: "2aeba46562a9b9117a9217520f67adc0" }

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
