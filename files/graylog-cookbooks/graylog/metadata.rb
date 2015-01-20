name             "graylog"
maintainer       "Marius Sturm"
maintainer_email "hello@torch.sh"
license          "Apache 2.0"
description      "Install and configure Graylog from Omnibus"
long_description "Install and configure Graylog from Omnibus"
version          "0.0.1"
recipe           "graylog", "Configures Graylog from Omnibus"

supports "ubuntu"

depends "runit"
depends "timezone-ii"
