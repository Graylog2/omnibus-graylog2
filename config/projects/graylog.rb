name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '1.1.5'
build_iteration  7

override :ruby,       version: "2.1.4"
override :'chef-gem', version: "12.2.1"
override :'openssl',  version: "1.0.2d",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.2d.tar.gz",
                        md5: "38dd619b2e77cbac69b99f52a053d25a" }
override :'cacerts',  version: "2015.04.22",
                      source: { md5: "380df856e8f789c1af97d0da9a243769" }

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
