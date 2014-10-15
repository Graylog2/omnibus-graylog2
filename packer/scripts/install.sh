#!/bin/bash

wget -O /tmp/graylog2.deb http://192.168.1.17:8000/graylog2_omnibus-latest.deb
dpkg -i /tmp/graylog2.deb
rm /tmp/graylog2.deb
