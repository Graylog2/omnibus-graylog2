#
# Copyright 2013-2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "jdk"
default_version "8u172"
relative_path "jdk1.8.0_172"

whitelist_file "jre/bin/javaws"
whitelist_file "jre/bin/policytool"
whitelist_file "jre/lib"
whitelist_file "jre/plugin"
whitelist_file "jre/bin/appletviewer"

if _64_bit?
  source url:     "http://download.oracle.com/otn-pub/java/jdk/#{version}-b11/a58eab1ec242421181065cdc37240b08/jdk-#{version}-linux-x64.tar.gz",
         md5:     "eda2945e8c02b84adbf78f46c37b71c1",
         cookie:  "gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie",
         warning: "By including the JRE, you accept the terms of the Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX, which can be found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html"
else
  raise "Server-jre can only be installed on x86_64 systems."
end

build do
  mkdir "#{install_dir}/embedded/jre"
  delete "#{project_dir}/bin/ControlPanel"
  sync  "#{project_dir}/", "#{install_dir}/embedded/jre"
end
