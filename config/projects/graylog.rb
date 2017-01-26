name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '2.1.3'
build_iteration  1

override :ruby,       version: "2.1.8",
                        source: { md5: "091b62f0a9796a3c55de2a228a0e6ef3" }
override :'chef-gem', version: "12.6.0"
override :'openssl',  version: "1.0.1u",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.1u.tar.gz",
                        md5: "130bb19745db2a5a09f22ccbbf7e69d0" }
override :'cacerts',  version: "2016-04-20",
                      source: {
                        url: "https://curl.haxx.se/ca/cacert-2016-09-14.pem",
                        md5: "8d35a5cef6ce28da07867a0712558067" }

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
