name 'graylog'
maintainer 'Marius Sturm'
homepage 'https://graylog.org'

install_dir     '/opt/graylog'
build_version   '1.1.2'
build_iteration  2

override :ruby,       version: "2.1.4"
override :'chef-gem', version: "12.2.1"

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
