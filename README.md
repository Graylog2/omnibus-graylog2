Graylog Omnibus Project
========================
This project creates full-stack platform-specific packages for
`Graylog`!

Download
--------
You can download pre-build omnibus packages of Graylog [here](https://packages.graylog2.org/appliances/ubuntu).
Those packages are build for _Ubuntu_ 14.04 LTS release.

Installation
------------

The Omnibus package will create all it needs on the host including users and system services. Install it either as
root or a sudo'ed admin user:

```shell
$ sudo dpkg -i graylog_latest.deb
```

Upgrading
---------

*WARNING*: The Graylog omnibus package currently does *not* support upgrading from Graylog 1.x to Graylog 2.0.x!

Usage
-----
You must have a sane Ruby 1.9+ environment with Bundler installed. Ensure all
the required gems are installed:

```shell
$ sudo bundle install --binstubs
```

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

Further documentation can be found [here](http://docs.graylog.org/en/latest/pages/installation/graylog_ctl.html)
