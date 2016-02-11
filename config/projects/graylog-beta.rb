name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '2.0.0-alpha.2'
build_iteration  1

override :ruby,       version: "2.1.8",
                        source: { md5: "091b62f0a9796a3c55de2a228a0e6ef3" }
override :'chef-gem', version: "12.6.0"
override :'openssl',  version: "1.0.1r",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.1r.tar.gz",
                        md5: "1abd905e079542ccae948af37e393d28" }
override :'cacerts',  version: "2016.01.20",
                      source: {
                        url: "https://raw.githubusercontent.com/bagder/ca-bundle/dfcc02c918b7bf40ed3a7f27a634c74ef4e80829/ca-bundle.crt",
                        md5: "36eee0e80373937dd90a9a334ae42817" }

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
