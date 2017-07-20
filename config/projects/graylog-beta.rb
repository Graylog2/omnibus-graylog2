name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '2.3.0-rc.2'
build_iteration  3

conflict 'graylog-server'

override :ruby,       version: "2.4.1"
override :'chef-gem', version: "13.2.20"
override :'openssl',  version: "1.0.2l",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.2l.tar.gz",
                        md5: "f85123cd390e864dfbe517e7616e6566" }
override :'cacerts',  version: "2017-06-07",
                      source: {
                        url: "https://curl.haxx.se/ca/cacert-2017-06-07.pem",
                        md5: "9d8c2e9a93881cdf1f2a7fc3d01a6318" }

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
