Graylog Omnibus Project
========================
This project creates full-stack platform-specific packages for
`Graylog`!

Download
--------
You can download Graylog stable as _Ubuntu_ package [here](https://packages.graylog2.org/releases/graylog2-omnibus/ubuntu/graylog_latest.deb)

Or Graylog beta/rc build from [here](https://packages.graylog2.org/releases/graylog2-omnibus/ubuntu/graylog_beta.deb)

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
$ sudo bin/omnibus build graylog
```

Currently we support only Ubuntu 14.04

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ sudo bin/omnibus clean graylog
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/graylog`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ sudo bin/omnibus clean graylog --purge
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
$ sudo graylog-ctl reconfigure
```

You can access Graylog through the web interface `http://<yourServerIp/hostName>` now.

In order to set another admin password you can also use `graylog-ctl`

```shell
$ sudo graylog-ctl set-admin-password sEcrEtPaSsword!
$ sudo graylog-ctl reconfigure
```

At this point all services run on one box which is fine for very small setups or evaluation purpose. However to scale out from this _all-in-one_ box you can create more VMs with only single
services running. A good start is to let the web-interface run on a separate machine.

```shell
vm2> sudo graylog-ctl set-cluster-master <ip-of-first-box>
vm2> sudo graylog-ctl reconfigure-as-webinterface
```

In the same way you can decouple Elasticsearch from the first _all-in-one_ box. You should have
two Elasticsearch nodes at least. More nodes provide higher message rates for bigger setups.

```shell
vm3> sudo graylog-ctl set-cluster-master <ip-of-first-box>
vm3> sudo graylog-ctl reconfigure-as-datanode
```

and the second Elasticsearch node
 
```shell
vm4> sudo graylog-ctl set-cluster-master <ip-of-first-box>
vm4> sudo graylog-ctl reconfigure-as-datanode
```

Now you can go back to first box and disable the web interface and the local Elasticsearch

```shell
$ sudo graylog-ctl reconfigure-as-server
```

Custom setting
-----
After install the graylog you may want to do some custom configuration,you could achive this by overwriting the settings file ```/etc/graylog/graylog-settings.json```.

>**Note**
>You need run ```graylog-ctl reconfigure``` first.

For example if you want to change the Graylog user, you can edit graylog-settings.json to the following:
```json
"custom_attributes": {
    "user": {
      "username": "log-user"
    }
  }
```
Afterwards run ```sudo graylog-ctl reconfigure``` and```sudo chown -R log-user /var/opt/graylog/data/*```

To change the data-path edit the file to this:
```json
"custom_attributes": {
    "elasticsearch": {
      "data_directory": "/data/elasticsearch"
    },
    "mongodb": {
      "data_directory": "/data/mongodb"
    },
    "etcd": {
      "data_directory": "/data/etcd"
    },
    "graylog-server": {
      "journal_directory": "/data/journal"
    }
  }
 ```
Again, afterwards run ```sudo graylog-ctl reconfigure```

You could find all the available attributes [here](https://github.com/Graylog2/omnibus-graylog2/blob/1.1/files/graylog-cookbooks/graylog/attributes/default.rb).
