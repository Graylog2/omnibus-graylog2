Graylog2 Omnibus Project
========================
This project creates full-stack platform-specific packages for
`Graylog2`!

Installation
------------
You must have a sane Ruby 1.9+ environment with Bundler installed. Ensure all
the required gems are installed:

```shell
$ sudo bundle install --binstubs
```

Usage
-----
### Build

You create a platform-specific package using the `build project` command:

```shell
$ sudo bin/omnibus build graylog2
```

Currently we support only Ubuntu 14.04

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ sudo bin/omnibus clean graylog2
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/graylog2`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ sudo bin/omnibus clean graylog2 --purge
```

### Help

Full help for the Omnibus command line interface can be accessed with the
`help` command:

```shell
$ bin/omnibus help
```

Usage
-----
After installing the omnibus package on your server you have to _reconfigure_ the installation
to setup all configuration files and start all services.

```shell
$ sudo graylog2-ctl reconfigure
```

You can access Graylog2 through the web interface `http://<yourServerIp/hostName>` now.

In order to set another admin password you can also use `graylog2-ctl`

```shell
$ sudo graylog2-ctl set-admin-password sEcrEtPaSsword!
$ sudo graylog2-ctl reconfigure
```

At this point all services run on one box which is fine for very small setups or evaluation purpose. However to scale out from this _all-in-one_ box you can create more VMs with only single
services running. A good start is to let the web-interface run on a separate machine.

```shell
vm2> sudo graylog2-ctl set-cluster-master <ip-of-first-box>
vm2> sudo graylog2-ctl reconfigure-as-webinterface
```

In the same way you can decouple Elasticsearch from the first _all-in-one_ box. You should have
two Elasticsearch nodes at least. More nodes provide higher message rates for bigger setups.

```shell
vm3> sudo graylog2-ctl set-cluster-master <ip-of-first-box>
vm3> sudo graylog2-ctl reconfigure-as-datanode
```

and the second Elasticsearch node
 
```shell
vm4> sudo graylog2-ctl set-cluster-master <ip-of-first-box>
vm4> sudo graylog2-ctl reconfigure-as-datanode
```

Now you can go back to first box and disable the web interface and the local Elasticsearch

```shell
$ sudo graylog2-ctl reconfigure-as-server
```
