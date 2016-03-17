name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '1.3.4'
build_iteration  2

override :ruby,       version: "2.1.4"
override :'chef-gem', version: "12.4.1"
override :'openssl',  version: "1.0.1s",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.1s.tar.gz",
                        md5: "562986f6937aabc7c11a6d376d8a0d26" }
override :'cacerts',  version: "2016.01.20",
                      source: {
                        url: "https://raw.githubusercontent.com/bagder/ca-bundle/dfcc02c918b7bf40ed3a7f27a634c74ef4e80829/ca-bundle.crt",
                        md5: "36eee0e80373937dd90a9a334ae42817" }

dependency "prepare"
dependency "chef-gem"
dependency "runit"
dependency "server-jre"
dependency "elasticsearch"
dependency "kopf"
dependency "mongodb"
dependency "nginx"
dependency "etcd"
dependency "graylog-server"
dependency "graylog-web"
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
