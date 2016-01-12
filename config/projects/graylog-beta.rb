name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '1.3.0-beta.2'
build_iteration  1

override :ruby,       version: "2.1.4"
override :'chef-gem', version: "12.4.1"
override :'openssl',  version: "1.0.1q",
                      source: {
                        url: "https://www.openssl.org/source/openssl-1.0.1q.tar.gz",
                        md5: "54538d0cdcb912f9bc2b36268388205e" }
override :'cacerts',  version: "2015.10.28",
                      source: { md5: "6f41fb0f0c4b4695c2a6296892278141" }

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
