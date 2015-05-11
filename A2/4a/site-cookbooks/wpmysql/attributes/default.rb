#
# Author:: Barry Steinglass (<barry@opscode.com>)
# Author:: Koseki Kengo (<koseki@gmail.com>)
# Author:: Lucas Hansen (<lucash@opscode.com>)
# Author:: Julian C. Dunn (<jdunn@getchef.com>)
#
# Cookbook Name:: wpmysql
# Attributes:: wpmysql
#
# Copyright 2009-2013, Chef Software, Inc.
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

# General settings
default['wpmysql']['db']['root_password'] = 'my_root_password'
default['wpmysql']['db']['instance_name'] = 'default'
default['wpmysql']['db']['name'] = "wordpressdb"
default['wpmysql']['db']['user'] = "wordpressuser"
default['wpmysql']['db']['pass'] = nil
default['wpmysql']['db']['prefix'] = 'wp_'
default['wpmysql']['db']['host'] = 'localhost'
default['wpmysql']['db']['port'] = '3306'  # Must be a string
default['wpmysql']['db']['charset'] = 'utf8'
default['wpmysql']['db']['collate'] = ''
case node['platform']
when 'ubuntu'
  case node['platform_version']
  when '10.04'
    default['wpmysql']['db']['mysql_version'] = '5.1'
  else
    default['wpmysql']['db']['mysql_version'] = '5.5'
  end
when 'centos', 'redhat'
  if node['platform_version'].to_i < 6
    default['wpmysql']['db']['mysql_version'] = '5.0'
  elsif node['platform_version'].to_i < 7
    default['wpmysql']['db']['mysql_version'] = '5.1'
  else
    default['wpmysql']['db']['mysql_version'] = '5.5'
  end
else
  default['wpmysql']['db']['mysql_version'] = '5.5'
end


default['wpmysql']['config_perms'] = 0644
default['wpmysql']['server_aliases'] = [node['fqdn']]
