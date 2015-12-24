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

Customize
----
Sometime we need override the default settings omnibus provides,eg. `data-directory`,`time-zone` etc.
That time,we could make use of the `attributes` override mechanism omnibus provides.

After a fresh install of omnibus,there is a `/etc/graylog` created which contains the `graylog-settings.json` file.
By which we could do our customizing.

1. How to change the default `data-directory` and  `journal_directory`?

   Solution: Add attributes to the `custom_attributes` section,eg.
   ```
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
2. How to change the default `timezone`?

   Solution: Change the `timezone` value to what you like,eg.
   ```
   timezone = "Asia/Chongqing"
   ```

3. How to change the memory `graylog-server` will use?

   Solution: Add attributes to the `custom_attributes` section,eg.
   ```
   "custom_attributes": {
       "graylog-server": {
         "memory": "1700m"
       },
       "elasticsearch": {
         "memory": "2200m"
       }
     }
   ```

4. How to change the `retention_strategy` of `graylog-server` to `close`?

   Solution: Add attributes to the `custom_attributes` section,eg.
   ```
   "custom_attributes": {
       "graylog-server": {
         "retention_strategy": "close"
       }
     }
   ```

**Note:**

After change the `graylog-settings.json`,make sure to trigger the reconfiguration to make it take effect.
```
sudo graylog-ctl reconfigure
```

You can find all the currently available attributes here :
 https://github.com/Graylog2/omnibus-graylog2/blob/1.2/files/graylog-cookbooks/graylog/attributes/default.rb

And in fact you can configure every detail of Graylog by using our Chef or Puppet recipes: https://github.com/Graylog2/graylog2-cookbook
https://github.com/Graylog2/graylog2-puppet