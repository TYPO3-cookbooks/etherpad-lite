#
# Cookbook Name:: etherpad-lite
# Attributes:: default

default['etherpadlite']['git']['repository'] = 'https://github.com/ether/etherpad-lite.git'
default['etherpadlite']['git']['reference'] = '1.6.6'

default['etherpadlite']['proxy']['enable'] = true
default['etherpadlite']['proxy']['hostname'] = node['fqdn']
default['etherpadlite']['proxy']['alias_hostnames'] = []

default['etherpadlite']['listen']['ip'] = '127.0.0.1'
default['etherpadlite']['listen']['port'] = 9001

default['etherpadlite']['database']['host'] = 'localhost'
default['etherpadlite']['database']['user'] = 'etherpadlite'
default['etherpadlite']['database']['password'] = nil
default['etherpadlite']['database']['name'] = 'etherpadlite'

default['etherpadlite']['settings']['defaultPadText'] = 'Welcome to Etherpad Lite!\\n\\nThis pad text is synchronized as you type, so that everyone viewing this page sees the same text. This allows you to collaborate seamlessly on documents!\\n\\nPlease use this service only for community-related work!\\n\\n'
default['etherpadlite']['settings']['loglevel'] = 'INFO'

# either false or the path to abiword binary (e.g. '/usr/bin/abiword')
default['etherpadlite']['settings']['abiword'] = '/usr/bin/abiword'

default['etherpadlite']['plugins'] = {}

default['nginx']['default_site_enabled'] = false
default['mysql']['bind_address'] = '127.0.0.1'
