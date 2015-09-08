name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '1.2.0-rc.2'
build_iteration  1

override :ruby,       version: "2.1.4"
override :'chef-gem', version: "12.4.1"
override :'openssl',  version: "1.0.1p",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.1p.tar.gz",
                        md5: "7563e92327199e0067ccd0f79f436976" }
override :'cacerts',  version: "2015.09.02",
                      source: { md5: "3e0e6f302bd4f5b94040b8bcee0ffe15" }

dependency "prepare"
dependency "chef-gem"
dependency "runit"
dependency "server-jre"
dependency "elasticsearch"
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
