name 'graylog2'
maintainer 'Marius Sturm'
homepage 'https://graylog2.org'

install_dir     '/opt/graylog2'
build_version   '0.91.3'
build_iteration  1

dependency "prepare"
dependency "chef-gem"
dependency "runit"
dependency "server-jre"
dependency "elasticsearch"
dependency "mongodb"
dependency "nginx"
dependency "etcd"
dependency "graylog2-server"
dependency "graylog2-web"
dependency "graylog2-ctl"
dependency "graylog2-cookbooks"
dependency "post-install"
if linux?
  dependency "authbind"
end

exclude '\.git*'
exclude 'bundler\/git'

package_user 'root'
package_group 'root'
